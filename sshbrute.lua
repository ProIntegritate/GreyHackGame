// SSH Bruteforcer, Written by Ichinin
if params.len == 0 or params[0] == "-h" or params[0] == "--help" then 
	
	print("<color=#ff0000>  _________ _________ ___ _____________                __          </color>")
	print("<color=#ff0000> /   _____//   _____//   |   \______   \_______ __ ___/  |_  ____  </color>")
	print("<color=#ff0000> \_____  \ \_____  \/    ~    \    |  _/\_  __ \  |  \   __\/ __ \ </color>")
	print("<color=#ff0000> /        \/        \    Y    /    |   \ |  | \/  |  /|  | \  ___/ </color>")
	print("<color=#ff0000>/_______  /_______  /\___|_  /|______  / |__|  |____/ |__|  \___  )</color>")
	print("<color=#ff0000>        \/        \/       \/        \/                         \/ </color>")
	print ("<color=#0088ff><b>SSHBrute - written by Ichinin.</b></color>")
	exit("<i>Usage: "+program_path.split("/")[-1]+" [passwordfile] [host] [username]</i>")
end if

passfile = params[0]
host = params[1]
login = params[2]

file = get_shell.host_computer.File(passfile)
filecontent = (file.get_content)

passwords = filecontent.split("\n")

mypc = get_shell
counter = 1

for pw in passwords
	if pw != "" then
		print ("<color=#00ccff>Testing password: " + pw + "  [" + counter + "/" + passwords.len + "]</color>")
		
		ms = mypc.connect_service(host,22,login,pw)
		if not ms then 
			pw = slice(pw, 0, 1).upper + slice(pw, 1, pw.len)
			ms = mypc.connect_service(host,22,login,pw)
		end if
		// todo add for-next loop with trailing 0-9
	
		if ms then exit("<color=#00ff00>Password for user " + login + " is " + pw + "</color>")
		counter = counter + 1
		end if
end for

print ("Sorry, password not found")
