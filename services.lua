// Services enabler/disable: true = all services running, false = all services disabled (still shows up on portscan)
// Written by Ichinin
if params.len == 0 or params[0] == "-h" or params[0] == "--help" then exit("<b>Usage: "+program_path.split("/")[-1]+" [true/false]</b>")

current_path = "/lib/"

folder = get_shell.host_computer.File("/lib/")
files = folder.get_files

if params[0] == "false" then
	
	print ("Disabling services...")
	for fi in files
		if fi.name.indexOf("lib") >= 0 then
			if fi.name.indexOf(".sox") >= 0 then
			else
				fi.rename(fi.name + "x")
			end if
		end if
	end for

end if

if params[0] == "true" then

	print ("Enabling services...")
	for fi in files
		if fi.name.indexOf("lib") >= 0 then
			if fi.name.indexOf(".sox") >= 0 then
				fi.rename(fi.name.replace("sox","so"))
			end if
		end if
	end for

end if

print ("Done!")
