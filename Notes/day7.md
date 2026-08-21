Great source for auto encoder examples/explanation:
https://blog.tensorflow.org/2020/04/how-airbus-detects-anomalies-iss-telemetry-data-tfx.html?_gl=1*uu43q*_ga*MjUzMjI0NzIyLjE3NzkzNzk4MDc.*_ga_W0YLR4190T*czE3Nzk4OTUzOTEkbzMkZzAkdDE3Nzk4OTUzOTEkajYwJGwwJGgw


* How to get inside the notebooks space container on the terminal in vsc to run the python scripts autonomsly without needing to keep the terminal or website up:
  * docker exec -it tf-lab bash
* To get the script running
  * nohup python -u my_simulation.py > simulation.log 2>&1 &
* To check the logs of script
  * tail -f simulation.log
* To check if the file is still running
  * jobs ps -ef | grep my_simulation.py
* To stop the file
  * kill ID


* To watch the nvidia-smi container
  * watch -n # nvidia-smi
    * Replace # with any number (defines the number of seconds between each refresh)


* Future Questions to consider for my auto encoder model:
  * Does the batch size need to be scaled up when I actually ingest full datasets (500K rows of data/1 million rows)?  What about bottleneck size and learning rate?
  * What value of a val_loss should I strive for to feel satisfied?  How much is having a continous ingestion of data going to improve my val_loss?
  * How to set up Apache Kafka as a docker container in our current badgers-based-lab environment.