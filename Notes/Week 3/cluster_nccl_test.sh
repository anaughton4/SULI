#!/usr/bin/env bash

set -e  # Exit instantly if any command fails

# CONFIGURATION - UPDATE THESE IP ADDRESSES FOR YOUR SPARKS
SPARK_A_IP="169.254.130.156"
SPARK_B_IP="169.254.155.56"

# 1. SETUP WORKING DIRECTORIES AND CONFIG
WORKSPACE_DIR="/home/badger/nccl_workspace"
mkdir -p "${WORKSPACE_DIR}"
cd "${WORKSPACE_DIR}"

export CUDA_HOME="/usr/local/cuda"
export PATH="${CUDA_HOME}/bin:${PATH}"
export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"

# Grace Blackwell ARM64 path for OpenMPI on DGX OS
export MPI_HOME="/usr/lib/aarch64-linux-gnu/openmpi"
export PATH="${MPI_HOME}/bin:${PATH}"

# Define NCCL_HOME so we can use it during build and execution
export NCCL_HOME="${WORKSPACE_DIR}/nccl_local_install"

echo "=========================================="
echo "🚀 Target workspace: ${WORKSPACE_DIR}"
echo "🔹 Using CUDA from:  ${CUDA_HOME}"
echo "🔹 Using MPI from:   ${MPI_HOME}"
echo "🔹 NCCL Install Dir: ${NCCL_HOME}"
echo "=========================================="

# 2. DETECT GPU ARCHITECTURE FOR NCCL COMPILATION
if command -v nvcc &> /dev/null; then
    CUDA_VERSION=$(nvcc --version | grep "release" | awk '{print $6}' | cut -c2-3)
    echo "✔ Found CUDA compiler (NVCC)."
else
    echo "❌ Error: nvcc not found at ${CUDA_HOME}/bin. Check CUDA installation."
    exit 1
fi

# 3. CLONE AND BUILD CORE NCCL LIBRARY (WITH SMART SKIP)
echo "------------------------------------------"
if [ -f "${NCCL_HOME}/lib/libnccl.so" ]; then
    echo "⏩ Core NCCL library already built at ${NCCL_HOME}. Skipping build."
else
    echo "📦 Cloning and building NVIDIA NCCL library..."
    if [ ! -d "nccl" ]; then
        git clone https://github.com/NVIDIA/nccl.git
    else
        echo "ℹ Repository 'nccl' already exists. Skipping clone."
    fi
    cd nccl
    make clean
    make -j$(nproc) src.build PREFIX="${NCCL_HOME}"
    make install PREFIX="${NCCL_HOME}"
    cd ..
fi

# 4. CLONE AND RECOMPILE NCCL TESTS WITH MPI SUPPORT (WITH SMART SKIP)
echo "------------------------------------------"
if [ -f "${WORKSPACE_DIR}/nccl-tests/build/all_reduce_perf_mpi" ]; then
    echo "⏩ NCCL MPI tests already compiled. Skipping build."
else
    echo "📦 Cloning and building NCCL Tests suite with MPI enabled..."
    if [ ! -d "nccl-tests" ]; then
        git clone https://github.com/NVIDIA/nccl-tests.git
    else
        echo "ℹ Repository 'nccl-tests' already exists. Recompiling."
    fi
    cd nccl-tests
    make clean
    make -j$(nproc) MPI=1 NAME_SUFFIX=_mpi MPI_HOME="${MPI_HOME}" CUDA_HOME="${CUDA_HOME}" NCCL_HOME="${NCCL_HOME}"
    cd ..
fi

# 5. GENERATE THE INTER-SPARK HOSTFILE
echo "------------------------------------------"
echo "📝 Generating cluster hostfile..."
echo "------------------------------------------"
echo "${SPARK_A_IP} slots=1" > hosts.txt
echo "${SPARK_B_IP} slots=1" >> hosts.txt
cat hosts.txt

# 5.5. AUTO-SYNC WORKSPACE TO SPARK B
echo "------------------------------------------"
echo "🔄 Synchronizing workspace to Spark B..."
echo "------------------------------------------"
rsync -avz --exclude '.git' "${WORKSPACE_DIR}/" "badger@${SPARK_B_IP}:${WORKSPACE_DIR}/"

# 6. EXECUTE THE CLUSTER BENCHMARK
echo "------------------------------------------"
echo "🔥 Running Dual-Node Spark Cluster Performance Test..."
echo "------------------------------------------"
export LD_LIBRARY_PATH="${NCCL_HOME}/lib:${LD_LIBRARY_PATH}"
export NCCL_DEBUG=INFO

# 🛑 DISABLE OPENMPI HARDWARE GRAPHICS PROBING
export HWLOC_COMPONENTS="-gl,-x11,-cuda,-nvml"

# Clean up any zombie processes before launching
echo "Cleaning up lingering processes..."
killall -9 mpirun all_reduce_perf_mpi 2>/dev/null || true
ssh -o StrictHostKeyChecking=no "badger@${SPARK_B_IP}" "killall -9 mpirun all_reduce_perf_mpi 2>/dev/null || true"

echo "Initiating Multi-Node AllReduce Benchmark across both Sparks..."
echo "=========================================="

# 1. Changed prefix to /usr to use the physical system binaries
# 2. Added btl_tcp_if_include to force traffic over the direct 169.254.x.x link-local network
mpirun -np 2 \
  --hostfile hosts.txt \
  --prefix /usr \
  --mca plm_rsh_agent "ssh -o StrictHostKeyChecking=no" \
  --mca btl_tcp_if_include 169.254.0.0/16 \
  -x LD_LIBRARY_PATH \
  -x NCCL_DEBUG \
  -x HWLOC_COMPONENTS \
  ./nccl-tests/build/all_reduce_perf_mpi -b 8 -e 256M -f 2 -g 1

echo "=========================================="
echo "🎉 Cluster Script Completed Successfully!"
echo "=========================================="