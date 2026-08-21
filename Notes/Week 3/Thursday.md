# Goals for Today
* Start kafka pipeline again.
* Monitor RL agent's progress throughout the day.
* Finish setting up first version of the federated learning architecture for the RIC data.




# Notes
* Auto encoder finished overnight.  Ran the full 400 epochs.
  * Best val_loss was 0.00033 or 3.3e-4.  Better than our last model.
  * The model's predict function did not run, got an OOM error (probably because the model ran the full 400 epochs).  This doesn't really matter since the model is saved anyways and the only thing the predict function does is give us a threshold starting place.  But our RL agent will configure that for us.
  * Since the predict did not run, neither did the saving of the scaler.  I re-ran the code in the notebook (without running the model) to save the scaler.  Should move saving the scaler to right after the scaler is created and fitted.
  * Connecting sparks walkthrough:
    * Once the sparks are connected hardware wise, you have to ensure their connection network wise.
    * You can do this using an MPI nccl-test.  This allows your sparks to send data to each other and measure how much data gets through and how fast.
    * Script for building and running test is in this directory: cluster_nccl_test.sh
      * Ensure that you run this command in the terminal: export HWLOC_COMPONENTS="-gl,-x11,-cuda,-nvml"
      * This command tells MPI to not ask for the graphical display of the other spark.  This request is hardcoded into the MPI library, so only way to turn it off is to change the components.
      * If you don't fix this, this error will keep happening: Authorized access requested, but unable to verify request.
  * Once these sparks are connected, you have to re-write the docker-compose files for jupyterlab.
  * Need to but this into the docker-compose file: network_mode: host.  Get rid of the *ports* section.
    * This line tells the docker containers to use the default ports of the "local machine" enabling them to talk to each other since each spark is in its own docker container.
  * Eventually need to run the same script on *both* sparks at the same time in order to get them to share the resources.  Need to use a Kubernetes or Ray library to get them to work together.



# What I did Today
* Re-organized files and deleted a lot of files.  Consider deleting everything in the trash.
* Got two producer scripts to run.  RL agent script needs some re-building.
* Connected the two sparks.