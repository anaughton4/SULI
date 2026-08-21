Setting up igor and dgx-spark keys:
* We generate an ssh and dgx-spark key to be able to reserve a node and securely log into the github repositories.  This is where we will access all data, models, AI, and scripts in order to run our project.
* Generating a key:
  * Paste into terminal "ssh-keygen -f ~/<keyname> -t ed25519" (replace "<keyname> with whatever name you want)
  * This will allow you to create two keys, one for igor and one for dgx-spark (name them approapriately).
  * Create a directory called ".ssh" and move both keys (private and public) into this directory.


Reserving a node:
* Reserving a node will allow you to run nwdaf and oai analytics from the badgers-based-lab repository.
* Grab your public key info from your igor key (cat it out from your directory).
* Go to the url: (https://vault.range.nrel.gov/ui/vault/dashboard).
  * Use nrel credentials to sign into the Vault under the LDAP tab.
  * Click on "igor-shh/" and then click "create secret".
  * Name the key appropriately.  Enter your public key info from your igor key created earlier.
* Next, go to the url: (https://igor.range.nrel.gov)
  * Create a reservation.  Fill out the info appropriately.
  * Make sure to make the end-time of your reservation as long as possible (or else you'll lose your reservation once the time is up).
  * After about 10 minutes, you will get an email confirming your reservation.  The url in the email will allow you to access the phenix UI (not needed right now).



Setting up badgers-based-lab and nemoclaw/openclaw:
* First we need to connect to both our new reserved node from cyberrange and our ssh port to our dgx.
  * Open visual studio code.  
  * Click the two arrows in the bottom left corner.  Click "connect to host", then click "Add New SSH Host".
    * Here you will enter the appropriate information to set up your crn(node#) and ssh port.
  * Once you are connected to both the cyberrange node and the ssh port, we can clone the github repository of "badgers-based-lab" from this url: https://gitlab.range.nrel.gov/badger-ldrd/badgers-based-lab
  * Once we pull this repository, we move into it on the ssh port window.
* Now let's set up all of the different UI applications, along with nemoclaw.
  * Run the "master-badgers-based-lab-run.sh" file in the terminal.  This will completely set up everywithin within the repository that is needed.
  * The script will prompt you with a few options:
    * If it asks for which model to use, select option 7 (local Ollama).  It will usually say "recommended" next to the option.
    * The script will prompt you with which nwdaf/oai container to listen to.  This is the container that the openclaw agent will have direct access to seeing.  You can only choose one at a time right now; however, you can always change the option later on.
  * Once the script is finished running, there will be information at the end regarding how to sign-in to the three web UI interfaces: jupyterlab, grafana, and openclaw.
    * Jupyterlab is where all the models and data sit.  Use this to create your own models or analyze already existing models/data.
    * Grafana is an application that takes in basic data points regarding your AI model and cleanly displays them in a dashboard.  You can see simple statistics such as the GPU temperature, the AI reasoning state, or the logs of the AI.
    * Openclaw is simply the UI to run your openclaw agent from the browser.  You don't need this to run openclaw, as you can do everything in the terminal.  However, it can be useful to have up to make sure your model is actually running correctly and that the settings are set up correctly.
      * If you click the url link given in this info section, it will actually open the website inside visual studio code!  You can then click to this web interface inside you coding environement so that you never need to switch tabs.
  * Once your script is finished running, we can now move into nemoclaw to use the AI.
    * First move into the "nemoclaw" directory.
    * Run the command "nemoclaw badgers-based-lab connect".
    * Now you are inside the sandbox that the AI sits in.  The AI will only ever have access to whatever is in this directory!  Avoid asking the AI to change, modidy, read, or execute documents or scripts that are not in this sandbox, or else it will freak out or stall.
      * You can run a simple "ls" command to see what is in this directory.  
      * Usually you will see two main files: a "COGNITIVE_DIRECTive.md" and a "OAI_CASUAL_TRACE.md" file
      * The cognitive_directive file tells the AI its purpose and specific steps it should take to record its own reasoning and thought process (more on this later).
      * The oai_casual_trace file contains the logs for whichever oai/nwdaf container you allowed the AI to access.
    * Then run the command "openclaw tui".
      * This will bring you into the AI console to directly interact with it.
      * The first thing you should do is tell the AI to read and execute the "COGNITIVE_DIRECTIVE.md" file.  You can use a command similar to this prompt: "Read the file /sandbox/COGNITIVE_DIRECTIVE.md and execute its instructions immediately."
      * After it is finished, you should see files fill up and update under the "/nemoclaw/xai-telemetry" directory.
        * These files will record the AI's reasoning, thought, process, and statistics.  The AI will update these files every 10 minutes or after/during each prompt given to it.  The statistics on grafana largely come from these files.
      * Next, give the AI a command or prompt to make sure it is working.  For example, you can ask it "Give an indepth assessment of the AMF log in /sandbox/OAI_CAUSAL_TRACE.md and while following /sandbox/COGNITIVE_DIRECTIVE.md instructions. Determine if a threat is present and if I threat actor needs to be steered or rerouted to an isolated zone."
        * Wait for its response.
        * While waiting, you can look at your statistics up on grafana.
        * You should see certain metrics go up while the AI is reasoning, such as the gpu temperature or the reasoning latency.
        * These statsitics ensure that the AI is actually working and not stuck in a loop or timeout.
      * Now your AI is set up and ready to go!  You can always modify your cognitive_directive file to include whatever you want.  However, the more complicated/large-in-scope the directive is, the more the AI will lag since the directive is something that it follows/updates with every prompt.
      * Benefits to openclaw AI is that openclaw allows you to give the AI commands that can run in time-intervals or over long periods of time.  For example, you could tell the AI to analyze  hundreds of files overnight or run a large llm model overnight, showing you the results the next day.



Telemetry data and its source.  Explanation of telemetry data variables:



Models used:



Results: