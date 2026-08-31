# Nera SFTP to Control-Center
* Inject the nera.zip folder to OT-ws
* sftp nera folder from OT-ws to Control-Center into the ProgramFiles.



## Changes Made
* Configured OT-ws to inject the nera.zip file directly onto the VM on startup inside the 
  * /Users/Public/Desktop/nera.zip
  * Added this in the topology.yml file under injections
* I put a nera.zip file inside the OT folder within the injects.  I do not know where nera.zip originates from so I just did this instead.
* Created a script called enable-sshd.ps1 
  * This allows port 22 to be open on boot up for control-center.
    * This allows ssh and sftp functions onto this VM
    * Previously not configured
  * Added this in the topology-p3u.yml file in the control-center section under injections
* GHOSTS
  * Made the Upload Directory match where nera.zip is injected
  * Used 
    * put C:\\Users\\Public\\Desktop\\nera.zip 
  * This is for putting the nera.zip file into the public desktop for the control-center
  * Nic said to put it into Program Files but I'm not sure if a sftp would have access to that folder.  I think if it is on the VM, that's all Nic really cares about, but make sure to communicate that clarification to him.