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


* ssh does not work on a Windows VM (it is not configured on there).  The VM would need access to the internet in order to download OpenSSH.  Therefore, we have two options:
  * Enable OpenSSH as a pre-set of the Windows VM image (Nic or someone else would need to do that)
  * Use WMI instead.
* I will try WMI instead.
  * WMI worked on a manual test.
* The structure of WMI looks very similar to the sfth handler.  The only difference is that WMI does more than just file transfers, so the CommandArgs is where we have to define the specific file transfer we want to do, alonw with the destinations of all files.
* Current Wmi handler:

{
      "HandlerType": "Wmi",
      "HandlerArgs": {
        "TimeBetweenCommandsMax": 5000,
        "TimeBetweenCommandsMin": 1000,
        "CredentialsFile": "<C:\\phenix\\ghosts\\config\\credentials.json>", 
        "delay-jitter": 0 
      },
      "Initial": "",
      "UtcTimeOn": "00:00:00",
      "UtcTimeOff": "24:00:00",
      "Loop": "True",
      "TimeLineEvents": [
        {
          "Command": "random",
          "CommandArgs": [
            "10.68.30.19|admin|powershell.exe -Command 'Copy-Item -Path \\\\10.68.30.20\\C$\\Users\\Public\\Desktop\\nera.zip -Destination C:\\Users\\Public\\Documents\\nera.zip -Force'"
          ],
          "DelayAfter": 20000,
          "DelayBefore": 0
        }
      ]
    }


* WMI does not work
* Will be reverting back to sftp with a new Windows VM image with OpenSSH baked in!




# September 11
* This is my original timeline for the engineer profile.  I am going to make each part work one at a time so I want to save the original work in here:
{
  "Status": "Run",
  "TimeLineHandlers": [
    {
          "HandlerType": "Command",
          "Initial": "",
          "UtcTimeOn": "00:00:00",
          "UtcTimeOff": "24:00:00",
          "Loop": false,
          "TimeLineEvents": [
              {
                  "Command": "execute",
                  "CommandArgs": [
                      "reg add \"HKLM\\Software\\Microsoft\\Terminal Server Client\" /v AuthenticationLevelOverride /t REG_DWORD /d 0 /f"
                  ],
                  "DelayAfter": 10,
                  "DelayBefore": 100000
              }
          ]
      },
    {
      "HandlerType": "Ssh",
      "HandlerArgs": {
        "CredentialsFile": "C:\\phenix\\ghosts\\config\\credentials.json"
      },
      "Loop": "False",
      "TimeLineEvents": [
        {
          "Command": "random",
          "CommandArgs": [
            "10.68.101.2|root|;sed -i '/<\\/ot-sim>/i \\<!-- Modified by GHOSTS -->\\' /etc/ot-sim/config.xml && echo \"Updating its firmware complete!\"; exit"
          ],
          "DelayAfter": 180000,
          "DelayBefore": 60000000
        }
      ]
    },
    {
      "HandlerType": "Sftp",
      "HandlerArgs": {
        "TimeBetweenCommandsMax": 5000,
        "TimeBetweenCommandsMin": 1000,
        "CredentialsFile": "C:\\phenix\\ghosts\\config\\credentials.json",
        "UploadDirectory": "C:\\Users\\Public\\Desktop",
        "delay-jitter": 0
      },
      "Initial": "",
      "UtcTimeOn": "00:00:00",
      "UtcTimeOff": "24:00:00",
      "Loop": "False",
      "TimeLineEvents": [
        {
          "Command": "random",
          "CommandArgs": [
            "10.68.30.19|admin|cd C:\\\\Users\\\\Public\\\\Desktop; put nera.zip"
          ],
          "DelayAfter": 20000,
          "DelayBefore": 60000000
        }
      ]
    },
    {
            "HandlerType": "Rdp",
            "HandlerArgs": {
                "CredentialsFile": "C:\\phenix\\ghosts\\config\\credentials.json",
                "mouse-sleep-time": 10000,
                "execution-time": 600,
                "execution-probability": 100,
                "delay-jitter": 50
            },
            "Initial": "",
            "UtcTimeOn": "00:00:00",
            "UtcTimeOff": "24:00:00",
            "Loop": "False",
            "TimeLineEvents": [
                {
                    "Command": "random",
                    "CommandArgs": [
                        "10.68.30.19|engineer"
                    ],
                    "DelayAfter": 600000000,
                    "DelayBefore": 60000000
                }
            ]
        }
  ]
}

