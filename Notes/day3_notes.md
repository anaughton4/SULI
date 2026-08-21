Walkthrough for connecting to the node and running code through jupyterlab locally.


* Open both two terminals on visual studio code through both the crn149 node and the ssh node (as demonstrated in day 2 notes).
* Clone gitlab repository (https://gitlab.range.nrel.gov/badger-ldrd/badgers-based-lab.git) into both terminals using git clone "url"
  * This step should be finished already and not be replicated.  Simply open the folder moving forward from the files tab.
* Go to the jupyterlab folder and open the README.md file.
  * Here there is a line under the "Port Forward" header.  It looks something like this "ssh -C -o ProxyCommand="ssh -i ~/.ssh/id_ed25519 -W %h:%p -p26134 jrivera@igor.range.nrel.gov" -i ~/.ssh/dgx-spark -L 7777:localhost:8888 badger@10.10.101.101"
  * You will need to replace some info with your own info instead.
  * Eventually the line should look like this "ssh -C -o ProxyCommand="ssh -i ~/.ssh/igor_key -W %h:%p -p26149 anaughto@igor.range.nrel.gov" -i ~/.ssh/dgx_spark_key -L 7777:localhost:8888 pangolin@10.10.101.102"
  * Explaining the differences:
    * switched "id_ed25519" to the name of my own igor key "igor_key".
    * Changed port number to the node I have resereved "p26149" (node 149)
    * Changed web url to include my username "anaughto".
    * Changed name to my own for the SSH port at the end to "pangolin" and the port number to 10.10.101.102.
    * Deleted some uneccessary info.
  * Explaining the code:
    * The code connects to the crn149 node that is reserved on port 8888 and then transfers that to port 7777, transfering it to a jupyterlab environment on the local machine.  It uses the ssh igor_key to initially connect to the node.
  * Next install docker using "sudo apt install docker" (shouldn't need to run again)
  * Install docker-compose using "sudo apt install docker-compose (shouldn't need to run agian)
  * Move into the "tf-lab" directory under jupyterlab.
    * Run up the docker-compose file using "sudo docker-compose up -d"
    * run "docker ps" to make sure the container is healthy and running.
  * Go to the url "localhost:7777"
    * This will open the jupyterlab on your local machine to build models and pull data.



Getting Grafana Up:
* Run the same ssh... line but with "3000:localhost:3000" instead.  Run it in the crn149 terminal in the badgers-based-lab in the grafana directory.
* ssh -C -o ProxyCommand="ssh -i ~/.ssh/igor_key -W %h:%p -p26149 anaughto@igor.range.nrel.gov" -i ~/.ssh/dgx_spark_key -L 3000:localhost:3000 pangolin@10.10.101.102
* ssh -C -o ProxyCommand="ssh -i ~/.ssh/igor_key -W %h:%p -p26149 anaughto@igor.range.nrel.gov" -i ~/.ssh/dgx_spark_key -L 7777:localhost:8888 badger@10.10.101.104
* Go to localhost:3000 on safari to access Grafana UI



Getting statistics up:
Grafana Dashboard:
* On Grafana, create a new data source
* Open a dashboard
  * It will intially be empty, but you just have to enter each box and run the query to see the data.
  * Press the three little dots on each box and click "edit"
  * Press the "Run queries" button near the bottom right.
  * This will take in the data.  You can 



Getting Ollama and OpenClaw set up:
* Get the Ollama service using "curl -fsSL https://ollama.com/install.sh | sh" in the terminal in the directory of ollama
* Edit the Ollama service file by inserting these three lines under the "Services" section
  * "sudo systemctl edit ollama.service" to edit file
  * Environment="OLLAMA_HOST=127.0.0.1:11434"
  * Environment="OLLAMA_KEEP_ALIVE=-1"
  * Environment="OLLAMA_NUM_PARALLEL=1"
* Save and restart
  * sudo systemctl daemon-reload
  * sudo systemctl restart ollama
* Pull the model we want using "ollama pull nemotron-3-super:120b" (This will take a while)
* Move to the dgx-spark directory
* Run this command "curl -fsSL https://www.nvidia.com/nemoclaw.sh | bash" to recreate NemoClaw
* Run this command "NEMOCLAW_SANDBOX_GPU=0 ~/.local/bin/nemoclaw onboard".  This will initiate the downloading of NemoClaw using the nemotron-3-super:120b model we pulled earlier.  It will ask what model to use (pick option 7, Ollama) and then pick that model.  Don't activate Brave and run it as balanced.  This should intialize everything and allow you to use NemoClaw!
* To go to the Nemoclaw UI website, paste this into the badgers-based-lab directory: "ssh -C -o ProxyCommand="ssh -i ~/.ssh/igor_key -W %h:%p -p26149 anaughto@igor.range.nrel.gov" -i ~/.ssh/dgx_spark_key -L 8888:localhost:18789 pangolin@10.10.101.102".  Go to the localhost:8888 and then it should automatically sign you in.  
  * The key it asks for is the key that can be found in the nemoclaw directory after you connect to nemoclaw (in the sandbox).



Running Extra Stuff:
* Run and activate the move-directive file using /.move-directive.sh start
* Run and activate the manage-xai-shovel.sh using /.manage-xai-shovel start
* Run and activate start-log-pipeline.sh using ....
* May have been ./ 



Future Steps:
* Make NemoClaw read the directive so that it understands its purpose a little more.
* There was another file it needed to read as well that I don't recall...
* There was definitely some other information that I don't remember anymore.





To get OpenClaw running:
* Type "nemoclaw badgers-based-lab connect" into the terminal
* type "openclaw tui" into the terminal
* Once it is running, open the nemoclaw-directive.txt and scroll to the bottom (shouldn't have to do this step again):
  * Paste the last two lines in the txt file into nemoclaw one at a time.  This will tell nemoclaw what its purpose is and how to act.



General tips:
* If a command does not work in docker, enter "sudo !!" and it will run the previous command with sudo in front of it automatically (usually fixes the problem)
  

  ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJRupqbeuHg757mjGbBfSh97Zy0P41s2bUHJFkG3tbUe
  new key?
  This popped up when I was messing with trying to get the Ollama service file to work.  I don't think it matters because this was before I tore down the Ollama and re-built it again, but it is here just incase for some reason.