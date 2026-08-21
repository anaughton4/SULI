# Range | Ghosts - Engineer Profile
* Create an engineer profile (that will sti around our existing user and administrator profiles) and drive a GHOSTS NPC down on the OT-ws.



# Background Readiing
## Ghosts
### What is GHOSTS
* GHOSTS is a non-playable character (NPC) framework for automating user activity.
* GHOSTS clients come in three types:
  * Universal
    * Cross-platform client
  * Windows
    * Legacy windows-only client.  Still maintained for full MS office / COM-iterop fidelity
  * Lite
    * Minimal cross-platform client.  Programmatically generates web-request traffic and file-creation activity without launching real applications


### How are GHOSTS Clients Configured?
* GHOSTS require many different files to define how they act.
  * Example files are dictionary.json or filenames.txt.
* In addition to these static files, there are three behavior files that are used to update GHOSTS clients during runtime
  * Application.json
    * This file defines meta parameters for how the GHOSTS client behaves.  The main parameter that needs to be updated is the API server's address
  * Credentials.json
    * This file holds the credentials that GHOSTS will use for remote actions (like ssh or rdp).
  * Timeline.json
    * Main file for configuring GHOSTS client actions.
    * Timeline contains an array of handlers.  Each handler defines how the GHOSTS client will interact with a specific program.
    * For example, the word handler can be usedd to specify the time and frequency which GHOSTS will create MS word documents, and where the word documents will be saved.
* Static files are maintained in the repository ./config directory.
* Behavior files are updated and injected at experiment run time using a Phenix app at experiment run time.


### How is GHOSTS Integrated Into the Cyber Range?
* To try a GHOSTS source change before it is merged upstream, point the GHOSTS submodule at your fork and branch, push that to a candidate-* branch in this repository (CyberRange/Nera/ghosts) (not a personal fork) and open a merge request.  Then run the manual upload-candidate job.  The candidate clients land under https://s3.range.nrel.gov/range-public/tools/ghosts/candidates/mr-<iid>/.  Point install-ghosts.ps1 at the prefix to bake a workstation image with the candidate client, or just inject the built client into a VM using phenix injections: to overwrite the installed ghosts client at C:\phenix\ghosts.
* The custom NLR CRC configured GHOSTS clients described above are installed but not activated in the enterprise workstations taht are included in Cyber Range golden images (IT-ws10.qc2, IT-ws11.qc2, OT-ws.qc2).  To configure and activate these GHOSTS clients, use the ghosts Phenix app.
* You can also manually install GHOSTS clients using the Linux ghosts-client.sh script.


### How do I use GHOSTS in my Experiments?
* An NLR internal phenix app exists to automate GHOSTS activation and configuration.
* Detailed documentation is found at CyberRange/phenix/apps/.../ghosts/README.md
* Features
  * start GHOSTS clients as the logged-in user, so that GHOSTS actions can be seen in the VNC session, and update timelines and credentials to use the credentials of the logged-in user.
  * configure groups of VMs to use a GHOSTS profile (see below).  Can also customize profiles in the app.
  * aging:
    * Run the GHOSTS actions at a rapid rate for some length of time, creating artifacts and events to "age" an environment.
  * server
    * Inject a GHOSTS API server into the topology and update GHOSTS clients with this server's address


### Do you Have any Examples?
* The NERA topology uses GHOSTS on each workstation.
* Profiles
  * users
    * A standard IT user
    * Activities
      * MS outlook email
      * MS office documents
      * Web browsing (firefox)
      * SFTP
      * PowerShell helpdesk commands
  * Administrators
    * An IT sysadmin that administers servers
    * Activities
      * All user actions
      * SSH and RDP to servers
      * WMIC to all Windows domain clients
      * Notepad
      * CMD/PowerShell administration
  * Engineers
    * A OT engineer
    * Activities
      * RDP to OT-dc 
      * Notepad
  * Customers
    * A utility customer
    * Activities
      * Web browsing (Chrome) to eah utility webpage, including customer login
  * Linux
    * A timeline for linux VMs
    * Activities
      * Web browsing (Firefox)
      * SFTP
  * A basic Windows User
    * Activities
      * MS office documents
  * A more advanced Windows User
    * Activities
      * Bash commands
      * Curl web requests
      * SSH
  * A basic universal user
    * Activities
      * A basic Windows user
