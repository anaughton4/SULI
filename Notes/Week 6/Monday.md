# Goals for This Week
* Finish rough draft of research paper
* Finish rough outline of slides for SULI interviews
* Start poster board project
* Train at least one model on real data.
* Gather data from the RIC, grid plane, and nwdaf into one csv file



# Goals for Today
* Continue writing paper
* Train at least one model on real data
* Consider re-writing the auto encoder to lower the ratio of feature:encoder:bottleneck units, rather than expanding it (so something like 4:2 units, if that even does anything).



# Notes
* Consider making the UE python simulator produce anomalies in burst rather than one row at a time.
  * Only reason for not doing this is that I wanted the data to be exactly 50/50 of normal to anomaly, and since this data is built using a non time-series forecasting model (namely xgboost) the data being in perfect bunches is not necessary for good data modeling.  
  * At the very least, discuss this descrepency in the paper if I don't change it.
* Info I need for evaluation results of auto encoder:
  * Graph of loss vs val_loss✅
  * A table of parameter grid search results.✅
  * Number of epochs ran for✅
* Info I need from the xgboost model
  * Features used and features cut✅
  * confusion matrix✅
  * accuracy, f1, precision, recall✅
* Add distance to the list of features pushed to kafka for the data producers of the auto encoder.  This feature does not need to be used, but have it stored so that I can graph it later in relation to the current threshold.



# What I did Today
* Wrote more of my paper
* Decided on some more architecture and design aspects of my simulated data and models.
* Fixed the real data to monitor all 4 UEs rather than just 1 and 4.
  * Did this by making the docker compose file section for the xapp monitoring to listen on every slice, rather than just the default slice.