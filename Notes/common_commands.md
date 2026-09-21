*Command Commands*
* SSH into a port:
  * ssh -C -o ProxyCommand="ssh -i ~/.ssh/igor_key -W %h:%p -p26149 anaughto@igor.range.nrel.gov" -i ~/.ssh/dgx_spark_key -L 7777:localhost:8888 badger@10.10.101.104
  * Updated command to prevent timeouts:
    * ssh -C -o ServerAliveInterval=60 -o ServerAliveCountMax=3 -o ProxyCommand="ssh -o ServerAliveInterval=60 -o ServerAliveCountMax=3 -i ~/.ssh/igor_key -W %h:%p -p26149 anaughto@igor.range.nrel.gov" -i ~/.ssh/dgx_spark_key -L 7777:localhost:8888 badger@10.10.101.104 -N -f
  * Change end IP address depending on which spark you want to go into.
  * Change ####:localhost:#### numbers depending on which service you want to use.
* SSH into Igor node specifically rather than spark:
  * ssh -C -o ServerAliveInterval=60 -o ServerAliveCountMax=3 -o ProxyCommand="ssh -o ServerAliveInterval=60 -o ServerAliveCountMax=3 -i ~/.ssh/igor_key -W %h:%p -p26149 anaughto@igor.range.nrel.gov" -i ~/.ssh/igor_key -L 5000:localhost:5000 anaughto@10.10.100.158 -N -f
* To kill a port in use:
  * kill -9 $(lsof -t -i:####)
* Looking at the logs of a docker container:
  * docker logs <container_name>" 
* Pushing stuff to the badgers-based-lab:
  * git add . (period to push everything)
  * git add ('filename') to push a specific file
  * git commit -m "message for push"
  * git push
    * Finnal commit to push
* Fetching latest pulls from badgers-based-lab:
  * For getting info from a specific branch:
    * git fetch
    * git reset --hard <branch_name>
  * To get everything
    * git pull
* Getting into the jupyterlab environment from the terminal in visual studio code:
  * docker exec -it <directory_name> bash
  * To run script from within jupyterlab asynchronously:
    * nohup python -u <script_name.py> > <logs_name.log> 2>&1 &
  * Check logs of asynchonous script:
    * tail -F <logs_name.log>
  * To check specific script if it's still running:
    * jobs ps -ef | grep <script_name.py>
  * To stop script:
    * kill -9 <PPID>
* To watch gpu utilization:
  *  watch -n # nvidia-smi (# number defines seconds between refresh)
* To see all running python scripts in terminal, use the command:
  * ps aux | grep python
* Getting into tensorboard through the jupyterlab environment:
  * tensorboard --logdir <path_to_logs> --port 6006
* Watching the GPU more closely:
  * nvidia-smi dmon -i 0 -s u




# Port Mappings
* 7777:8888
  * Jupyterlab (head node)
* 7776:8888
  * Jupyterlab (worker node)
* 6006:6006
  * Tensorboard
* 8080:8080
  * Apache Kafka
* 8265:8265
  * Ray Dashboard