* Handlers
  * Excel
    * Creates Excel books ans saves them in the active user's documents folder
    * Delay
      * 86400000 ms
    * Rate
      * 1 action/day
  * Word
    * Creates a Word document and saves them in the active user's documents folder.  Occasionally saves these documents as PDFs too.
    * Delay
      * 86400000 ms
    * Rate
      * 1 action/day
  * PowerPoint
    * Creates PowerPoint presentations and saves them in the active user's documents folder.  Occasionally saves these presentations as PDFs too.  These are blank presentations
    * Delay
      * 86400000 ms
    * Rate
      * 1 action/day
  * Outlookv2
    * Interacts with Outlook to read, reply to, create, or delete emails.  Occasionally attaches files, click links, download attachments, etc.  Content is generated from a variety of configuration files.  
    * Delay
      * 1728000 ms
    * Rate
      * 50 actions/day
  * BrowserFirefox - OutlookWebAccess2019
    * Doeal all Outlookv2 actions through firefox to access OWA.  Actions specific to OWA version 2019
    * Delay
      * 1728000 ms
    * Rate
      * 50 actions/day
  * BrowserFirefox
    * Randomly borwses a set list of websites, follows links on those websites
    * Delay
      * 8640000 ms
    * Rate
      * 100 actions/day
  * Notepad
    * Creates text documents and saves them in standard locations a user would save data.  Occasionally saves these documents as PDFs too.
    * Delay
      * 172800000
    * Rate
      * 1 action/2 days
  * Rdp
    * Connects to another machine with RDP and moves mouse randomly.  Closes connection after a set period.  If a certificate warning pops up, it is accepted.  Does not work for Windows 11!
    * Delay
      * 21600000 ms
    * Rate
      * 4 actions/day
  * Rdp-Win11
    * RDP as described in Rdp, with custom login key-sequence for Windows 11.
    * Delay
      * 21600000
    * Rate
      * 4 actions/day
  * Sftp
    * Makes connections to a server and lists the available files
    * Delay
      * 864000000 ms
    * Rate
      * 1 action/10 days
  * Ssh
    * Connects to various IPs and machines and performs a few commands before disconnecting
    * Delay
      * 17280000 ms
    * Rate
      * 5 actions/day
  * Wmi
    * Connects to all domain machines and collects basic information
    * Delay
      * 10800000 ms
    * Rate
      * 8 actions/day
  * Reboot
    * Reboots the machine
    * Delay
      * 604800000 + 604800000 ms
    * Rate
      * 1 actions/14 days
  * Watcher
    * Watches specific directories and deletes files once the directory size gets above a limit




## GHOSTS App
* This app, named ghosts, automatically updates the CMU GHOSTS NPC Automation Framework clients in the topology, and optinally creates a GHOSTS server.  GHOSTS will run as whatever user runs user-startup jobs.  
spec:
  scenario:
    apps:
      - name: ghosts
        metadata:
          aging_speedup_factor: 730                           # factor to speedup GHOSTS actions by. default is none
          aging_speedup_duration: 24                          # number of hours to run GHOSTS in at the speed above before reverting to "normal" speed
          startup_app_credentials: false                      # if true, username/passwords from startup app will be used for GHOSTS actions (eg: RDP, SSH). default is false
          profiles:
            - config: /phenix/injects/ghosts/configs/users/     # should contain timeline.json, application.json, [credentials.json]
              hosts:
                - hostname: ws1                                   # hostname
                  handlers:                                       # handlers can update the timeline.json ip addresses, username / passwords, and commands. If these are set they will be appended to CommandArgs in the timeline.json. However, the timeline MUST already have a Handler for the corresponding service type.
                    - services:                                     # interactive services are SSH, SFTP, WMI, or RDP. Commands are not needed (or used) for RDP. All combinations of service X ip X user [X command] will be generated.
                        - ssh
                        - rdp
                      ips:                                          # ips can be IP addresses or FQDNs
                        - 10.0.0.10
                        - web.smurfcorp.com
                      users:                                        # can specify a domain (or not)
                        - SMURFCORP\King.Smurf|S3cr3t1!
                        - Administrator|S3cr3t1!
                      commands:                                     # commands must be separated by semi colons.
                        - pwd; echo "hello there"
                    - services:
                        - rdp
                      ips:
                        - 10.3.3.10
                      users:
                        - OTDOMAIN\engineer2|SuperS3cr3t1!:w
                - hostname: ws2
                  handlers:
                    - services:                                     # can also add browser services. These URLs will be browsed to directly, so add protocol / port if needed.
                        - browserchrome
                        - browserfirefox
                      urls:
                        - https://web.smurfcorp.com
                        - http://topgen.info
                        - https://13.37.13.37:8443/admin.php
            - config: /phenix/injects/ghosts/configs/engineers/
              hosts:
                - hostname: ews
                  user: OTDOMAIN\engineer3|AlsoS3cr3t1!           # credentials to update any handlers that require credentials (eg: RDP, SSH). Overrides credentials from startup app if startup_app_credentials: true
          server:                                             # optionally create a GHOSTS server VM, will update clients to point to this instance
            - hostname: ghosts                                  # if this hostname already exists in topo, use that, otherwise create (some defaults below)
              image: ghosts-server.qc2                          # default options, override if you want
              cpu: 2
              memory: 8192
              interfaces:                                       # either append these interfaces to existing node, or create them on a new one. If an interface is named below and already exists in the topo, do nothing, assume the user is just telling the app which interface to point clients at.
                - vlan: WWW                                       # the first interface defined here in the app will be used to update clients. If no interface is defined here will look for the first interface in the topo.
                  address: 10.0.0.99/16
                  gateway: 10.0.0.1

