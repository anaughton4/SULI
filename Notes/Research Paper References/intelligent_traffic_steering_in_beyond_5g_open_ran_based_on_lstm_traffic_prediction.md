# Abstract
* This paper covers a LSTM model approach to dynamic traffic steering in the 5G ORAN network.
* Utilizes both short term and long term memory functions.



# Introduction
* "Traffic steering (TS), one of the most efficient approaches, enables network software to steer the traffics in the most proper paths by routing user traffics through the most suitable radio resources."



# ORAN Architecture and System Model
## ORAN Architecture
* ORAN architecture has three main layers:
  * Management
  * Control
  * Funciton
* ORAN uses both real-time (RT) and non real-time (nRT) RICs for network abstraction
* Any interaction taking longer than 1 second is non-RT RIC control loop, interfaced between the RICs and the A1 interface.
* Timescale between 10ms-1s is near-RT, interfaced by the near-RT RIC and DU/CU components.
* Anything under 10ms is RT, interfaced between elements of DU and cell site.
* Training models would be in the non-RT application.
* rApps and xApps run on the near-RT timescale, taking data from the node and using third-party apps/services to prune out new data.



# Performance Evaluations and Numerical Results
## Simulation Setup and Parameters
* Scenario assumes all users are uniformly distributed within a cirecle of radius 500 meters, with the location of the RUs fixed.
* LSTM model has two hidden layers and 50 units.
* Data is processed in a first-come first-serve buffer.



## Numerical Results and Discussions
* Metric looked at is MSE and they kept the model going until the validation loss is the same as the loss for a specific number of epochs (callbacks).
* Used MinMaxScaler
* Used 80, 20 training split.
* Model converges after 50 epochs.
* Activation of tanh (default) works better than relu or sigmoid.  This makes sense since they are not doing classification in this scenario.
* Adam optimizer converges the fastest. 
* Increasing the number of LSTM layers and decreasing the number of units per layer does not help model convergence.
* 