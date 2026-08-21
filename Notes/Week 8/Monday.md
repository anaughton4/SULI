# Goals for the Week
* Finish paper.
* Finish presentation.
* Gather real-world data from oai-5g simulation.



# Goals for Today
* Work on paper and presentation.✅
* Get powerpoint done.
* Work on oai-5g data.✅



# Notes
* Oai-5g needs to enable the qos data monitoring within the smf/upf functions from the core.
* Paper can either include all original data points or just the three that are affected.  However, the other variables are all built upon the three core metrics of SINR, BLER, and latency.  This means that utilizing the other variables is not the worst thing ever, and provides a realistic look into how data modeling the RIC would go.
  * I think I will keep everything originally as I had it to make it simpler.  The only thing I can improve upon to make my results better are to run a random forest search model on the features to get feature importance and decide which features to keep or get rid of.
* Other ideas for paper improvement:
  * Ensure that the data simulation scripts have the same design for both the normal data that the model is trained on, the kafka scripts, and the federated learning scripts.
  * Maybe define all of the features and how they are created in the python scripts within the paper.
  * Think about including the time features (as done originally) as they provide a ground truth of how the data is changing.
  * Try to find a source that can help provide context for why I choose the mathematical basis of each feature's definition in the python scipts.  If I can't find one, just say I choose some that looked good by asking my mentor.
* Consider removing the mirrored strategy from the data modeling scripts for the LSTM auto encoder.  This is only needed if you have more than one gpu per computer (which I don't).  
* However, I should look into ensuring that my scripts are actually using the full power of my dgx-spark and not relying on old versions of the CUDA and Driver (when possible, obviously package conflicts will make it difficult).



# What I did Today
* Worked on getting the upf to work for the oai-5g environment.
* Worked on my paper.
* Practiced my presentation.