* Configuration Options
  * aging_speedup_factor
    * Type
      * Integer
    * Required
      * No
    * Factor to speedup GHOSTS actions by
  * aging_speedup_duration
    * Type
      * Integer
    * Required
      * No
    * Number of hours to run GHOSTS at speedup before reverting to normal
  * startup_app_credentials
    * Type
      * Boolean
    * Required
      * No
    * Default
      * False
    * If true, username/passwords from startup app will be used for GHOSTS actions.
  * profiles
    * Type
      * List
    * Required
      * Yes
    * List of profile configurations to inject
  * profiles[].config
    * Type
      * String
    * Required
      * Yes
    * Directory containing GHOSTS config files (application.json, timeline.json, credentials.json)
  * profiles[].hosts
    * Type
      * List
    * Required
      * Yes
    * List of hosts in this group
  * profiles[].hosts[].hostname
    * Type
      * String
    * Required
      * Yes
    * Hostname of the node
  * profiles[].hosts[].user
    * Type
      * String
    * Required
      * No
    * Credntials (DOMAN\User|Pass) to start GHOSTS and use for remote actions.  Overrides startup app creds.
  * profiles[].hosts[].handlers
    * Type
      * List
    * Required
      * No
    * Additional arguments to add to existing actions in timeline.json
  * server
    * Type
      * List
    * Required
      * No
    * Configuration to create a GHOSTS API server or point to an existing one
  * server[].hostname
    * Type 
      * String
    * Required
      * Yes
    * Hostname of the server
  * server[].image
    * Type
      * String
    * Required
      * No
    * Default
      * ghosts-server.qc2
    * Image to use if creating a new server
  * server[].interfaces
    * Type
      * Lists
    * Required
      * No
    * Interfaces to configure on the server.
### How GHOSTS Configuration Files are Modified
* Configuration files are updated with a bias for 'local' definitions to take precedence over global ones.
* application.json
  * ApiRootUrl is updated to the GHOSTS server IP.  Needs the server option to be used to define an IP or point at an existing host iin the topology.
* timeline.json
  * speedup finds fields related to inter-activity timing and divides them by the speedup factor.
  * If startup_app_credentials is set to True, the ghosts app will look for a startup app and parse any auto_login usernames for corresponding hostnames.  This user will be used to start GHOSTS, and will be inserted as the user for all remote handlers (SSH, RDP, SFTP, WMI).  This replaces any usernames already defined in these handlers in the timeline.json
  * if user is defined, this username insterted into all remote handlers.  Overrides any handlers in the timeline.json or the startup_app_credentials.
  * If any handlers are defined and a corresponding handler exists in the timeline.json, all combinations of users, ips, and commands will be added to the handler.
* credentials.json
  * Credentials are only used if the timeline specifies their credkey.

### Aging
* Speeds up the actual environment to allow the environment to live for a long time while only a few "real" hours pass.
* Has been tested up to a speedup of 730 for 24 hours.  This results in 2 years of experiment time in 1 day of real time.
* If you want them to speedup indefinitely, do not define a aging_speedup_duration

### Server
#### Create GHOSTS Server on the fly - Simple
        server:
          interfaces:
          - vlan: WWW
            address: 10.0.0.99/16
            gateway: 10.0.0.1
#### Create GHOSTS Server on the fly - Overwrite Defaults
        server:
        - hostname: ghosts-server
          cpu: 4
          memory: 4096
          image: ghosts-server.qc2
          interfaces:
          - vlan: WWW
            address: 10.0.0.99/16
            gateway: 10.0.0.1
#### Use GHOSTS Server From the Topology - Simple
        server:
        - hostname: ghosts    # Exists in the topo
          interfaces:
          - name: IF0         # Existing interface name in the topo with a static address
#### Use GHOSTS Server From the Topology - Add Interface
        server:
        - hostname: ghosts          # Exists in the topo
          interfaces:
          - vlan: WWW               # This interface will be added to the node, clients point here
            address: 10.0.0.99/16
            gateway: 10.0.0.1




## GHOSTS Client Overview
* The GHOSTS client simulates realistic human activities on a computer based on specific roles or memberships within a team.
* It creates documents, browses websites, downloads files, and interacts with various applications on Windows and Linux machines.
* GHOSTS is useful for cyber training, exercises, and testing scenarios.
* The GHOSTS client should be run as a regular user, not as an administrator or root, to accurately simulate user behavior


### The Windows Client
* GHOSTS on Windows (supporting Win7, 10, 11, and corresponding server versions) is a .NET Console application that performs various user activities.
* Instal in a directory such as c:\exercise\ghosts\
#### Installiation
* Ensure the Microsoft DotNet 4.6.1 runtime is intalled
* Download the latest client 
* Adjust config/application.{json|yaml} to point to your API server
* Run the executable at c:\exercise\ghosts\ghosts.exe to setupt and start GHOSTS.

