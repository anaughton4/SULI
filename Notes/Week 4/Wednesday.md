# Goals for Today
* Review federated learning scripts and its results.
* Fix RL agent script
* Try to implement double RL agent scenario (static and federated).



# Notes
* Created a new DQN model instead of a PPO model for the RL agent.
  * DQN retains information across batches, allowing it to remember previous anomalies.
  * Good for sparse anomalies and large class imbalances.
  * The threshold seems to go up to 800, and keeps climbing.  After about 1 million steps, the cummalitive recall for both classes was >0.995.  The precision of anomalies was also around 0.75!
  * Kafka producer and reconstruction service streams are now running in the background.  DQN model is running as well.
  * I have made the DQN model restart its logs and model from scratch with each run.  The model processes the info really fast since it does not have to do the reconstruction itself, so I'm not worried about having to save progress.
  * Make sure to change the version of the kafka id for each new run to start fresh from beginning of data pipeline.
* Consider changing auto encoder model from LSTM to somelthing like tsdae or bilstm
  * These models automatically define and optimize the rolling window size.



# What I did Today
* Created a new DQN RL agent.
* Started building the architecture for the UE data.
  * Basic model trained (XGBoost)
  * RL agent created (needs fine-tuning)
  * Still need to create live data pipeline
* Federated learning has a thing called Federated Proximal or FexProx that can help aggregate weights in an optimized way that balances global stability with local convergence.