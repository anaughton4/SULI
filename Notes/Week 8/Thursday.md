# Goals for Today
* Finish powerpoint.
* Work on paper and poster board.
* Work on oai-5g



# Notes
* RL agent now works flawlessley.  99%> for each metric.  Threshold is now being zoned into under 1.  Here are the changes made to achieve this:
  * Added a "recovery" state for after anomalies happen.  Only goes back to normal once the three main metrics are within 1 standard deviation of the historical rates for those metrics.
  * Re-built the calculation for the Packet loss rate and the BLER.  The packet loss rate was definitely the one that was causing some normal traffic to have high reconstruction errors:
    * In data trained by auto encoder:
      * packet loss rate is 80% of BLER
    * In data trained by RL agent
      * Packet loss rate is a random number
  * THe auto encoder is so sensitive to data it doesn't know that this small change was causing the "ideal" threshold to jump up to over 100s.  Insane.
* Basically I know that the RL agent works now because it is using simulated data and getting perfect results.  This is something that I would expect, just like in the base model and the federated learning model.
* Now the question is... can we apply this same logic to real data and get a good result as well?



# What I did Today