# Goals for Today
* Finish setting up UE live data pipeline.
* Start federated learning for UE data.
* Continue cleaning and refining scripts.



# Notes
* UE telemetry stream is live and running.
* Federated learning script for xgboost models works completely fine.  Results return really high results.  Around 95% accuracy and f1 score.  Not gonna be better than our model trained on one static dataset since this federated learning strategy has to take the results from multiple different sources for training.
* Only data left to do work on is the GCP.  Otherwise, there are two other things to do:
  * Refine and optimize scripts.
  * Feed a live stream of data into the federated learning architecture.  Have a federated learning architecture for both training and evaluating models.  Be able to split the live stream of data into kafka and a static database, such as SQL, for training.
* Along with that, I obviously still have papers to write and the poster board to do.  Along with powerpoint presentations and slides to create.
* Create slides for future SULI internship interviews.



# What I did Today
* Finished UE telemetry live stream and RL agent for xgboost.
* Finished federated learning (at a basic level) for xgboost and UE data.