### Linux Client
* GHOSTS on Linux requires the Microsoft dotnetcore runtime version 8.0.
#### Linux Intallation
* Download latest Linux client and unzip to a folder such as ~/ghosts.
#### Linux Service Configuration
* Create a new service file for the GHOSTS client by running the following command:
  * sudo nano /etc/systemd/system/ghosts.service
* Paste the following into the service file:
[Unit]
Description=GHOSTS Client Service
After=network.target

[Service]
ExecStart=/usr/bin/dotnet /path/to/ghosts/ghosts.client.linux.dll
WorkingDirectory=/path/to/ghosts
Restart=always
User=ghosts_user
Group=ghosts_user
Environment=DOTNET_CLI_TELEMETRY_OPTOUT=1
Environment=DISPLAY=:0

[Install]
WantedBy=multi-user.target
* Replace /path/to/ghosts with the actual path where the GHOSTS client is intalled
* Replace ghosts_user with the user under which the GHOST client should run.
* After creating the service file, reload systemd to recognize the new service
  * sudo systemctl daemon-reload
* Enable the service to start on boot
  * sudo systemctl enable ghosts
* Start the service
  * sudo systemctl start ghosts
* Check the status of the service
  * sudo systemctl status ghosts
* Stop the service
  * sudo systemctl stop ghosts
* Restart the service
  * sudo systemctl restart ghosts
* Now the GHOSTS client will run as a background serive and automatically start with your system


### Client Directory Structure
* The instance folder should NOT be copied between machines
* config/
  * Configuration files are stored here
* instance/
  * Stores files and information specific to the instance.  DO NOT COPY THIS FOLDER
* lib/
  * Third-party libraries used by GHOSTS
* logs/
  * Output logs for the client and logs transferred to the server.

### Configuration Quick Start
* After unzipping, run the client by double-clicking it.
* GHOSTS supports using YAML and JSON for the application and timeline configuration files.  
* The used configuration file is chosen in the following order or precedence
  * .yaml
  * .yml
  * .json
#### Application Configuration
* Adjust the API URLs in application.json to point to your server:
{
  "ApiRootUrl": "http://localhost:5000/api",
  "Sockets": {
    "IsEnabled": true,
    "Heartbeat": 50000
  },
  "Id": {
    "IsEnabled": true,
    "Format": "guestlocal",
    "FormatKey": "guestinfo.id",
    "FormatValue": "$formatkeyvalue$-$machinename$",
    "VMWareToolsLocation": "C:\\progra~1\\VMware\\VMware Tools\\vmtoolsd.exe"
  },
  "AllowMultipleInstances": false,
  "EncodeHeaders": true,
  "ClientResults": {
    "IsEnabled": true,
    "IsSecure": false,
    "CycleSleep": 300000
  },
  "ClientUpdates": {
    "IsEnabled": true,
    "CycleSleep": 300000
  },
  "Survey": {
    "IsEnabled": false,
    "IsSecure": false,
    "Frequency": "once",
    "CycleSleepMinutes": 5,
    "OutputFormat": "indent"
  },
  "Timeline": {
    "Location": "config/timeline.json"
  },
  "Content": {
    "EmailsMax": 20,
    "EmailContent": "",
    "EmailReply": "",
    "EmailDomain": "",
    "EmailOutside": "",
    "BlogContent": "",
    "BlogReply": "",
    "FileNames": "",
    "Dictionary": ""
  },
  "ResourceControl": {
    "ManageProcesses": true
  },
  "HealthIsEnabled": false,
  "HandlersIsEnabled": true,
  "DisableStartup": false
}
* Below is the same thing but for applicaiton.yaml:
---
ApiRootUrl: http://localhost:5000/api
Sockets:
  IsEnabled: true
  Heartbeat: 50000
Id:
  IsEnabled: true
  Format: guestlocal
  FormatKey: guestinfo.id
  FormatValue: "$formatkeyvalue$-$machinename$"
  VMWareToolsLocation: C:\progra~1\VMware\VMware Tools\vmtoolsd.exe
AllowMultipleInstances: false
EncodeHeaders: true
ClientResults:
  IsEnabled: true
  IsSecure: false
  CycleSleep: 300000
ClientUpdates:
  IsEnabled: true
  CycleSleep: 300000
Survey:
  IsEnabled: false
  IsSecure: false
  Frequency: once
  CycleSleepMinutes: 5
  OutputFormat: indent
Timeline:
  Location: config/timeline.yaml
Content:
  EmailContent: ''
  EmailReply: ''
  EmailDomain: ''
  EmailOutside: ''
  BlogContent: ''
  BlogReply: ''
  FileNames: ''
  Dictionary: ''
ResourceControl:
  ManageProcesses: true
