# GreyHackGame
Various source for the game GreyHack ( https://store.steampowered.com/app/605230/Grey_Hack/ )

```
** Tools **
trysploit         - Try exploit and report what it does
ver               - Get version number from lib file
sshbrute          - A SSH Bruteforcer
sweeper           - A script to sweep complete subnets for Bank.txt. Fast, but has some issues.
portscanner       - A basic portscanner. Not needed since NMAP exists in the game, written for fun.
verscan           - Scans a subnet for port and service version number to quickly find vulnerable hosts.
services          - A services enable/disabler (Only affects lib files that starts with "lib*").
harden            - Harden, locks down your system a bit better.

** Attack tools ** (Add your own exploits)
change.passwd     - Generic tool for changing password on hosts, supports multiple services. 
get.passwd        - Generic tool for getting /etc/passwd from host, supports multiple services.
get.shell         - Generic tool for getting a shell on host, supports multiple services.
local.get.shell   - A local script to jump from guest to user.
local.get.passwd  - A script to get /etc/passwd if local.get.shell doesn't work.

** Ported Unix commands **
uniq              - Print unique strings from a text file.
which             - Find a file anywhere on the system
grep              - Find strings in text file.
```
(NOTE: Save files in the game as .src, not .lua. I just used .lua to get color markup on GitHub)

The Sweeper tool can be seen in action here: https://www.youtube.com/watch?v=ddDQ3fTPIGg
