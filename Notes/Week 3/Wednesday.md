# Goals for Today
* Start looking into federated learning.
* Try to facilitate a federated learning architecture with the auto encoder
* Possibly build a model for the grid controller state data.



# Notes
* The RL model has an almost perfect recall (>0.99) but the precision is quite low (around 0.55).  May try to increase reward for not dropping real data. 
  * Officially increase the penalty for false positives to -10 (up from -5)
* The threshold is almost at over 800, which is crazy to me.  But the recall is staying high still, so hopefully the threshold will keep building and also increase precision.
* Producer and consumer scripts are still running.  ran_telemetry has around 800K rows of data and rl_telemetry_state has a little over 800K.
  * Will keep these scripts running for now.
  * Will focus on federated learning today.  Maybe go back and debug models later.
* Auto encoder has dropped its loss to around 0.01, which is great.  It has taken in 1500 batches (each batch is 500 rows of potential data).
* Example architecture of RIC data in federated learning (source AI):
  *                        ┌─────────────────────────┐
                       │ Central Cloud (FL Server)│ <-- Aggregates weights
                       └────────────┬────────────┘
                                    │
         ┌──────────────────────────┴──────────────────────────┐
         ▼                                                     ▼
┌─────────────────────────┐                           ┌─────────────────────────┐
│   gNodeB_01 (Client 1)  │                           │   gNodeB_02 (Client 2)  │
│                         │                           │                         │
│  ┌───────────────────┐  │                           │  ┌───────────────────┐  │
│  │ Local DB (Influx) │  │                           │  │ Local DB (Influx) │  │
│  └─────────┬─────────┘  │                           │  └─────────┬─────────┘  │
│            ▼            │                           │            ▼            │
│  ┌───────────────────┐  │                           │  ┌───────────────────┐  │
│  │  Local DataFrame  │  │                           │  │  Local DataFrame  │  │
│  │ (Cell 01, Cell 02)│  │                           │  │ (Cell 03, Cell 04)│  │
│  └───────────────────┘  │                           │  └───────────────────┘  │
└─────────────────────────┘                           └─────────────────────────┘

* Found an error in my original auto encoder model preprocessing.  I had the total seconds in an hour at 3660 instead of 3600.  
  * I have no changed and fixed this error and am going to re-train the model.  This includes re-training it at 400 epochs.  While I don't have to technically wait for the model to finish to start using it in the live production environment, I don't want the model to change too many times once I start using it in the RL environment logic.  
  * Therefore I will train this model overnight (and during the day) and start the full new kafka production environment with my new updated static auto encoder starting tomorrow.  Fingers crossed the pipeline actually fully works! (press X to doubt).
* Now moving onto federated learning stuff and architecture.
* NEED TO DOCUMENT AND ORGANIZE SOON!
* Realized another error in data simulations:
  * The data was being simulated in milliseconds, but the pd.to_datetime function defaults to reading nanoseconds.  1 millisecond is 1,000,000 times greater than a nanosecond.  This is why the times seemed to advance by 1 second if I put the time_interval in the millions.  I have now updated the simulation scripts to have their time_step be 0.8-1.2 seconds (rather than 800000-1200000 milliseconds) and added a pd.to_numeric to the timestamp_ms columns before any pd.to_datetime.
    * This doesn't change that much, but once I make the change I have to be consistent (otherwise the scaler will get thrown off).  I'm not sure if this changes how the other statistics (like SINR or Latency) get calculated or not.  Guess I'll find out very soon with the next run of my auto encoder.
  * 





# What I did Today
* Re-built the kafka pipeline so that the RL agent is decoupled from the producer scripts, along with building a brand-new script which serves to calculate the reconstruction error and push that to a new topic.
  * Re-build desing of kafka pipeline.  Auto encoder no longer is continously training on live data.  Instead, auto encoder is trained once on a static dataset and used for reconstruction error measurements later.
  * RL agent now pulls data in two phases:
    * Phase 1 has the normal:anomaly ratio at 95:5.
    * Phase 2 has the normal:anomaly ratio at 99.9:0.01
    * This is done to ensure the agent sees some data that is anomalous early on, but then gets the normal, real-world ratio of the normal:anomaly data points.
    * This is changed from the original 50:50 split we had earlier.
    * Re-configured the reward system to represent this dramatic swtich.
  * I have a producer script that pushes the raw data with the two ratios out, and another producer/consumer script that takes the raw data, calculates the reconstruction error, and pushes that error (along with some other information such as the feature values) to another topic.
  * Finally, the agent consumes data from that last topic.
* Started federated learning.
  * Set up the server script.  Still working on the client script.
  * Try to incorporate a global scaler so that each client utilizes the same scaler.  This can be done by quickly initializing the min/max of each feature from all clients before training begins.
* Still important to consider how all of this structure fits in to our other two datasets outside of just RIC data.  RIC data is the easiest to work with at the moment because it is all numerical and actually shows some variation in the data patterns.




# Tomorrow
* REORGANIZE FOLDERS
  * Don't want to do this now because I have an auto encoder script running and I'm afriad that if I accidently move that script it will break it.  DO IT TOMORROW MORNING!!!