HealthIsEnabled: false
HandlersIsEnabled: true
DisableStartup: false
#### Timeline Configuration
* The timeline.{json|yaml} file defines the agent's daily tasks, such as browsing websites, creating documents, and executing commands.
* Lost of customization options available.
* The key field in each timeline entry is the HandlerType, which specifies the task GHOSTS should perform.
* The tasks might include running commands (Command), browsing websites using Firefox or Chrom (BrowserFirefox, BrowserChrome), or creating documents in Excel or Word.
* More important configuration options:
  * Initial
    * Defines the first action the handler will execute.
  * UtcTimeOn | UtcTimeOff
    * Specifies the time window during which the task is active
    * "00:00:00" to "24:00:00" will run the task continuously, but you can customize the times to simulate real-world office hours, such as 9-5.
    * There is a random 30 minute jitter applied to these start and stop times.
  * Loop
    * Set this to true if you want the task to repeat, or false if it should only run once.
* Example Commands
  * To execute specific tatsks, you can use varioius system commands, such as:
    * Access a Network Share:
      * net use X:\Server\Share
    * Remote Desktop (RDP) Connection:
      * mstsc.exe {ConnectionFile | /v:ServerName[:Port]} [/console] [/f] [/w:Width/h:Height]
  * /v 
    * Specifices the remote machine and port (optional)
  * /console
    * Connectes to the console of a Windows Server 2003 or later
  * /f 
    * Launches RDP in full-screen mode
  * /w and /h
    * Set the width and height of the RDP window
  * File operations such as copying, moving, or deleting fiels can also be configured using standard system commands.
* Browser Configuration
  * When configuring the browser handlers (Chrome or Firefox), an initial value is require.  This could be "about:blank" if you don't want to load a page immediately or an actual URL.
  * Both HTTP and HTTPS are supported.
  * Example configuration
{
   "HandlerType": "BrowserChrome",
   "Initial": "http://google.com",
   "UtcTimeOn": "00:00:00",
   "UtcTimeOff": "24:00:00",
   "Loop": true,
   "TimeLineEvents": [
      {
         "Command": "random",
         "CommandArgs": [
            "http://google.com",
            "http://facebook.com"
         ],
         "DelayAfter": 1000,
         "DelayBefore": 0
      }
   ]
}
* Document Creation
  * You can also configure GHOSTS to create documents in Word, Excel, or Powerpoint.  
  * Here's an example for Word:
{
   "HandlerType": "Word",
   "Initial": "",
   "UtcTimeOn": "00:00:00",
   "UtcTimeOff": "24:00:00",
   "Loop": true,
   "TimeLineEvents": [
      {
         "Command": "create",
         "CommandArgs": [ "%homedrive%%homepath%\\Documents" ],
         "DelayAfter": 900000,
         "DelayBefore": 0
      }
   ]
}

### Trackables
* If you need to track the outcome of a specific timeline event, you can use the TrackableId.
* Here's an example of tracking a file download:
{
    "TimeLineHandlers": [
        {
            "HandlerType": "BrowserChrome",
            "Initial": "about:blank",
            "UtcTimeOn": "00:00:00",
            "UtcTimeOff": "24:00:00",
            "Loop": false,
            "TimeLineEvents": [
                {
                    "Command": "browse",
                    "CommandArgs": [ "https://dl.dafont.com/dl/?f=italian_breakfast" ],
                    "DelayAfter": 0,
                    "DelayBefore": 0
                },
                {
                    "Command": "download",
                    "CommandArgs": [ "//a[contains(@class, 'dlbutton')]" ],
                    "TrackableId": "<guid id from trackables table/>",
                    "DelayAfter": 0,
                    "DelayBefore": 0
                }
            ]
        }
    ]
}

### Troubleshootiing
* If clients aren't running and are throwing exceptions:
  * .NET Framework
    * Is the .NET Framework runtime 4.x intsalled on the machine?
  * GPO Whitelisting
    * If GPO is whitelisting apps, is ghosts.exe on the whitelist?
  * Manual Execution
    * Does the client run when you double-clik the .exe file?
  * Event Logs
    * Are there any reports in the Windows application event logs?
  * Logs
    * What's in the logs/app.log?
  * Startup 
    * Is the ghosts.exe set to execute automatically when the machine restarts?
  * NLog Configuration
    * Does the nlog.config contain these lines?
<AutoLoadExtensions="true"/>
<internalLogToConsole="true"/>
<internalLogFile="logs/nlog-internal.log"/>
<internalLogLevel="Error"/>
* Ensure the InternalLogFile="logs/nlog-internal.log" exists.

* If clients aren't reporting their activity to the API
  * Client status
    * Is the client running correctly
  * Client logs
    * Check the logs/clientupdates.log file.  
      * If it is too large, the GHOSTS client might be stuck processing too much data.
  * Instance/ID
    * Has the folder instance been created?  Does instance/id.json exists?
  * App Log
    * Check logs/app.log for any fatal issues
* Can I update what clients are doing?
  * Timeline Updates
    * You can update what a client does in the config/timeline.{json|timeline} file.
  * Just-In-Time Activities
    * Any files placed in the instance/timeline/in folder will be picked up, executed, and then moved to the out folder. 
    * This doesn't affect the default timeline.
