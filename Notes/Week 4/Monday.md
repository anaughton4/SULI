# Weekly Goals/To-do
* Figure out if mental health benefits carry over past internship length.
* Figure out how to process my overtime from last week.
* Ask Marcus how to apply for a job.


* Check and configure the RL agent data pipeline I have.
* Fully implement federated learning for RIC data:
  * Get the Ray process fully working and understandable.
  * Create scripts within badgers-based-lab for starting the jupyterlab environments automatically.
* Create same federated learning approach with UE and grid controller data.
* Continue documenting and writing stuff as much as possible.  Review notes.
* Ask around for further topics to explore.




# Notes
* Mendeley is a great resource for building a paper.
* [Distributed 5G Nodes] ──(FL)──► [Robust Federated Autoencoder] ──► [Continuous Reconstruction Error]
                                                                                │
                                                                                ▼
[RL Agent (Gymnasium/PPO)] ◄────────(Adjusts Threshold dynamically)───────── [Reads Error & Sets Threshold]


[Input Data] ──► [Encoder] ──► [Bottleneck] ──► [Decoder] ──► [Reconstructed Output]
                                                                        │
     ▲                                                                  ▼
     └─────────────────── [Calculate Loss] ◄────────────────────────────┘
                (Difference between Input & Reconstruction)
                                 │
                                 ▼
                     [Backpropagation Updates]
                  (Adjust weights to minimize loss)





                                 ┌──► [Static Autoencoder] ────► (Topic: rl_topic_static) ─────► [RL Agent A]
                                 │
[Raw Telemetry Kafka Topic] ─────┤
                                 │
                                 └──► [Federated Autoencoder] ─► (Topic: rl_topic_federated) ──► [RL Agent B]




# What I did Today
* Fixed OOM error for Spark due to reconstruction service.
  * Reconstruction service was using a model.predict function which, after being called, would store that predict function in memory and not delete it.  Memory built up over time and reached 100% after about 450k steps (450 batches) of data.
* Ran and debugged federated learning script.
  * Asked AI a lot of questions for structering of the federated learning.
  * Federated learning can either build a new model or use an existing model and update its weights.  Right now I am using my auto encoder which was previously trained on static data.  However, I think I want to try and build a brand new model from scratch and go from there, just as a test.
  * Federated learning runs multiple models in parellel across the nodes, sends the weights after the set epochs to the server and the server averages the weights out, sending the averages back to all of the models.  At the end of training across all nodes, the server stores a final model with these aggregated weights.  
    * This allows us to create a model that sees a lot more traffic with two benefits:
      * Privacy is maintained since one node never sees data from another node.
      * Model is attuned to more types of data.  It will understand data from different sources, allowing it to be more versitile.  That way we don't have to use many different individual models in testing - we only need to use one.
  * Once a model is saved from federated learning, then it can be used in the same structure as our static auto encoder model is used.  It can be used on a live stream of data, calculating reconstruction errors and sending that data to a RL agent who then optimizes a threshold.
  * It would be interesting to see a comparision of how the federated learning model does compared to the static data model.
