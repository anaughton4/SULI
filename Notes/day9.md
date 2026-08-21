Best paramters for auto encoder grid seaerch on RIC data (normal):
* Encoder Units
  * 96
* Bottleneck Units
  * 32
* Learning rate
  * 0.001
* Include extra depth layer
  * True
* Batch size
  * 32


What I did today:
* Ran the auto encoder with all 1 million rows of data.
* Used new model inside of a RL model to fine-tune threshold.
  * Only used 100K rows for the RL model and still got a 99% accuracy at the end, along with a 90 precision and 97 recall (nead recall at 100%, always).
* Discussed using federated learning to get more in-depth analysis
* Discussed trying to make simulated data even more messy
* Future possibilities
  * Re-organize and start documenting
  * Get a continuous stream of data running so that the RL agent can train constantly
  * Fine-tune reward system for RL agent.
  * Incorporate federated learning into system
  * Try other models other than an auto encoder
  * Try to figure out why tensor board is not working
  * Run same architecture on UE dataset