* Can I reset a client on a machine?
  * Yes.
  * Launching a new instance of a GHOSTS client will automatically kill the old one, along with any associated tasks.
  * Windows
    * Run the kill-ghosts.bat script
  * Linux
    * Run the kill-ghosts.sh script
* Universal/Linux Client Won't Start
  * Check .NET version
    * Run dotnet -version and confirm .NET 9 or later.
  * Permission denied
    * Ensure ghosts.client.universal.dll is readable.
    * Do not run as root
  * Missing libicu
    * On minimal Linux images, install ICU:
      * sudo apt instal libicu-dev (Debian/Ubuntu)
  * Configuration errors
    * Verify config/application.yaml exists and ApiRootUrl points to a reachable API (include the /api suffix)
* Windows Client: .NET Framework Not Found
  * If you see an error like "This application requires .NET Framework 4.6.1 or later":
    * Download the .NET Framework 4.6.1 runtime
    * Run the installer and restart the machine
    * Verify with:
      * reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Release
* Client Reports "Connection Refused" to API
  * Verify the API is running:
    * curl http://YOUR-API-HOST:5000/api
  * Check that the URL in config/application.{json|yaml} includes the /api suffix
  * If running Docker, ensure the client can reach the host - host.docker.internal only works from within Docker, not from external machines.  Use the host's actual IP.
  * Check firewall rules on port 5000.
* Determine the running version of the client:
  * Windows
    * ghosts.exe --version
  * Universal
    * dotnet ghosts.client.universal.dll --version




## GHOSTS NPC Framework
### Overview
* GHOSTS is an NPC (or agent) orchestration framework that models and simulates realistic users on all types of computer systems, generating human-like activity across applications, networks, and workflows.
* Beyond simple automation, it can dynamically reason, chat, and create content via integrated LLMs, enabling adaptive, context-aware behavior.
* Designed for cyber training, research, and simulation, it produces realistic network traffic, supports complex multi-agent scenarios, and leaves behine realistic artifacts.

### Quick Start
* There are two supported ways to get GHOSTS running:
  * Dev Continaer
    * Best for contributors who want to build and debug the source
  * Docker Compose
    * Best for standing up the published stack quickly
#### Dev Container
* Prerequisits:
  * Docker
  * VS Code with Dev Containers extenstion (or any editor that supports the Dev Container spec)
* Clone the repository and open in VS code:
git clone https://github.com/cmu-sei/GHOSTS.git
cd GHOSTS
code .
* When prompted, choose Reopen in Container (or run Dev Containers: Reopen in Container).
* Once finished, run the stack:
cd src/Ghosts.Api
cp .env.example .env   # set POSTGRES_PASSWORD
docker compose up -d
* Can also use the .NET Aspire host for local development orchestration:
cd src/apphost
dotnet run
#### Standard Docker Compose
* To run the published stack (no source build required):
mkdir ghosts && cd ghosts
curl -O https://raw.githubusercontent.com/cmu-sei/GHOSTS/master/src/Ghosts.Api/docker-compose.yml
docker compose up -d
* Make sure to copy .env.example to .env and set POSTGRES_PASSWORD before starting
#### Services
* GHOSTS Fontend
  * localhost:4200
  * Angular management UI
* GHOSTS API
  * localhost:5000
  * REST API + Swagger at /swagger
* Grafana
  * localhost:3000
  * Activity dashboards
* n8n
  * localhost:5678
  * Workflow automation
* PostgreSQL
  * localhost:5432
  * Database
* Then install a client on each machine you want to simulate and point it at http://YOUR-API-HOST:5000/api

### Architecture
#### Core Components
* Ghosts.Api
  * .NET 10
  * Central command-and-control server.  REST API, SignalR WebSocket hub, NPC orchestration, scenario management
* Ghosts.Frontend
  * Angular 20
  * Web UI for managing machines, groups timelines, NPCs, scenarios, and workflow automation.
* Ghosts.Client.Windows
  * .NET Framework 4.6.2
  * Full-featured Windows client with Office automation, browser control, SSH, RDP, and 27+ activity handlers.
* Ghosts.Client.Universal
  * .NET 9
  * Cross-platform client for Linux/Windows with 38+ handlers
* Ghosts.Client.Lite
  * .NET 8
  * Lightweight client for resource-constrained environments.
* Ghosts.Domain
  * .NET Standard 2.0
  * Shared library:
    * timeline models
    * handler base classes
    * client configuration
#### Supporting Services
* Ghosts.Animator
  * .NET Standard 2.0
  * NPC persona generation engine (names, careers, social networks, beliefs).
* Ghosts.Pandora
  * .NET 10
  * Dynamic content generation server for realistic web content, blog posts, and documents.
* n8n
  * Docker
  * Workflow automation platform.  GHOSTS API can scehdule and trigger n8n workflows via webhook
* Grafana
  * Docker
  * Real-time dashboards for NPC activity, health metrics, and timeline execution.
