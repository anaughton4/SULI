# Plan for Today
* Get feature importance finished.



# Notes
* It seems that all of the RL agents have a clip boundary of -5 to 5.  While this works fine for the scaled features, it is horrible for the threshold data.  The threshold often stretches well beyond 5 (into the hundreds).  This is a mistake which needs fixing.
* I am currently just blazing through the feature correlation/importance and model selection currently.  I want a basic framework and workflow set up first before I get into the weeds and really try to understand each variable and how they all relate to each other.
  * A lot of the variables have high collinearity (makes sense since they are often times measuring a similar thing)
* Might even try to get my model trained and immediately implement it as an xApp really fast to just see it work for fun.
  * The really long and painful part will come afterwards.


* So turns out one of the anomaly scenarios did not stop when it runs.  It has a timer on it so it should stop no matter what, but it doesn't.
  * This caused data leakage into my other scenarios, especially all of my normal scenarios.
  * Now I need to re-do the data collection for everything.  I will do everything just to make certain that the data is clean and correct.
  * I will also completely tear down the lab each time so that there is no background processes running during data collection between scenarios.


# What I did Today
* Did feature correlation and importance
* Did model selection with H2O
* Built xapp framework for anomaly detection
  * Only works through jupyterlab right now by connecting and querying the database directly.