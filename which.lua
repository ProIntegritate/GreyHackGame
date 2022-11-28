// Which, ported to GreyHack by Ichinin, based upon some other guys folder iterator code
if params.len == 0 or params[0] == "-h" or params[0] == "--help" then exit("<b>Usage: "+program_path.split("/")[-1]+" [searchterm]</b>")

search = params[0]

target = get_shell.host_computer.File("/")

f = function(target)
	result = target.path
	
	if result.indexOf(search) >0 then
		print result
	end if

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
end function

f(target)
