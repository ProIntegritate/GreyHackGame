// Use: sweeper <port> <ip series> <from> <to>
// example: sweeper 22 1.1.1. 0 255
// the example will sweep hosts from 1.1.1.0 to 1.1.1.255.
// This version has some issues and limitations but works. Find them out for yourself.
// Written in 2022, Ichinin

// Imports Metaxploit
metaxploit = include_lib("/lib/metaxploit.so")
if not metaxploit then
    metaxploit = include_lib(current_path + "/metaxploit.so")
end if
if not metaxploit then exit("metaxploit.so not found")

// Generic variables
port = params[0].to_int 		// port, should be 22
addr = params[1]				// Series to scan, i.e. 1.1.1. + num
iFrom = params[2].to_int		// start for iterator
iTo = params[3].to_int			// start for iterator
num = iFrom						// Iterator for addr
sresults = ""					// The good stuff


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
						// if not file.has_permission("r") then print("failed. Can't access to file contents. Permission denied")
						//print("success! Printing file contents...\n" + file.get_content)
						//print(file.get_content)

						//if not file.has_permission("r") then
						//end if 
						
						content = file.get_content
						print (content)
						sresults = sresults + content + "\n"
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

		// print ("Doing checks...")

		metaLib = net_session.dump_lib

		// SSH exploit chain
		result = metaLib.overflow("0x452684EF", "onclip")
		if not result then result = metaLib.overflow("0x195DE399", "tiondingsupdate")
		if not result then result = metaLib.overflow("0x69D98184", "icked")
		if not result then result = metaLib.overflow("0x784B57C1", "ostrstantsremoverlaytran")
		
		// HTTP exploit chain
		if not result then result = metaLib.overflow("0x7BEBCBE9", "source")
		if not result then result = metaLib.overflow("0x121C868A", "elanchoroundowmati")
		if not result then result = metaLib.overflow("0x4CE4CDDE", "backgroupblocall0f")
		if not result then result = metaLib.overflow("0x79E2F224", "bestempl")
		if not result then result = metaLib.overflow("0x314959AC", "inishstaticti")
		if not result then result = metaLib.overflow("0x314959AC", "odalpha")
		if not result then result = metaLib.overflow("0x4CE4CDDE", "udiosoundosefals") // 1.0.3

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
		

		// print ("Passed checks")
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

	//sresults = sresults + "-\n"

	return sresults 

end function


// Main loop

print ("Starting")

rhost = ""
temp = ""

  while num <= iTo
	rhost = addr + num
	print ("**** scanning host " + rhost + " ****")
	temp = scanhost(rhost,port)
	
	pos = sresults.indexOf(temp)
	if pos > 0 then
	else
		sresults = sresults + temp
	end if
	temp = ""
	
    num = num + 1
  end while

// clear_screen
print ("---------------------")
print ("Results of sweep:")
print ("---------------------")
print (sresults)
