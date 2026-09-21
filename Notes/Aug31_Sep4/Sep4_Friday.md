# Goals for Today
* Get ghosts engineer profile to work with new ignition images.



# Notes
* I took this out of the timeline to see if it is causing issues with the rdp and sftp.
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
                    "DelayBefore": 10000
                }
            ]
        },



# What I did Today