* I have ran two model and feature selection tests so far.
  * One for all the data (using a random subset from it)
  * One for only DDoS and Flood Anomalies (random subset again)
* Full data had high accuracy, but bad false positive rates (about 20-30%)
* Accuracy of DDoS and Flood actually went down suprisingly.
  * High false positive rates (>30%)
  * Not really sure why this is the case
  * I changed the cummulative metrics to delta metrics (measured over either 1 row or 1 second of data)
  * Need to look into each feature independently and decide what I want to keep and not keep based on logic.  Also can do some feature engineering as well.


# XGBoost Model 1
## Parameters
* max_depth = 5
* learning_rate = 0.1
* n_estimators = 300
* subsample = 0.8
* colsample_bytree = 0.8
* random_state = 4

## Metrics
* AUC = 0.98573
* Lowest threshold for >99% recall of anomalies:
  * 0.2
  * 22% false positive rate
![alt text](<Screenshot 2026-08-17 at 2.47.08 PM.png>)


# XGBoost Model 2
## Parameters
* max_depth = 5
* learning_rate = 0.1
* n_estimators = 300
* subsample = 0.8
* colsample_bytree = 0.8
* random_state = 4

## Metrics
(Main difference is I removed two features with low Gini importance)
* AUC = 0.98555
* Lowest threshold for >99% recall of anomalies:
  * 0.21
  * 22% false positive rate
![alt text](<Screenshot 2026-08-17 at 2.52.54 PM.png>)



# XGBoost Model 3
## Parameters
Only change I made was including all the data rather than a sample by switching to polars
* max_depth = 5
* learning_rate = 0.1
* n_estimators = 300
* subsample = 0.8
* colsample_bytree = 0.8
* random_state = 4

## Metrics
* AUC = 0.99999
![alt text](<Screenshot 2026-08-17 at 3.47.23 PM.png>)

## Notes
* Need to understand why by switching to polars, the model is suddenly perfect.
* Check if csv files and parquet files are actually identical 
  * Maybe there was a change on switching the data across file structure.