metaxploit = include_lib("/lib/metaxploit.so")
if not metaxploit then
    metaxploit = include_lib(current_path + "/metaxploit.so")
end if
if not metaxploit then exit("Error: Can't find metaxploit library in the /lib path or the current folder")
metaLib = metaxploit.load("/lib/aptclient.so")
if not metaLib then exit("Can't find " + "/lib/aptclient.so")

// 
// Exploit chain
// 
result = metaLib.overflow("0xoffset", "function")
if not result then result = metaLib.overflow("0xoffset", "function")


if not result then exit("Program ended")
if typeof(result) != "file" then exit("Error: expected file, obtained: " + result)
if not result.is_folder then exit("Error: expected folder, obtained file: " + result.path)
if not result.has_permission("r") then exit("Error: can't access to " + result.path + ". Permission denied." )
AccessPasswdFile = function(result)
	print("Accesing to password file...")
	files = result.get_files
	for file in files
		if file.name == "passwd" then
			if not file.has_permission("r") then exit("failed. Can't access to file contents. Permission denied")
			exit("success! loading content...\n" + file.get_content)
		end if
	end for
	exit("Error: /etc/passwd file not found. Program aborted");
end function

print("Obtained access to " + result.path)
if result.path == "/etc" then
	AccessPasswdFile(result)

else 
	print("Attempting to reach /etc folder...")
	while result.path != "/"
		result = result.parent
	end while
	folders = result.get_folders
	for folder in folders
		if folder.path == "/etc" then
			AccessPasswdFile(folder)
		end if
	end for
end if
