# Meeting 1: July 29
* Provide a brief explanation of them and report them to abhijeet
* Look into Knowledge Distillation within federated learning.
* Do both homo and heter fl.  Do both combined.  See what works the best
* Start out with random forest models to get a good idea of feature importance.



# Meeting 3: August 12
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