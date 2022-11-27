if params.len != 2 or params[0] == "-h" or params[0] == "--help" then exit("<b>Usage: "+program_path.split("/")[-1]+" [ip_address] [port]</b>")
metaxploit = include_lib("/lib/metaxploit.so")
if not metaxploit then
    metaxploit = include_lib(current_path + "/metaxploit.so")
end if
if not metaxploit then exit("Error: Can't find metaxploit library in the /lib path or the current folder")
address = params[0]
port = params[1].to_int
net_session = metaxploit.net_use( address, port )
if not net_session then exit("Error: can't connect to net session")
metaLib = net_session.dump_lib

// 
// Exploit chain: No particular order needed.
// 
result = metaLib.overflow("0x656FAD1E", "formlockdyn_t") // libFTP 1.0.0
if not result then result = metaLib.overflow("0x656FAD1E", "rhsa") // libFTP 1.0.0
if not result then result = metaLib.overflow("0x14316037", "offsetactablete") // libFTP 1.0.1
if not result then result = metaLib.overflow("0x3AFB18A2", "colon") // libSQL 1.0.0
if not result then result = metaLib.overflow("0x656FAD1E", "formlockdyn_t") // libFTP 1.0.0
if not result then result = metaLib.overflow("0x656FAD1E", "rhsa") // libFTP 1.0.0
if not result then result = metaLib.overflow("0x14316037", "offsetactablete") // libFTP 1.0.1
if not result then result = metaLib.overflow("0x7BEBCBE9", "source") // libHTTP 1.0.3
if not result then result = metaLib.overflow("0x5FE1917F", "rinser") // libSSH 1.0.0

if not result then exit("Program ended")
cryptools = include_lib("/lib/crypto.so")
if not cryptools then
	cryptools = include_lib(current_path + "/crypto.so")
end if
if not cryptools then exit("Error: Can't find crypto.so library in the /lib path or the current folder")

GetPassword = function(userPass)
	if userPass.len != 2 then exit("decipher: " + file.path + " wrong syntax")
	password = cryptools.decipher(userPass[1])
	return password
end function

typeObject = typeof(result)
if(typeObject != "computer") then exit("Error: expected computer, obtained " + typeObject)
file = result.File("/etc/passwd")
if not file then exit("Error: file /etc/passwd not found")
if not file.has_permission("r") then exit("Error: can't read /etc/passwd. Permission denied.")
if file.is_binary then exit("Error: invalid /etc/passwd file found.")
listUsers = file.get_content.split("\n")
for line in listUsers
	userPass = line.split(":")
	print("Deciphering user " + userPass[0] +"...")
	password = GetPassword(userPass)
	if not password then 
		print("Nothing found...")
	else
		print("=> " + password)
	end if
end for
