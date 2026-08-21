# Goals for Today
* Work on powerpoint and paper.
* Finish powerpoint.
* Work on oai-5g.



# Notes
* Best validation loss from the new model with TimingAdvance and no time features: 0.00093 or 9.3e-4
* Here are some of the reconstruction error thresholds:
Reconstruction error threshold: 0.03665734392932785
Max reconstruction error: 0.3489458080085021

* I re-built the basic LSTM auto encoder for the following things:
  * I removed reccurent_dropout as a parameter.  Having that as a paramter makes the tensorflow not use the super fast cuDNN kernels, resulting in a training process that is about 1/3 slower.
  * I removed the time features since the data was never built with time as an influencing factor.
  * I added back in TimingAdvance.  TimingAdvance dedicates a "zone" to the user.  The lower the zone, the closer the user is to the cellular tower.  Because the data degregation is determined by the distance the user is from the cellular tower, this variable is extremely beneficial to data modeling.  
  * The reason it has a high lag auto correlation is because it is technically a discrete variable rather than a continuous one.  It creats zones that are about 78 meters long.  So zone 1 is within 78 meters, zone 2 is 79-156, etc...
  * Since a user does not magically travel 78 meters in one time step, the auto correlation is essentially perfect because the numbers don't change within a 10 time step window.  
  * However, this variable is extremely important since it is directly tied to the distance of the user from the cellular tower, and therefore to the overall noise in the data.
    * Must consider how the reconstruction error is built within these 10 step time windows.  Since the TimingAdvance is disecrete, the model's predictions will need to be rounded to the nearest discrete value (or zone).



# What I did Today
* Made another LSTM auto encoder model for RIC data without the time features and with the TimingAdvance feature.
* Rebuilt the kafka producer and reconstruction service scripts to include the TimingAdvance variable and a third state called "recovery".
  * The recovery state is defined as a short amount of time after an anomaly where the traffic is falling back down to the normal state.
  * Previously this state was classified as normal.  Now it is ignored.
* Built the RL agent to use this new data structure.