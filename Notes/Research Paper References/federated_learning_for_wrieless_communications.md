# Abstract
* Federated learning allows us to train models at the edge where the data is collected, removing the need to transfer large amounts of data to one centralized hub for training and evaluation.
* This not only speeds up the process, but ensures data privacy.



# Introduction
* In release 16 of the 3GPP, they have started to improve the data exposure capabilities in ORAN networks, specifying how to cllect and feed the data back to the network functions to support ML.
* Keeping the models where the data is generated greatly reduces bandwith requirements and allows possible RT or near-RT models to be achievable.



# Preliminaries and Overview
* "Recently introduced by Google, federated learning is a decentralized learning approach where training is performed over a federation of distributed learners."
* Federated learning has each local model train on its local dataset and then send their local weights back to the global model.  
  * Ideally, the weights are sent in an encrypted fashion.  The encryption should NOT have to be decrypted to get the new global weights.  It is only decrypted once it goes back to the local model.
* There are some key factors of federated learning that differ from distibuted learniing:
  * The datasets are dealt with non-iid data.
    * This means that each dataset that the local model works with does not have to be completely identical.  They can be widley different in nature, allowing one local model to paint half the picture, while another local model paints the other half.
  * Datasets can be unbalanced in size.
    * There is no need for the datasets to be rigidly the same.  This is extremely good for network federated learning since some nodes will have much more traffic than others.
  * Datasets are massively distributed among the local learners
    * The number of data samples per local learner is smaller than the total number of learners participting in the federated learning.



# Applications of Federated Learning for Wireless Communications
## Edge Computiing and Caching



## Challenges and Considerations Related to the Algorithm
* Even with a highly distributed environment of deep neural networks, the updates of the global weights may still require a lot of bandwith. 
* Questions of how many learners and how often we should update the global model still remain.
* Questioning how fast models can converge on such sparse data is also a problem.  Each local model may be so poor that aggregating them still doesn't improve our situation.  This goes back to the question of, theoretically, how many learners should we have (and how much data should each learner have)?