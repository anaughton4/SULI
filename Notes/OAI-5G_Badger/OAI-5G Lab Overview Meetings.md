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



# Meeting 4: August 20
* Try FL for much more rounds
  * Use federated weighted average.
* DO a local training on a non-ddos/flood scenarios set
* Try FL for a mix of DDos/Flood and non-DDoS/Flood scenarios across clients (one client is ddos and one client is non ddos).
* Start shifting into simple models (Decision trees)




# Meeting 5: August 27
* Questions:
  * What are the next steps?
    * Hetergeneous Fl?
    * Deployment via xApp?
    * RL?
* Look into libraries Dice and Shap
  * Good for understanding what each feature is impacting the prediciton
* Task for next week:
  * Try to do multi-class classification
  * Get results/tables for all models done so far.
    * Put into a word document for Abijeet to write on
  * a. Document the threat types b. Document the feature correlation study. c. Get the results for different local models trained on. d. Get the results on the FL training (per round loss/prediction scores)
  * Once that is done we venture multi-class detection and/or explainable fl using Shapley and Dice
  * Data extraction and scenario explanation




# Meeting 6: September 2
* Add section explaining the different tables and features
* Add FL results to paper outline
* Run FL for Non-DDoS and Flood Scenarios



# Meeting 7: September 9
* Get graphs on FL (DDoS and non-DDoS)
* Start multi-class classification