#### Infrastructure
* apphost
  * .NET Aspire application host for local development orchestration.
* PostgreSQL 16
  * Primary data store for all machines, timelines, NPCs, activities, and survey data.

### Repository Layout
src/
├── Ghosts.Api/            # .NET 10 API server + docker-compose.yml
├── Ghosts.Domain/         # Shared domain library (netstandard2.0)
├── Ghosts.Frontend/       # Angular 20 management UI
├── Ghosts.Client.Windows/ # .NET 4.6.2 Windows client
├── Ghosts.Client.Universal/ # .NET 9 cross-platform client
├── Ghosts.Client.Lite/    # .NET 8 lightweight client
├── Ghosts.Animator/       # NPC persona generation
├── Ghosts.Pandora/        # Content generation server
├── apphost/               # .NET Aspire host
└── tools/                 # Utilities (load tester, machine adder, email generator)
scripts/
├── build_windows.ps1      # Build Windows client
├── build_universal.py     # Build Universal client
└── horde/                 # Bulk operation scripts
docs/                      # MkDocs documentation source

### Use Cases
* Cyber Training and Exercies
  * Populate training environments with realistic user activity.
* Red Team Operations
  * Generate believable background noise during security assessments.
* Blue Team Training
  * Create realistic network traffic for detection and analysis practice
* Research and Development
  * Test security tools and detection algorithms with realistic data
* Cognitive Range Development
  * Build immersive environments with autonomous NPCs that reason and interact.

### Choosing a Client
* Windows
  * .NET Framework 4.6.1+ 
  * Windows 1/10/11, Server 2012+
  * Full application automation (Office, browsers, RDP).  Use when participants observe the desktop.
* Universal
  * .NET 9
  * Windows, Linux, macOS
  * Cross-platform with 38+ handlers.  Default choice for Linux or mixed environments.
* Lite
  * .NET 8
  * Windows, Linux
  * Lightweight network traffic generation withoiut launching real apps.  Best for high NPC density on limited hardware.


## Gemini
#### What is the GHOSTS Framework?
* The GHOSTS framework is an open-source cyber warfare simulation and orchestrator developed by Carnegie Mellow University's Software Engineering Institute (SEI).
* Its primary focus is to inject realistic, human-like beackground activity (noise) into simulated network environments, such as cyber ranges, military training exercises, and security testbeds.  
* In a sterile test environment, there are usually no users browsing the web or sending emails, making it incredibly easy to spot "malicious" traffic.  GHOSTS solves this by populating the network with simulated users so that cyber defenders must learn to find real threats hidden within normal, daily "noise".

#### What are GHOSTS NPC CLients?
* The NPC (Non-Playbe Character) clients are the endpoint agent applications installed directly onto the virtual machines (typically Windows or Linux) within the simulated network.
* Instead of just simulating fake network packets, these clients actually control the operating system to perform real duman actions
* Features of GHOSTS NPC Clients:
  * Realistic workdays
    * NPCs have scheduled "shifts". They log in, "arrive" at work, take lunch breaks, experience random puases, and log off at the end of the day.
  * Web Interaction
    * NPCs open real web browsers, conduct searches, visit websites, and click through links.
  * Docuement Creation
    * They actively draft, open, edit, and save Microsoft Office documents (Word, Excel) and PDFs, creating realistic local file system footprints.
  * Communication
    * NPCs draft and send realistic emails via simulated SMTP servers and interact with local chat clients.
  * System Commands
    * They can run terminal commands, execute scripts, and interact with the OS registry.

#### Advanced Behavior and Phising Targets
* LLM and NLP Integration
  * Modern versions of the GHOSTS NPC clients can use Natural Language Processing (NLP) and Large Language Models (LLMs) to simulate real text when writing emails or documents.
* Social Engineering Targets
  * Because these NPCs act like real people, they can be configured with varying levels of "cybersecurity awareness".  
  * Security teams can send them simulated phising emails

#### Common Pitfalls When Deploying NPCs
* High resource consumption
* Domain Controller Dependency
  * NPCs require properly configured network services (like active DNS, Mail, and Active Directory) to fully simulate realistic domain-user behavior, meaning setup can be highly complex.





# Actual Changes Made
## Adding the Engineer Application, Timeline, and Creadentials
* I copied an application file from the administrators ghosts.
* I built a simple timeline to ssh
* I used Servo Blanca as the user for the credentials on OT-ws.

## Changing the YML Files
* In scenario-utilities.yml:
  * I added the path for the engineers profile under the ghosts section.  It uses hostname OT-ws
* Added OT-ws as a hostProcess in scenario-soh.yml
* Added a section under OT-INBOUND in scenario-vrouter.yml to allow the GHOSTS server to communicate with OT-ws:
                  - id: 22
                      description: Allow OT-ws to GHOSTS Server
                      source:
                        address: 10.68.30.20
                      ports: [80, 443]
                      protocol: tcp
                      action: accept

