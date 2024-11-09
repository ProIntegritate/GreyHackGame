
// Use: Bank sweeper <exploitfile> <port> <ip series> <cOct> <dOct>
// example: sweeper 80 1.1 1 0
// the example will sweep hosts on port 80 from 1.1.1.0 to 1.1.255.255.
// Written in 2024, Ichinin

if params.len != 5 or params[0] == "-h" or params[0] == "--help" then
	exit("<b>Usage: "+program_path.split("/")[-1]+" [exploitfile] [port] [netblock, i.e. 1.1 will scan 1.1.x.x] [C octette, like 0] [D octette, like 0]")
end if

// Imports Metaxploit
metaxploit = include_lib("/lib/metaxploit.so")
if not metaxploit then
    metaxploit = include_lib(current_path + "/metaxploit.so")
end if
if not metaxploit then exit("metaxploit.so not found")

// Generic variables
file = params[0]			// file with exploits
port = params[1].to_int 		// port
addr = params[2]			// Series to scan, i.e. 1.1 (out of 1.1.x.x)
coct = params[3].to_int			// C-Octette
doct = params[4].to_int			// D-Octette
sresults = ""				// The good stuff


// Readfile
fileread = function (filename)

	file = get_shell.host_computer.File(filename)
	result = file.get_content
	return result
	
end function



// writefile
filewrite = function (filefullpath, content)

	filename = filefullpath.split("/")[-1]
	filepath = filefullpath.replace(filename,"")

	h = get_shell.host_computer
	h.touch(filepath,filename)

	foo = get_shell.host_computer.File(filepath + filename)
	foo.set_content(content)

end function



// Function: AccessBankFile
AccessBankFile = function(homeFolder)

	folders = homeFolder.get_folders
	for user in folders
		subFolders = user.get_folders
		bankFound = false
		for subFolder in subFolders
			if subFolder.name == "Config" then
				files = subFolder.get_files
				for file in files
					if file.name == "Bank.txt" then
						
						content = file.get_content
						//print (content)
						sresults = sresults + content + char(10)
						bankFound = true
					end if
				end for
			end if
		end for
	end for

	return sresults
	
end function



// Function scanhost, scans the specific host
scanhost = function (addr,port)

	bdone = 0

	net_session = metaxploit.net_use( addr, port )
	if not net_session then bdone = 1

	if bdone == 0 then

		metaLib = net_session.dump_lib

		// TODO: get addr and tag here from passed file args

		result = ""
		expoitlist = exploits.split("!")
		for exploititem in expoitlist
			if exploititem.trim != "" then
				//print ("'" + exploititem + "'")
				xplargs = exploititem.split(",")
				if not result then result = metaLib.overflow(xplargs[0], xplargs[1])
				if result then break // we got exploit handle
			end if
		end for


		if not result then bdone = 1
		
		if bdone == 0 then
			if typeof(result) != "file" then bdone = 1
		end if 
		
		if bdone == 0 then
			if not result.is_folder then bdone = 1
		end if 
		
		if bdone == 0 then
			if not result.has_permission("r") then bdone = 1
		end if 

	end if

	sresults = ""

	if bdone == 0 then

		if result.path == "/home" then
			sresults = AccessBankFile(result)
		else
			// print("Searching home folder...")
			while not result.path == "/"
				result = result.parent
			end while
	
			folders = result.get_folders
			for folder in folders
				if folder.path == "/home" then
					sresults = AccessBankFile(folder)
					// exit
				end if
			end for
		end if

	end if

	return sresults 

end function



// Main loop
exploits = ""
filecontent = fileread(file)
lines = filecontent.split("\n")
for l in lines
	if l.trim != "" then
		xpl = l.split(",")
		exploits = exploits + xpl[2] + "," + xpl[3] + "!"
	end if
end for

print ("Starting sweep")

rhost = ""
temp = ""

indexfile = 10000
sresults = "RESULTS" + char(10)

for cval in range(coct, 255)
	for dval in range(doct, 255)
		doct = 0

		rhost = addr + "." + str(cval) + "." + str(dval)
		print ("**** Scanning host " + rhost + " ****")
		temp = scanhost(rhost,port)
	
		// only add New stuf
		temporaryitems = temp.split("\n")
		for titem in temporaryitems
			if titem.trim != "" and titem.len > 16 then
				foo = sresults.indexOf(titem)
				if not foo then
					print ("<color=#004f00>-> ADDING: " + titem + "</color>")
					sresults = sresults + titem + char(10)
				end if
			end if
		end for

		temp = ""

		if sresults.len > 60000 then
			filewrite(current_path + "/bankaccounts_" + str(indexfile) + ".txt", sresults)
			indexfile = indexfile + 1
			sresults = "RESULTS" + char(10)
			print("Wrote results to bankaccounts_*****.txt")
			exit("60k file size reached - ending scan")
		end if
		print("DATA SIZE: " + sresults.len)
	end for
end for	

filewrite(current_path + "/bankaccounts_" + str(indexfile) + ".txt", sresults)
print("Wrote results to bankaccounts_*****.txt")
