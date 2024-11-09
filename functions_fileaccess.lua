fileread = function (filename)

	file = get_shell.host_computer.File(filename)
	result = ""
	if file then result = file.get_content
	return result
	
end function


filewrite = function (filefullpath, content)

	filename = filefullpath.split("/")[-1]
	filepath = filefullpath.replace(filename,"")

	// Touch file so it exists
	h = get_shell.host_computer
	h.touch(filepath,filename)

	// Write file
	foo = get_shell.host_computer.File(filepath + filename)
	foo.set_content(content)

end function


fileappend = function (filefullpath, content)

	filename = filefullpath.split("/")[-1]
	filepath = filefullpath.replace(filename,"")

	// get current content
	file = get_shell.host_computer.File(filepath + filename)
	currentcontent = file.get_content
	
	// print("DEBUG: " + currentcontent)
	
	// append new content to current content
	currentcontent = currentcontent + content

	// print("DEBUG: " + filepath + filename)

	// Write back file
	filea = get_shell.host_computer.File(filepath + filename)
	filea.set_content(currentcontent)
	
end function


// ---- Test code ----
print ("\n")
print ("TEST 001 - Reading file")
stuff = fileread("/etc/passwd")
print ("DEBUG: " + stuff + "\n")

print ("\n")
print ("TEST 002 - Writing file")
filewrite("/home/r00t/passwd.txt",stuff)

print ("\n")
print ("TEST 003 - Appending file")
fileappend("/home/r00t/passwd.txt","\nbanana:827ccb0eea8a706c4c34a16891f84e7b\n")
print ("\n")