* Added the same configuration under the IT-INBOUND:
                    - id: 22
                      description: Allow OT-ws GHOSTS traffic to GHOSTS Server
                      source:
                        address: 10.68.30.20
                      destination:
                        address: 10.68.40.252
                      ports: [80, 443]
                      protocol: tcp
                      action: accept
* The application.json file was copied over from the application.json file in the administrators ghosts profile.  However, the first line needs to be updated as the OT domain is spearate and different from the IT domain (administrator uses IT; engineer uses OT):
* Problems I'm running into:
  * It seems that OT-ws is configured to run a base image of a ghosts profile from nic_blair (so from the root directory) rather than from what I'm defining specifically.
  * I don't want to change the base image without blair's permission.  Maybe in the final development we can do that, but for now I am going to do a band-aid fix to see if this works
  * I am going to create a script within the /topologies/nera/phenix-injects/ folder for OT-ws.  This file kills any ghost programs in the background on OT-ws and then starts the ghosts program that I actually want running.
  * Here is the script:
### Stop any rogue GHOSTS processes
Stop-Process -Name ghosts -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

### Start the official GHOSTS client securely
Start-Process -FilePath "C:\phenix\ghosts\ghosts.exe" -WorkingDirectory "C:\phenix\ghosts" -WindowStyle Hidden

  * I will add a section to the topologies-p3u.yml file that will run this script.  THis is what I added under the OT-ws section:
      injections:
        - src: /phenix/injects/${BRANCH_NAME}/OT-ws/fix-ghosts.ps1
          dst: /phenix/startup/90-fix-ghosts.ps1


  * Updated ApiRootUrl:
    * "ApiRootUrl": "http://10.68.40.252:5000/api"
* How to verify that engineers profile worked correctly (for ssh scenario):
  * Log into OT-ws with Servo Blanca's credentials
    * Password: t1ckl3r
    * Go to C:\phenix\ghosts\logs in the files finder.
    * Open the app.txt file
    * Verify that there are no erros


* Need to ensure that the username and password of the machine I am ssh into is the actual username and password for that machine.  The key just has to match the timeline.json file (so this can be whatever you want):
{
  "Version": "1.0",
  "Data": {
    "Servo.Barca": {
      "domain": "ARESELECTRIC",
      "username": "SBarca",
      "password": "dDFja2wzcg==",
      "_plaintext": "t1ckl3r"
    },
    "vyos-router": { #KEY
      "domain": "WORKGROUP", 
      "username": "vyos", #USERNAME
      "password": "dnlvcw==", #PASSWORD
      "_plaintext": "vyos"
    }
  }
}
* I am not sure if that domain name is correct.  Gemini says it is a placeholder and can be whatever (press x to doubt).

### Error 1 (That I've decided to log)
* app.txt says that the command it is using is 10.68.30.1|sbarca|show version; show interfaces; exit
* However, the command I wrote is 10.68.30.1|vyros-router|show version; show interfaces; exit
  * Not sure why the credential key is being overwritten/ignored. 
  * I re-wrote the same credential section with the username sbarca to see if that would work:
"sbarca": {
      "domain": "WORKGROUP",
      "username": "vyos",
      "password": "dnlvcw==",
      "_plaintext": "vyos"
    }




* Last saved timeline.json before moving credentials into timeline:
{
  "Status": "Run",
  "TimeLineHandlers": [
    {
      "HandlerType": "Ssh",
      "HandlerArgs": {
        "CredentialsFile": "C:\\\\phenix\\\\ghosts\\\\config\\\\credentials.json"
      },
      "Loop": "True",
      "TimeLineEvents": [
        {
          "Command": "random",
          "CommandArgs": [
            "10.68.30.251|vyos|;mkdir /opt/test; exit"
          ],
          "DelayAfter": 180000,
          "DelayBefore": 15000
        }
      ]
    }
  ]
}


* IPs of devices
* OT-ws
  * IP
    * 10.68.30.20 
  * Vlan
    * 114
  * Control Center
    * Ip
      * 10.68.30.19
    * Vlan
      * 114
  * OT-dc
    * IP
      * 10.68.30.10
    * Vlan
      * 114
  * OT-DMZ-fw
    * 10.68.0.6
    * 10.68.35.1
    * 10.68.0.9
  * DT-DMZ-guacamole
    * 10.68.35.125
  * OT-DMZ-hmi
    * 10.68.35.3




## Addition to Scenario-Utilities.yml
            hosts:
              - hostname: OT-ws
                handlers:
                  - services:
                      - ssh
                    ips:
                      - 10.68.30.251
                    users:
                      root/root|root
                    commands:
                      - mkdir /opt/test; exit;



* RDP handler:
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
            "Loop": false,
            "TimeLineEvents": [
                {
                    "Command": "random",
                    "CommandArgs": [
                        "10.68.30.19|engineer"
                    ],
                    "DelayAfter": 200,
                    "DelayBefore": 0
                }
            ]
        }