Files to start upon set-up:
* start-log-pipeline.sh (logwhisperer)
* manage-log-bridge.sh
* start-grafana.sh
* manage-xai-shovel.sh
* start-oai-5g.sh
Maybe Run?
* push-directive.sh
* Yes run push-directive.sh to update the files that are in the sandbox!
  * Important if the cognitive_directive is ever changed or if we want the AI to see specific files.
These files should only have to be run once.  Once they are up, they should stay up permanantly (Unless the cpu spikes, which we will find out soon enough if that's the case).

* Look at logs within different docker containers
* "docker logs <container_name>" is the command
  * Specifically "docker logs OAI_CASUAL_TRACE" is the most important command.
  * This is the logs that the oai network is constantly producing.
* This is where we can see the type of info that the AI can see, process, and work with.



Things Changed:
* The model did not work for a while due to it not being able to access files due to privacy restraints.
* Eventually, we pulled two code snippets from gemini and re-built the "manage-log-bridge.sh" and a section in the push-directive.sh (under step 4).
* Notice that there is a section that says something like "node:node".  This supposovely gave us permission for the AI to access certain files already in the sandbox
* Can run "ls -al" in the nemoclaw directory and see all of the files there.  They should have node node for the two bottom parts (and maybe even more of them).
* Definitely something to look into more later.


Future Objectives:
* Create a main congnitive_directive (GOLDEN_COGNITIVE_DIRECTIVE.md) for the nemoclaw agent to run.
  * This file will outline all of the tasks, reasoning, pupose, and usage that the AI should do.
  * Ideally the AI would follow each task on its own.
    * Each task should perform some basic data gathering and automation.
    * The more abstract we can push these directives to be, the better for us.
  * Try our best to keep the directive as simple as possible and eventually have the more abstract commands be injected into the AI either manually or automatically at some point.
* Also think about working out a way to run each directive separately so that the AI can work with one at a time instead of trying to internalize 10-20 different instructions at once.
* Find a way to take all of the data from the dashboards and the file the AI creates into the jupyter lab for data analysis.
* Create a data pipeline that seamlessly and continuously creates, feeds, and tests new data.
* Create a file (python maybe?) that can automatically make the agent run certain steps and rules on a regular basis and have those steps create data which is then automatically dumped into a file in jupyterlab.



Ideas for possible AI directives:
1. cpu.md: [TIMESTAMP] Full view of gpu usage over 24 hours.
2.  timeseries.md: [TIMESTAMP] How many HTTP code (204) occur over 24 hours.