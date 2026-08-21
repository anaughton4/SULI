# Abstract
* This paper explores the possibilites and importance of explainable artificial intelligence (XAI).  
* Using machine learning (ML) or AI in security surveys tend to emphaize model robustness rather than model trustworthiness.  This article aims to develop and discuss ways of making these so called "black box" AIs more understanble for humans.



# Introduction
* Next generation wireless networks are based on new newtork infrastructure, radio access methods, processing and storage capacities, and applicaiton types.
* 5G networks tend to use mircoservices through the cloudification of network services.
* Potential threats to 4G include the following:
  * DoS
  * Spam over Internet Telephony (SPIT)
  * Spoofing
    * An attacker misdirects the users with fraudulent data
  * SIP registration hijacking
    * IP packet headers are replaced with attacker's ones.
* "A single vulnerability in SCPSs can cause catastrophic failures (Butterfly effect) due to their interwinded nature."
* "The Defense Advanced Research Projects Agency (DARPA) started the Explainable Aritificial Intelligence (XAI) initiaive in May 2017 to develop a set of new AI methodologies that would allow end-users to comprehend, adequately trust, and successfully manage the next generation of AI systems."



# XAI for 5G and Beyond: A Data Life Cycle Approach
* "The data life cycle referes to how a system generates, collects, proesses, and analyses data."
* XAI and the data life cycle is a three-tired architecture:
  * Perception Layer:
    * Includes sensors, actuators, controllers, bar code/QR code tages, RFID tags, smart meters, and other wireless/wired devices.
  * Network Layer:
    * "Enables data transmission, routing, and communication protocols, letting devices and sensors deliver data to the cloud or other processing points."
  * Service/Application Layer:
    * This is where all of the data sits and is used.  This is where XAI trustworthiness is at its most critical.



# Section III: Role of XAI on Security Issues of Network Layer
## Secureity of Radio Access Network
* "A RAN can consist of a base-band unit (BBU), radio unit, or remote radio unit, antennas, and software interfaces."
* RAN protocol stack consists of the central unit (CU), distributed unit (DU), and radio unit (RU).
* A new attacking threat for ORAN structures are an attackers ability to inject synthetic data into the RIC.  This can lead to poor training results and slowdown of predictions.
* ML based IDS is a great way to detect eanomalies because they gradually learn over time.
* Other exaxmples include multi-layer perceptrons (MLP), support vector machines (SVM), or kernelt trick (KSVM) for multi-stage jamming attacks.



# How XAI Can Help to Mitigate These Attacks/Issues
* ML/AI are primarily deployed in the RIC as xApps, rApps, or dApps.  They are linked directly to the CUs/DUs.
* XAI can be very helpful in detecting poisoning from attackers, allowing us to look back at the training samples and find where the poisoning started.
* Auto encoders are vulnerable to attacks and poisoning.  It is difficult to look at an auto encoder and find where the attack took place (which feature).
  * XAI would have their own KPIs to find and understand where the poisoing took place.
* 