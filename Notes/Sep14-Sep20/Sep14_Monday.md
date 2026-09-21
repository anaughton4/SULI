# Goals for This Week
* Keep developing MLOps platform.
* FL for multi-class classification
* Finish GHOSTS profile



# Goals for Today
* CMEI weekly meeting
  * Get MLOps platform as finished as possible before presentation
    * Maybe get a demo ready
* Continue working on GHOSTS profile.



# Notes
* Packages removed from the requirements.txt file:
  * decord
    * No idea what this is
  * torchtext
    * Used for NLP 
    * Deprecated by torch for newer libraries.
  * ale-py
    * note: This error originates from a subprocess, and is likely not a problem with pip.
  ERROR: Failed building wheel for ale-py
* open-spiel
  * note: This error originates from a subprocess, and is likely not a problem with pip.
  ERROR: Failed building wheel for open-spiel
  ERROR: ERROR: Failed to build installable wheels for some pyproject.toml based projects (ale-py, open-spiel)

* Took this package out
* It is the first package so not sure if it's the package or the website we are trying to pull everything
* about-time==4.2.1
    #via alive-progress



# What I did Today
* CMEI meeting
* Got the nodes to get the GPU enabled correctly
* Started testing GPU tests with ray train and PyTorch