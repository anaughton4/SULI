# Goals for Today
* Present poster
* OAI-5g Lab overview meeting
* Try to reconcile slice mapping from slice xapps



# Notes




# Outline of OAI-5g Lab Overview
* Get him connected to our lab
  * Give him his own branch
  * Have him download everything, especially from oai-5g
  * Have him deploy
* Walk through oai-5g parts
  * Walk through the core and gNB
  * Walk through the xapps and what they do
  * Discuss how we built the images and where they are stored (harbor)
  * Discuss slices
  * Discuss upf and vpp problems (Josh mostly)
  * Discuss how to run scenarios
    * Discuss what each sceanrio does
  * Discuss how we collect the data from the xapps.
* Data questions
  * What tables do we want to use
  * Do we want scenarios all in the same table or no (probably no)
  * Do we want to use four different files (one per UE) or have everything aggregated in file per table
  * How does our proposed model read the data in?  How does it use timestamps and labeling from each UE to read data in?
  * Do we want to combine each table into one giant file of data?
  * Do we want separate groups of files for each scenario we run?  Or do we want one giant data structure for many different scenarios?
    * How are we going to parse and collect data for an eventual Phenix deployment?
    * The Phenix deployment will have things running constantly in the background with multiple scenarios happening at once (both normal and threat traffic)
    * How do we parse through that?  Do we want to try modeling that type of architecture now?
  * What kind of models do we want to use?
  * We need to sort through each variable and decide if we want to use it
  * How does federated learning fit into all of this?  We want one model per UE?  How about when we scale up?
  * 



# What I did Today