* Current problems:
  * RDP does not work with credentials given
  * SSH does not work with given credentials.
  * Sftp tries to upload from a basic default system directory rather than the directory I am defining
* It is very weird that these problems are happening cause the timeline on the VM itself shows the correct stuff.  So it is not an injection issue.  So I really have no idea why it's not working.
* Only thing I can imagine is that since the windows VMs are different now with the ignition software, there may be a disconnect between how ghosts works with ignition.
* I am going to work on getting RDP to work first since that is technically the simplest out of the three.

## RDP
* The credentials are officially:
  * engineer
  * 0tterTail
* This has been verified through a manual connection
* Also, the port 3389 is open on the target IP (10.68.30.19)
* I am going to try and remove/add backslashes to the credential path in the timeline.  
  * That didn't work
* Now let's try to replace the base64 version of 0tterTail with the plaintext version and see if that works.  
  * It definitely seems like it is a credentials problem.


# RDP Solution!
* The password for engineer started with a number (0).  Starting a password with a number (or even a special character maybe), completely messes up the parsing for the json file.  Therefore, the password gets injected incorrectly and that's why the RDP was not working.
* Additionally, the password needs to have three of four requirements (according to gemini):
  * upper case
  * lower case
  * number
  * special character
* Simply replacing the 0 with an O does not work either, so I'm pretty sure that what gemini said is correct.
* I have changed the engineer profile to use the password OtterTail1!
* NOTE:
  * RDP seems to work after a small amount of time.  For some reason, it does not work immediately.  It takes like 2 or 3 failed attempts for it to work
  * No idea why this is the case.  Maybe a order of things spinning up thing?
  * Regardless, it works.  Even though the logs will show like 5 failed attempts for every 1 success.



# Sftp
* Sftp needs to have the put [localfile] path be explicit to the entire host directory.
  * Meaning that even if you define an upload directory, you still have to define that upload directory in your put [localfile] argument
    * Not sure why this is the case as that seems reduntant but whatever.
* Sftp still didn't work after making that change, but the logs said that it successfully sent the file.  I am going to try and change the cd statement to only have 2 backslashes instead of 4.
* Gemini suggested to fixes:
  * the put command might have two arguments instead of just one
    * Argument 1 is the local file desitation
    * Argument 2 is the destination file destination
  * So something like this
    * put C:\\Users\\Public\\Documents C:\\Users\\Public\\Documents
    * Or four backslashes for the second one if needed
  * Gemini also suggested putting a . at the end of the argument in the put command
  * This tells the put command to put the file in the current directory it is in
    * put C:\\Users\\Public\\Documents .
* The Sftp sends the file to the default directory that the SSH starts at (so \Users\Administrator).  I have tried a multitude of different options to put the file where I want it but nothing is working.


* I got Sftp to behave correctly.  Apparently, the cd command requires linux / slashes for moving to directories rather than the windows \ slashes.  Fucking hate this job



## SSH
* SSH requires linux style commands, but with Windows style backslashing \ for paths.





# List of Final Changes
## Credentials File
* Changed the engineer password to match the change of OT-Scada engineer password 
  * Changed from 0tterTail to OtterTail1!



## Timeline
* Changed the duration of the DelayAfter and DelayBefore to be 1 minute and 5 minutes
* Changed the Sftp handler to define an absolute path in the put command.
* Made the ssh handler create a blank text file within the path \Users\Public\Documents



## OT-scada
* Changed the "create-engineer.ps1" file to have the password changed from 0tterTail to OtterTail1! to match the credentials file.



## Other Changes
* Added in the ami folder in the phenix-injects folder.  It wasn't there originally and wasn't injected when I got the new ignition injection for some reason.
