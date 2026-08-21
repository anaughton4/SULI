# Goals for the Week
* Look into CMEI Deliverable✅
* Continue modeling in oai-5g data✅



# Goals for Today
* Exist for 4 hours✅



# Notes
* I have done feature extraction for ddos and floods.  Results are not great (or much better) than just using all the data at once.
  * I changed the delta values to look back at the last 1 second of total change, rather than 1 row (which comes out to either 1 ms or 1 us).
    * That helped a little
  * I tried getting rid of the idle scenario.  That didn't really change anything.
  * I am going to try only using features that are not deltas and see if that improves the model.
* Also consider the fact that so far, all feature extraction and modeling has been done with SUBSETS of the total dataset.  This means that the data may not be represenative of the total data, leading to lower accuracy overall.
* Need to create an ssh to crn51 for syslog directory
  * Figure out how to start working on there on my stuff for NERA.



# What I did Today
* Read up about GHOSTS NPC Framework.
* Messed around in Jupyterlab for a little.