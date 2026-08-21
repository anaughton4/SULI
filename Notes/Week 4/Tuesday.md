# Goals for Today
* Create a brand new auto encoder from scratch utilizing federated learning.
* Set up a parellel data pipeline for both the static auto encoder and the federated learning auto encoder.  Compare results between RL agents.  Things to look for:
  * How fast does each agent find an optimal threshold?
  * How high of an f1-score can each model achieve?
* Optional: Fix RL agent script to have a reward system centered around f1-score (specifically for the anomalies). 



# Notes
* Current RL agent metrics after 800K steps:
  * Perfect normal recall and precision.
  * Perfect anomaly recall, horrible precision
* What this means:
  * The model is flagging every single anomaly.  The anomaly precision is still low because of the class imbalance.  Even if only 0.001% of normal data gets flagged as anomalies, that 0.001 will outweigh anomalies by a lot.  Out of 100K rows of data, 999 of them would be expected to be normal while only 1 would be anomalous.  Even if the model only predicted 10 of those normal rows to be anomalous, that still leaves a precsion of 1/10 for the anomalies.
  * So relaistically, this model is doing excellent.  It is catching all of the anomalies and only flagging a small percentage of the normal traffic as anomolous.  
  * Switching to optimize for f1-metrics may not be necessary.
  * Still want to compare how a federated learning auto encoder does compared to these results.  See if it finds an optimal threshold faster.
  * Maybe consider trying a different class balance for future tests (99.9/0.01 may be to low).
* API Key for Wandb:
  * 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
  * key ID
    * wandb_v1_DA9gR7cOOLlDzfislY4CnjMd6Uv
  * Key name
    * Untitiled Key
* Wandb allows us to group all of the metrics across all models to the same dashboard. Tensorboard was previously sending the metrics for each model on that specific spark node.  So if one model ran on one node and another model on another node, the tensorboard logs would be split across two different ssh channels, and one centralized spot for all the logs would be impossible without swtiching between tabs constantly.
* Wandb is pretty janky and not really great.  But it gets the job done and streamlines all of the metrics into one spot.



# What I did Today
* Completed Federate Learning script with 3 clients for an auto encoder on RIC data.
  * It is gonna take a while to finish.  Probably another 5-6 hours.
  * Logs are streamed to wandb.ai website.  It's super laggy and hardly refreshes right away.  It can also get more metrics that are usefull as well, but its baseline output is good enough for now.
* Theoretically updated the scripts for both the auto encoder and the RL agent to include both the auto encoder on static and federated learning.
* That way we can compare how the two RL agents do at finding an optimal threshold.