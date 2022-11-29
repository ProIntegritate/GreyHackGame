# GreyHackGame
Various source for the game GreyHack ( https://store.steampowered.com/app/605230/Grey_Hack/ )

```
** Tools **
trysploit         - Try exploit and report what it does
ver               - Get version number from lib file
sshbrute          - A SSH Bruteforcer
sweeper           - A script to sweep complete subnets for Bank.txt. Fast, but has some issues.
portscanner       - A basic portscanner. Not needed since NMAP exists in the game, written for fun.

** Attack tools **
change.passwd     - Generic tool for changing password on hosts, supports multiple services. (Add your own exploits)
get.passwd        - Generic tool for getting /etc/passwd from host, supports multiple services. (Add your own exploits)
get.shell         - Generic tool for getting a shell on host, supports multiple services. (Add your own exploits)
local.get.shell   - A local script to jump from guest to user. (Add your own exploits)
local.get.passwd  - A script to get /etc/passwd if local.get.shell doesn't work. (Add your own exploits)

** Ported Unix commands **
uniq              - A port of the Unix command uniq to GreyHack
which             - A port of the Unix command which to GreyHack
grep              - A port of the Unix command grep to GreyHack
```
(NOTE: Save files in the game as .src, not .lua. I just used .lua to get color markup on GitHub)

The Sweeper tool can be seen in action here: https://www.youtube.com/watch?v=ddDQ3fTPIGg
