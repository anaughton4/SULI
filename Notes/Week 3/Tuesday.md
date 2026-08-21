# Goals for Today
* Finish setting up Kafka data pipeline for the auto encoder.  Start setting up the pipeline for the RL model.
* Explore the third dataset of grid controller plane.  
* Look into federated learning with my two current datasets/models.




# Notes
* Consider trying to save one model per day from the consumer script.  This way, if the model starts to drift, we can always start again from a good starting point (rather than the very beginning of our model trained on a static dataset).
  * Not really necessary right now, as if it starts drifting, we can just restart.  I want to make sure that this continuous stream of data actually works in the first place.  Probably try running it for atleast 3 days or so and then recheck.
* To see all running python scripts in terminal, use the command:
  * ps aux | grep python
## GAA Exercise 3 - Elevator Pitch
Celluar towers enable your phone to connect to the internet and send messages to other people.  What happens when someone hacks one of these towers?  Hackers can flood celluar towers with unwanted traffic, disabling those towers from working.  My goal is to detect threats against the network utilizing machine learning models and AI.  Machine learning models use math and statistics to decide whether the traffic is legitamte or a possible threat in a instant.  That way we can detect hackers automatically and keep your phones working just fine.



# What I completed Today
* Finished responding to all GAA exercise discussions.  Still need to respond to one person on the third exercise.
* Finished building the producer, consumer, and RL kafka streams.  Data now gets pushed to kafka, consumed by the auto encoder for training, and pushed to RL model for training.
  * Might still need to iron some things out, it's been bugy
  * Create a script that launches all three of these python scripts at once and turns them off at the same time.
* Started looking into federated learning.
