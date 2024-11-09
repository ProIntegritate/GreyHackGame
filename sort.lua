// sort, ported to GreyHack by Ichinin
if params.len != 2 or params[0] == "-h" or params[0] == "--help" then exit("<b>Usage: "+program_path.split("/")[-1]+" [/fullpath/infile] [/fullpath/outfile]</b>")

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

ifile = params[0]
ofile = params[1]

stuff = fileread(ifile)
lines = stuff.split(char(10))
lines.sort

result = ""
for l in lines
	result = result + l + char(10)
end for

filewrite(ofile,result)
