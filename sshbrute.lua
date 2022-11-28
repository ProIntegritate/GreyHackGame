
// SSH Bruteforcer, Written by Ichinin
if params.len == 0 or params[0] == "-h" or params[0] == "--help" then 
	print ("<b>SSHBrute, written by Ichinin.</b>")
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
		print ("Testing password: " + pw + "  [" + counter + "/" + passwords.len + "]")
		
		ms = mypc.connect_service(host,22,login,pw)
		if not ms then 
			pw = slice(pw, 0, 1).upper + slice(pw, 1, pw.len)
			ms = mypc.connect_service(host,22,login,pw)
		end if
		// todo add for-next loop with trailing 0-9
	
		if ms then exit("Password for user " + login + " is " + pw)
		counter = counter + 1
		end if
end for

print ("Sorry, password not found")
