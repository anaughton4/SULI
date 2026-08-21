# Goals for Today
* Respond back to Courtney with what my role will potentially be on the CMEI project before I leave for the week.
* Clean up and push the oai-5g folder for Abujeet.



# Notes
* Models are still very bad with high false positive rates.
  * Consider changing the window size of all of the delta variables
  * The deltas are possibly too small at only 1 ms or us.  Try changing the deltas to more like 1 second.
  * That way, there are going to be very little amounts of zeros in the deltas for anomaly sceanrios.  Right now, there are too many cause the logging happens too fast.



# What I did Today
* Feature engineering for threat scenarios with ddos and floods
* Model selection testing.