# Goals for Today:
* Continue researching and writing paper/presentation.
* Possibly look into formating the real data into a csv file




# Notes
* Probably not going to mess with the real data too much until it is for sure being shoveled to me from Josh.  
* Real data will most liekly not make it into my final presentation.  I will probably have to use the fake simulated data I've been using up to this point.
* While the results won't be as applicable, the overall architecture and design of what I've built is still a great thing to present on.
* Save real data modeling for once my internship is over and I have much more time to dive deep into how to utilize the real simulation scripts.
  * For example, we need to figure out a way to configure the data to be exported through python so that it can be re-routed to a kafka topic automatically.  Currently cannot do that.




# What I did Today
* Fixed the Ray process for the federated learning scripts on the head node:
  * I think that one of the other scripts forced the node to ignore the GPU.  This stayed in the background and so the node didn't know it had a GPU at all and started runing its processes in the federated learning script on the CPU instead.
  * I just tore down and re-built the with the docker compose files for both the head and worker node and it started working fine after that.
* Ran the federated learning script for the RIC data with 4 clients instead of 3.
  * Maxed out the GPU for both computers.
* Looked at a slice of what the real data will look like (format wise):
  * Tried to convert this format into a csv file.
* Re-wrote the DQN agent (and eventually the xgboost agent) to converge to an actual threshold faster utilizing a buffer.
  * The buffer takes the real data that it is given (with the 99.9/0.1 split) and pushes the data into two buffers, one for normal and one for anomaly:
    * The last 2500 anoamlies are pushed to the anomaly buffer
    * The last 2500 normal metrics are pushed to the normal buffer
  * The RL agent now trains on these buffers rather than the actual real world data ratio!  This ensures the model has a good memory of what anomalies and normal traffic look like and it can make great and insightful decisions.
  * This structure still works with a real-world scenario of 99.9/0.1 ratio of normal to anomaly.  In fact, it works with any real-world ratio!  The buffers are just used as first in, last out structure of storing data.
  * I found that the simulation script is actually incorporating a random walk based on how far the user is from the tower.
    * The further they are, the more horrible the connection is
    * The closer they are, the better the connection
    * The random walk would, with a little math, move from the tower to the outer boundry in about 500K-1million steps.  
    * Looking at the threshold tuning graph in tensorboard, the threshold follows an almost perfect sine wave with a period of about 1 million steps, replicating where the user is in relation to the cell tower.
      * The sine wave won't be perfect because it is a random walk and so it is going to have some noise to it.  But yeah, it basically looks exactly like a sine wave.
    * That means the agent is not only learning how to detect anomalies, but how aggressive it should be in relation to how the normal traffic looks like!  This is incredible news and shows how powerful and necessary a RL agent tuning is for a real-world pipeline.



# Tomorrow Tasks
* Tomorrow, I should mess with the reward function for both RL agents.
* Incorporate the buffer window for the xgboost RL agent.
* Keep asking Josh about updates to the real data.
* Really start working on the presentation and paper.  I am basically going to use the simulated data i have now in my final presentaiton since it is not really feasible to start using the real data and re-build everything to work for it.
* Maybe think about incorporating multiple layers to a federated learning environment.  Like have a local model at the cell level, a global model at each gnode level, and then another global level above all the gnode layers.  So like double federated learning.
