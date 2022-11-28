# GreyHackGame
Various source for the game GreyHack ( https://store.steampowered.com/app/605230/Grey_Hack/ )

```
trysploit         - Command line tool to try an exploit and get some sense of what category
                    it belongs to before implementing it in code.
ver               - Command line tool to find out version of a file
portscanner       - A basic portscanner. Not needed since NMAP exists in the game, written for fun.
change.passwd     - Generic tool for changing password on hosts, supports multiple services.
get.passwd        - Generic tool for getting /etc/passwd from host, supports multiple services.
get.shell         - Generic tool for getting a shell on host, supports multiple services.
sweeper           - A script to sweep complete subnets for Bank.txt. Fast, but has some issues.
local.get.shell   - A local script to jump from guest to user.
local.get.passwd  - A script to get /etc/passwd if local.get.shell doesn't work.
uniq              - A port of the Unix command uniq to GreyHack
which             - A port of the Unix command which to GreyHack
```
(NOTE: Save files in the game as .src, not .lua. I just used .lua to get color markup on GitHub)

The Sweeper tool can be seen in action here: https://www.youtube.com/watch?v=ddDQ3fTPIGg
