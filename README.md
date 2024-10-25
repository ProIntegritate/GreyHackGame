# GreyHackGame
Various source for the game GreyHack ( https://store.steampowered.com/app/605230/Grey_Hack/ )

```
** Data **
shodan_0.8.Vanilla.zip   - Scanned services from 1.0.0.0 to 1.1.75.255. Text (csv) files.
                           This does not reflect data from the Nightly build and will differ.

** Tools **
cleartrash               - Clears out files from .Trash folders.
processmonitor           - List active processes in realtime.
GreyHack_Game_OSINT.txt  - Tools and techniquest to get information about a host
trysploit                - Try exploit and report what it does
ver                      - Get version number from lib file
sshbrute                 - A SSH Bruteforcer
sweeper (Video below)    - A script to sweep complete subnets for Bank.txt. Fast, but has some issues.
portscanner              - A basic portscanner. Not needed since NMAP exists in the game, written for fun.
verscan                  - Scans a subnet for port and service version number to quickly find vulnerable hosts.
services                 - A services enable/disabler (Only affects lib files that starts with "lib*").
harden                   - Harden, locks down your system a bit better.
genmap (Video below)     - Automatically exploit N random hosts, dump passwords, crack and generate a Maps.conf file.
ransomware (Video below) - Simulates ransomware in GreyHack, encrypts data with a static key using a simple cipher.

** Attack tools ** (Templates, add your own exploits)
change.passwd            - Generic tool for changing password on hosts, supports multiple services. 
get.passwd               - Generic tool for getting /etc/passwd from host, supports multiple services.
get.shell                - Generic tool for getting a shell on host, supports multiple services.
local.get.shell          - A local script to jump from guest to user.
local.get.passwd         - A script to get /etc/passwd if local.get.shell doesn't work.
router.acl               - Router ACL changer.

** Ported Unix commands **
uniq                     - Print unique strings from a text file.
which                    - Find a file anywhere on the system.
grep                     - Find strings in text file.
date                     - Show current date and time

** Misc stuff **
functions_hextodec       - functions to conver from hex to dec and dec to hex.
functions_fileaccess.lua - simplified wrapper functions for file access.
```
(NOTE: Save files in the game as .src, not .lua. I just used .lua to get color markup on GitHub)

Videos:

The Sweeper tool can be seen in action here: https://www.youtube.com/watch?v=ddDQ3fTPIGg

The ransomware POC code can be seen in action here: https://www.youtube.com/watch?v=zUsNh2jP9no

The Genmap tool can be seen in action here: https://www.youtube.com/watch?v=OIBUpBiuyR0
