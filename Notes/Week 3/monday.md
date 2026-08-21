* Link to my therapist session tomorrow: https://care.springhealth.com/members/care_visits/d6b687b9-397b-4b69-989f-aff319a1fb55?source=booking




# Goals for Today/Week
* Run RL model with full 1 million rows of data. ✅
* Set up a continuous stream of data pipeline for the auto encoder and the RL model.  Monitor and save its results.✅
* Start testing other models.
* Apply same data pipeline with the UE telemetry data.
* Document and organize.
* Apply more random noise to siulated data (for example, data loss during storms).




# Notes
* New auto encoder model finished at about epoch 190.  Lowest val_loss was about 0.0005.  Reconstruction error set to 0.037 (RL model will move this accordingly).
* Gemini response to real-world datasets that I could use:
  * Public Datasets for Network Threat Detection

Dataset Name	Relevance & Description	Why It's Useful for You
CIC-IDS-2017 / 2018	(Highly Recommended) The modern standard for intrusion detection research. It contains a massive amount of labeled network traffic with both raw packet captures and processed "NetFlow" features. Includes dozens of modern attack types like DoS, DDoS, Port Scans, and Web Attacks.	This is your best option. It has a mix of categorical and numerical features, labeled attacks, and benign traffic. Your XGBoost model should perform well here, and it will force your model to learn patterns beyond your 6 simulated scenarios.
UNSW-NB15	A very popular dataset for network intrusion detection. It contains nine different families of modern attacks and has a good mix of categorical and numerical features, similar to your simulation.	A great alternative or supplement to CIC-IDS-2017. It's well-documented and widely used, so you can benchmark your model's performance against published academic results.
ToN_IoT Datasets	A new generation of datasets specifically for IoT and IIoT (Industrial IoT) networks. It includes telemetry from various sensors and contains attacks like DoS, ransomware, and man-in-the-middle, all within an IoT context.	This is an excellent thematic fit. While not 5G-specific, it captures the "many-device" telemetry aspect and includes industrial-style attacks. The data structure is very similar to what you've simulated.
AWID3 (Wireless Intrusion)	A dataset focused on Wi-Fi (802.11) networks. It contains a large amount of real-world wireless traffic, including various types of injection and flooding attacks that are conceptually similar to mobile network attacks.	Good for testing your model's ability to handle the "noise" and variability of wireless protocols. The attacks are different, but the statistical footprint (e.g., sudden spikes in traffic, changes in packet size) is a universal concept.

* The simulated data can only take me so far.  The models are essentially perfect with the simulated data, even with random walks, jitter, and random numbers being used to construct the data.  I can still continue to build the data pipeline so that I have a structure set up for when I get actual data... but I will have to adjust whatever I do for that pipeline once I get real-world data.
* It is also hard to predict what models I might want to use when I can't see the real-world data and how it is contstructed.
* I think the last step would be to initialize a full data pipeline by making the continuous stream of new data happen for both the auto encoder ric data and the xgboost model with the ue data.  That is like the last thing I can do right now in terms of building stuff.
* I can also just document more rn, but I want to do that for 30 minutes at the beginning and end of the days and spread it out rather than doing it all at once.
* I can also start using those real-world datasets that gemini offered to get a head start on that.




# What I accomplished today:
* Successfully created and XGBoost model to handle predicting the UE data.
  * Model did really well (too well)
  * It is meorizing the patterns that the simulator is using to create the new data, getting a perfect f1 score.  The setup is nice, but we need more real-world data to understand how well an XGBoost model would really do.
* Finished setting up the consumer/producer scripts.
  * Producer pushes RIC data with both normal and threats to the topic ran_telemetry on Apache Kafka.  The consumer script then pulls that data in real-time and does two things:
    * Takes the data labeled "normal" and feeds it to the auto encoder to train it.
    * Pushes all the data (normal and threats) to a new topic called rl_telemetry_state.
  * The new topic will be used as the data source for the RL model.
* Talked with Josh today about creating a third dataset on grid controller plane.  
* Josh showed me the various simulation scripts he has in production for an eventual real-world live data stream for my models.  However, it is probably more than a week from being implemeneted.

## What to do tommorrow:
* Try to flush out the consumer and producer scripts:
  * Fix the issue with "normal" data having leftover values from the anamoly data, completely throwing off the auto encoder for training.
  * Debug and document.  Make sure everything is working as intended.  
  * Figure out the best way to have all of the information regarding how the model is training and updating saved, whether in a log or some other file system.
* Look into third dataset and how to model it.
* Look into real-world datasset pulled from gemini.
* Continue documenting, taking notes, and writing out the process.
