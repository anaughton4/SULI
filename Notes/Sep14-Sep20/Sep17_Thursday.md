# Goals for Today
* Create merge request for GHOSTS profile



# Notes
Things needed to configure ray training across worker nodes and igor node:
custom_env = {
    "NCCL_IB_DISABLE": "1",            # Force TCP socket communication
    "NCCL_SOCKET_IFNAME": "enP7s7",    # 🌟 Bind data transfer specifically to enP7s7
    "GLOO_SOCKET_IFNAME": "enP7s7",    # 🌟 Bind control path specifically to enP7s7
    "TP_SOCKET_IFNAME": "enP7s7",      # Bind TensorPipe specifically to enP7s7
}

#Initialize Ray and CONNECT to your existing distributed cluster
ray.init(
    address="auto",                    
    runtime_env={
        "env_vars": custom_env
    },
    ignore_reinit_error=True
)

Wihtin training function (if needed):
#Lock down the environment within the worker's thread/process
    os.environ["NCCL_IB_DISABLE"] = "1"
    os.environ["NCCL_SOCKET_IFNAME"] = "enP7s7"
    os.environ["GLOO_SOCKET_IFNAME"] = "enP7s7"
    os.environ["TP_SOCKET_IFNAME"] = "enP7s7"




* Packages to install in requriements file:
  * matplotlib
  * seaborn
  * polars



# What I did Today
* Completed the kuberay/ray-mini setup.
  * Sparks now all work with gpu enabled on federated learning tasks.