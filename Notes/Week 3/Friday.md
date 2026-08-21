# Goals for Today
* Document!
* Ensure stable connection between two sparks and that resources are shared between the two.
* Continue RL agent training and monitoring.
* Continue federated learning scripts.



# Notes
* To overwrite spark B with the newest changes from spark A without causing a merging conflict, you must run these two commands on spark B:
  * git fetch
    * Gets the latest changes from spark A
  * git reset --hard origin/<branch_name>
    * Completely overwrites any changes on spark B with the newest changes on spark A
* Step-by-Step guide to getting Ray up for resource sharing on sparks A and B:
  * Ray assings one spark as the "Header" node and one or more sparks as "Worker" nodes.
  * You run the main file on the header node and then that header node will reach out to any worker nodes to use their resources for running that script.
  * Step 1:
    * Install ray on both sparks within the python environment:
      * pip install -U "ray[default]"
      * *Important* Both python environments must have the same packages and same versions installed.  Otherwise, there may be a conflict when running scripts.
  * Step 2:
    * Run this command on the head node to define it as the head node:
      * ray start --head --port=6379 --num-gpus=1
        * The output from this command should have a line that says something like: To add another node to this Ray cluster, run ...
        * Take that command and run it on spark B.  This will connect it to spark A as a worker node.
        * Moving forward, port 6379 is how you can access the dashboard for Ray to see the resource utilization between the two sparks.
          * SSH through this port (run through the head node).
          * Run localhost:8265 in the browser to connect.  
  * Step 3: Ensure connection
    * Run "ray status" on the head node.
    * You should see each worker node and the head node under the "Active" status.  You can also see how many resources you have total between the two below the "Resources" header.
* Everytime you re-build the docker-compose files and the containers, you will have to do steps 2-3 again.  
  * This could be built into the docker-compose files, but then there would have to be a mismatch between the docker-compose file on the head node and the worker node (which is too much of a headache for me).
* Example python script for making the script act inside the Ray cluster and utilize shared GPU resources: 
import ray
from stable_baselines3 import PPO

# 1. Connect to your existing Ray cluster on Spark A
ray.init(address="auto")

# 2. Define a Ray Actor that requests 1 GPU
@ray.remote(num_gpus=1)
class RLTrainingWorker:
    def __init__(self):
        # This code runs inside the Ray cluster environment
        # Initialize your custom environment
        from your_env_file import TelemetryRLAutoencoderEnv 
        self.env = TelemetryRLAutoencoderEnv()
        
    def train(self):
        # 3. Train your PPO model using the allocated GPU
        model = PPO("MlpPolicy", self.env, verbose=1, tensorboard_log="./tb_logs/")
        
        print("Starting RL training on the Ray Cluster...")
        model.learn(total_timesteps=200000)
        model.save("ppo_telemetry_model")
        return "Training Complete!"

# 4. Instantiate the Actor (Ray reserves 1 GPU for this object)
trainer = RLTrainingWorker.remote()

# 5. Run the training process asynchronously on the cluster
result = ray.get(trainer.train.remote())
print(result)



# What I did Today