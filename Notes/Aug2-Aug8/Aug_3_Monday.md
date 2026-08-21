Fuck Mondays

# Goals for This Week
* Finish collecting data✅
* Get a basic model up and running
  * Test basic model
  * Start to formulate how this model will be implemeneted for catching anomalies
* Clean up feature engineering and model selection scripts
* Start creating an xApp
* Get my first scorch run for NERA done and look at data from it
* Let Courtney know about my hours (10 hours)



# Goals for Today
* Finish collecting data✅
* Continue trying to get scorch runs to work✅
* Test basic implementation of a model.✅



# Notes
* Changed the very first PPO agent to scale the threshold so that it appears within the boundaries of the observation (-5, 5).
  * Use base 10 logarithmic scaling
* Consider making the threshold adjustments (currently +-0.1) to be percentage bases (+-10%).
* Turns our the data from the oai-5g lab is aggregated cummulatively!
  * This means that all metrics that are an aggregation are a cummulative metric, measuring the total amount since the simulatin came up.
  * Therefore, for data modeling, we need to get a delta amount for each 1 ms step in each table for each of these metrics.
* The entire gtp_ngut table is useless.  Just contains identifiers and one categorical variable (technically a numeric value, qfi, but it represents a priority level).  I am just going to drop it for now for simplicity.
  * Same deal with frame, slot, ul_num_harq, dl_num_harq in MAC_UE
  * Same with mode in PDCP_bearer



# What I did Today
* Finished collecting data.
* Josh walked me through phenix for NERA.
* Asked Sara about RPP.
* Started more feature engineering and model testing.