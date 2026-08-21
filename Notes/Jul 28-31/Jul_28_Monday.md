# Goals for This Week
* Get full data for all scenarios from OAI-5g
* Start doing feature correlation and engineering, along with data cleaning.
* Finish poster board peer review.✅



# Goals for Today
* Continue collecting data.✅
* Try to finish all scenarios.
* Begin feature correlation and model selection.



# Notes
* When capturing data for the scenarios, I must initially capture the data from the tables with rnti values from the beginning of the simulation startup.  This is for allowing me to connect the two tables with the random rnti values to each unique UE based on the startup order.
  * Make this a unique table.  Label it "start_up" and save it first before capturing any data for a scenario.
  * Save that start_up table to every scenario that is run with that lab setup.
* Re-running all sceanrios to include this start-up configuration step
  * This ensures that the rnti values are actually correct for data processing
* All scenarios are confirmed working except possibly the east-west scenarios
  * The initial ping goes but the reply does not seem to go
  * If UE1 is pinging UE2, it goes from UE1 to UE2, but UE1 does not get a response (which is supposed to happen)
  * Very likely a UPF problem
  * Will try to debug this problem but will not waste time on it.
* I will collect all data across the Northbound, southbound, normal, OT attacks, and RIC trigger scenarios for data collection.
* Then it will be time to move on to feature engineering and correlation, along with data cleaning.
* Ran northbound and southbound scenarios:
  * All worked and collected all data on it
  * Ensured that the scenarios actually ran.
  * Ensured that the rnti values were consistent



# What I did Today
* Ensured that all scenarios work properly.
* Collected data for northound and southbound scenarios.