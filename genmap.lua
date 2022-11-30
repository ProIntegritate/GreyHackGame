// Add your own explots for dumping and cracking /etc/passwd, the more the better.

// --------------------------------------------------------------------------------

cryptools = include_lib("/lib/crypto.so") // put her because of cryptools variable reach
if not cryptools then
	cryptools = include_lib(current_path + "/crypto.so")
end if
if not cryptools then exit("Error: Can't find crypto.so library in the /lib path or the current folder")

// --------------------------------------------------------------------------------

GetPassword = function(userPass)
	if userPass.len != 2 then exit("decipher: " + file.path + " wrong syntax")
	password = cryptools.decipher(userPass[1])
	return password
end function

// --------------------------------------------------------------------------------

sploithost = function(ip, port) // add param for exploits file

	b = true

	net_session = metaxploit.net_use( ip, 22 ) // Is the SSH service running?
	if not net_session then b = false

	net_session = metaxploit.net_use( ip, port ) // Is there an exploitable service there?
	if not net_session then b = false	
	
	if b == true then
		metaLib = net_session.dump_lib

		// 
		// Exploit chain: No particular order needed.
		// 
		
		// libSSH
		result = metaLib.overflow("0x11C0D524", "oninvoken") // LibSSH 1.0.0
		if not result then result = metaLib.overflow("0x11C0D524", "schecked") // LibSSH 1.0.0 - 1.0.1
		if not result then result = metaLib.overflow("0x74EF58A1", "buttontenertedistundow_s") // LibSSH 1.0.0
		if not result then result = metaLib.overflow("0x5D4DF7B6", "omponenumsizelinenumber") // LibSSH 1.0.0
		if not result then result = metaLib.overflow("0x4704882F", "uttonimagecodesetvarvents") // LibSSH 1.0.1
	
		// libSMTP
		result = metaLib.overflow("0x7CC7A35B", "loat") // libSMTP 1.0.0
		
		if not result then b = false

	end if
	
	if b == true then
		typeObject = typeof(result)
		if(typeObject != "computer") then b = false
	end if

	if b == true then
		file = result.File("/etc/passwd")
		if not file then b = false
		
	end if

	if b == true then
		if not file.has_permission("r") then b = false
	end if

	if b == true then
		if file.is_binary then b = false
	end if

	if b == true then

		users = file.get_content
		print ("<color=#008844>" + users + "</color>")
		listUsers = users.split("\n")
		
		for line in listUsers
			userPass = line.split(":")
			print("Deciphering user " + userPass[0] +"...")
			
			if userPass[0] == "root" then
				password = GetPassword(userPass)
				if not password then 
					// print("Nothing found...")
				else
					// print("=> " + password)
					return password
				end if
			end if

		end for

	end if	

	return ""

end function

// --------------------------------------------------------------------------------

// Check params/show help
if params.len == 0 or params[0] == "-h" or params[0] == "--help" then 


	print("<color=#44cc44>  ________                  _____        __________ </color>")
	print("<color=#44cc44> /  _____/  ____   ____    /     \ _____ \______   \</color>")
	print("<color=#44cc44>/   \  ____/ __ \ /    \  /  \ /  \\__  \ |     ___/</color>")
	print("<color=#44cc44>\    \_\  \  ___/|   |  \/    Y    \/ __ \|    |    </color>")
	print("<color=#44cc44> \______  /\___  >___|  /\____|__  (____  /____|    </color>")
	print("<color=#44cc44>        \/     \/     \/         \/     \/          </color>")

	print ("<color=#0088ff><b>GenMap - written by Ichinin.</b></color>")
	print ("<color=#0088ff><b>Generates a Map file in your Config folder</b></color>")
	print ("<color=#0088ff><b>File is saved as Map.conf.NEW and won't overwrite anything</b></color>")
	exit("<i>Usage: "+program_path.split("/")[-1]+" [number of hops, more = slower] </i>")
end if

// Load metaxploit
metaxploit = include_lib("/lib/metaxploit.so")
if not metaxploit then
    metaxploit = include_lib(current_path + "/metaxploit.so")
end if
if not metaxploit then exit("Error: Can't find metaxploit library in the /lib path or the current folder")


// set up params
steps = params[0].to_int
//exploitfile = params[1] // Not implemented for public release
results = "{'accounts':["
ihosts = 1

// main loop
while ihosts <= steps

	randomhost = floor((rnd * 255) + 1) + "." + floor((rnd * 255) + 1) + "." + floor((rnd * 255) + 1) + "." + floor((rnd * 255) + 1)
	print ("Trying exploits chain against " + randomhost + "...")
	
	// Run exploit against multiple services.
	pw = sploithost(randomhost,22)
	if pw == "" then pw = sploithost(randomhost,80)
	if pw == "" then pw = sploithost(randomhost,21)
	if pw == "" then pw = sploithost(randomhost,25)
	
	if pw != "" then
	
		results = results + "{'user':'root','ip':'" + randomhost + "','password':'" + pw + "'}"
	
		if ihosts < steps then // add , to all but last line
			results = results + ","
		end if

		ihosts = ihosts + 1
		
		print ("<color=#00ff00>SUCCESS! Adding to map.conf</color>")
	else
		print ("<color=#ff4400>Failed.</color>")
	end if	
	print ("<color=#00ffff>Count " + ihosts + "/" + steps + "</color>")
	
end while

results = results + "],'historyConnections':[]}"
results = results.replace("'", char(34))

print (results)

// save to outfile

filewrite = function (filepath, filename, content)

	// Touch file so it exists
	h = get_shell.host_computer
	h.touch(filepath,filename)

	// Write file
	foo = get_shell.host_computer.File(filepath + filename)
	foo.set_content(content)

end function

spath = "/home/" + active_user + "/Config/"
fpath = "Map.conf.NEW"
filewrite(spath,fpath, results)

print ("Write " + fpath + " to " + spath)

