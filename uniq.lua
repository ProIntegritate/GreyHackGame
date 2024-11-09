// Uniq, ported to GreyHack by Ichinin

fileread = function (filename)

	file = get_shell.host_computer.File(filename)
	result = file.get_content
	return result
	
end function

filewrite = function (filefullpath, content)

	filename = filefullpath.split("/")[-1]
	filepath = filefullpath.replace(filename,"")

	// Touch file so it exists
	h = get_shell.host_computer
	h.touch(filepath,filename)

	// Write file
	//foo = get_shell.host_computer.File(filepath + filename)
	foo = get_shell.host_computer.File(filefullpath)
	foo.set_content(content)

end function

if params.len != 2 or params[0] == "-h" or params[0] == "--help" then exit("<b>Usage: "+program_path.split("/")[-1]+" [/fullpath/infile] [/fullpath/outfile]</b>")

ifile = params[0]
ofile = params[1]
stuff = fileread(ifile)
foo = stuff.split("\n")
result = ""

for x in foo
	if result.indexOf(x) >= 0 then
	else
		result = result + x + char(10)
	end if
end for

filewrite(ofile,result)
