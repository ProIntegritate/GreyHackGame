// SSH Bruteforcer, Written by Ichinin

// l33t ascii art
if params.len == 0 or params[0] == "-h" or params[0] == "--help" then 
	print("<color=#ff0000>  _________ _________ ___ _____________                __          </color>")
	print("<color=#ff0000> /   _____//   _____//   |   \______   \_______ __ ___/  |_  ____  </color>")
	print("<color=#ff0000> \_____  \ \_____  \/    ~    \    |  _/\_  __ \  |  \   __\/ __ \ </color>")
	print("<color=#ff0000> /        \/        \    Y    /    |   \ |  | \/  |  /|  | \  ___/ </color>")
	print("<color=#ff0000>/_______  /_______  /\___|_  /|______  / |__|  |____/ |__|  \___  )</color>")
	print("<color=#ff0000>        \/        \/       \/        \/                         \/ </color>")
	print ("<color=#0088ff><b>SSHBrute - written by Ichinin.</b></color>")
	exit("<i>Usage: "+program_path.split("/")[-1]+" [passwordfile] [username] [port] [host]</i>")
end if

// get params
passfile = params[0]
login = params[1]
iport = params[2].to_int
host = params[3]

// Import metaxploit
metaxploit = include_lib("/lib/metaxploit.so")
if not metaxploit then
    metaxploit = include_lib(current_path + "/metaxploit.so")
end if
if not metaxploit then exit("Error: Can't find metaxploit library in the /lib path or the current folder")

// Do we have a port at all on host
net_session = metaxploit.net_use(host, iport)
if net_session then
	else
		exit ("Port 22 seems down on host " + host + " - exiting!")
end if

// get passfile
file = get_shell.host_computer.File(passfile)
filecontent = (file.get_content)
passwords = filecontent.split("\n")

mypc = get_shell
counter = 1

// Main loop
for pw in passwords
	if pw != "" then
		print ("<color=#00ccff>[" + counter + "/" + passwords.len + "] " + host + ", Testing password: " + pw + "</color>")
		
		// test passwrd as is
		ms = mypc.connect_service(host,22,login,pw)
		if not ms then  // do Ucase on first character
			pw = slice(pw, 0, 1).upper + slice(pw, 1, pw.len)
			ms = mypc.connect_service(host,22,login,pw)
		end if
		// todo add for-next loop with trailing 0-9
		
		// we got results!
		if ms then exit("<color=#00ff00>Credentials found: ssh " + login + "@" + pw + " " + host + " 22</color>")
		counter = counter + 1
		end if
end for

print ("Sorry, password not found")
