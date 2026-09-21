# Goals for This Week
* Finish Ghosts engineer profile.
* Finish documenting results for Abijeet.
* Continue working on MLOps.
* Do extra steps like multi-level classification for BADGER.



# Goals for Today
* Work on MLOps
* Work on getting documentation



# Notes
* Dependencies to install:
  * JupyterLab
    * xgboost 3.2.0
  * Head node
    * xgboost 3.2.0
    * flwr 1.13.0
    * polars 1.44.1


* I am installing updated driver settings on the 101 machine to see if updating the software will allow xgboost and other libraries (like torch) to see the host's driver:
* How to update the bridge of the nvidia container toolkit:
#1. Configure the package repository
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

#2. Update and install
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker




* Run this command to reset the toolkit settings:
#Revert Docker config to its original system default
sudo nvidia-ctk runtime configure --runtime=docker --cleanup
sudo systemctl restart docker




* My original Dockerfile script:
#Use a recent, stable version of the base notebook as a starting point
FROM jupyter/scipy-notebook:latest

#Switch to the root user to install system-level packages
USER root

#Use conda to create a new environment with the specific Python version AND ipykernel
RUN conda create -p /opt/conda/envs/python-3.10.20 python=3.10.20 ipykernel --yes && \
    # Fix permissions so the default user can use the new environment
    fix-permissions /opt/conda/envs/python-3.10.20

#Create a kernel spec so Jupyter recognizes the new environment
RUN /opt/conda/envs/python-3.10.20/bin/python -m ipykernel install --user --name "python-3.10.20" --display-name "Python 3.10.20" && \
    fix-permissions /home/$NB_USER

#Switch back to the default notebook user
USER $NB_USER

#Pre-install your pip packages here instead of in the postStart hook
RUN /opt/conda/envs/python-3.10.20/bin/pip install --no-cache-dir \
    'ray[default]==2.58.0' \
    mlflow \
    confluent_kafka \
    joblib \
    'numpy==1.26.4' \
    gymnasium \
    stable-baselines3 \
    'flwr==1.13.0' \
    'wandb==0.15.12' \
    matplotlib \
    pymongo \
    flask \
    requests \
    'setuptools<82' \
    keras_tuner \
    seaborn \
    h2o \
    statsmodels \
    polars \
    optuna \
    feature-engine

#Set this new environment as the default kernel for notebooks
RUN echo "c.MultiKernelManager.default_kernel_name = 'python-3.10.20'" >> /home/$NB_USER/.jupyter/jupyter_notebook_config.py


* How to get into a specific envrionment in jupyterlab terminal: 
  * conda activate /opt/conda/envs/python-3.10.20




# What I did Today
* Worked on MLOps stuff
  * Got the Optuna Search script to run
  * Josh wants a heavier version of Ray to run that maxes the GPU more.