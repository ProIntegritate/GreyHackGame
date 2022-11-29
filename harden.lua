print ("Harden, written by Ichinin")
print ("Run tool like:  sudo harden, or run as root (sudo -s)")
print ("Do NOT give sudo a full path or it won't work")

f = function(target)

    if target.is_folder then
        files = target.get_files
        for file in files
            f(file)
        end for
        folders = target.get_folders
        for folder in folders
            f(folder)
        end for
    end if

	// get the filename from the iterator
	result = target.path
	comp = get_shell.host_computer
	fileobject = comp.File(result)
	fileobject.chmod("o-wrx", true)	
	
	// Generally, remove all other (o-wrx) rights from objects
	print ("<color=#00ff00>chmod o-wrx on object " + result + "</color>")
	fileobject.chmod("o-wrx", true)
	
	if result.indexOf("/etc") >=0 then
		print ("<color=#00ffff>chmod g-wrx on object " + result + "</color>")
		fileobject.chmod("g-wrx", true)
	end if

	if result.indexOf("/sys") >=0 then
		print ("<color=#00ffff>chmod g-wrx on object " + result + "</color>")
		fileobject.chmod("g-wrx", true)
	end if

	if result.indexOf("/boot") >=0 then
		print ("<color=#00ffff>chmod g-wrx on object " + result + "</color>")
		fileobject.chmod("g-wrx", true)
	end if

	if result.indexOf("/var") >=0 then
		print ("<color=#00ffff>chmod g-wrx on object " + result + "</color>")
		fileobject.chmod("g-wrx", true)
	end if

	if result.indexOf("/lib") >=0 then
		print ("<color=#00ffff>chmod g-wrx on object " + result + "</color>")
		fileobject.chmod("g-wx", true)
	end if

	if result.indexOf("/home") >=0 then
		print ("<color=#00ffff>chmod g-wrx on object " + result + "</color>")
		fileobject.chmod("g-x", true)
	end if

	if result.indexOf("/root") >=0 then
		print ("<color=#00ffff>chmod g-wrx on object " + result + "</color>")
		fileobject.chmod("g-wrx", true)
	end if

	if result.indexOf("/Public") >=0 then
		print ("<color=#00ffff>chmod g-wrx on object " + result + "</color>")
		fileobject.chmod("g-wx", true)
	end if

	if result.indexOf("/server") >=0 then
		print ("<color=#00ffff>chmod g-wrx on object " + result + "</color>")
		fileobject.chmod("g-wx", true)
	end if

	if result.indexOf("/usr") >=0 then
		print ("<color=#00ffff>chmod g-wrx on object " + result + "</color>")
		fileobject.chmod("g-w", true)
		print ("<color=#ff00cc>changing ownership of " + result + "</color>")
		fileobject.set_owner("root", true)
		fileobject.set_group("root", true)
	end if

	if result.indexOf("/bin") >=0 then
		print ("<color=#00ffff>chmod g-wrx on object " + result + "</color>")
		fileobject.chmod("g-w", true)
		print ("<color=#ff00cc>changing ownership of " + result + "</color>")
		fileobject.set_owner("root", true)
		fileobject.set_group("root", true)
	end if

	if result.indexOf("/guest") >=0 then
		print ("<color=#ff0000>deleting object " + result + "</color>")
		fileobject.chmod("g-wrx", true)
		fileobject.chmod("u-wrx", true)
		fileobject.delete
	end if

	print(fileobject.permissions)

end function

target = get_shell.host_computer.File("/")
f(target)

