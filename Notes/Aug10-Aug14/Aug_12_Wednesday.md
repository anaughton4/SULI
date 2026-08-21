# Goals for Today
* OAI-5G Lab Overview Meeting
* Start using crn51 for CMEI Delieverables
* Clean up scripts in OAI-5G and continue converting everything to Polars and parquet.



# Notes

## OAI-5G Metting Questions
* Can we review the paper and what is in there so far?
* Is the DDoS/Flood model at 94% f1 score good enough to accept for now?
  * Yeah kinda, its okay enough
  * Try to get recall of anomalies to 99%.
* What other scenarios should we try to model?  What is the total scope of this paper?
* Do we want to try and replicate the class imbalance between normal and anomalous data for this paper, or not?
* Should I move onto other scenarios or should I start doing federated learning with the DDoS/Flood scenarios first?
  * Focus on federation for DDoS/Flood right now

* Main Goals moving into this next week:
  * Continue converting everything into parquet data and polars data modeling.
  * Start federated learning for DDoS/Flood scenarios.



# What I did Today
* OAI-5G meeting
* Created the engineer profile at a basic level
  * Still need to test and deploy