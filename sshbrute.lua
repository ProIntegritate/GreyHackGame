// SSH Bruteforcer, Written by Ichinin
if params.len == 0 or params[0] == "-h" or params[0] == "--help" then exit("<b>Usage: "+program_path.split("/")[-1]+" [passwordfile] [host] [username]</b>")

passfile = params[0]
host = params[1]
login = params[2]

file = get_shell.host_computer.File(passfile)
filecontent = (file.get_content)

passwords = filecontent.split("\n")

mypc = get_shell
counter = 1

for pw in passwords
	print ("Testing password: " + pw + "  [" + counter + "/" + passwords.len + "]")
	ms = mypc.connect_service(host,22,login,pw)
	if ms then exit("Password for user " + login + " is " + pw)
	counter = counter + 1
end for

print ("Sorry, password not found")
