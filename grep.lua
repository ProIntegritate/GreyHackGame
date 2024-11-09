// Grep, ported to GreyHack by Ichinin
if params.len < 3 or params[0] == "-h" or params[0] == "--help" then exit("<b>Usage: "+program_path.split("/")[-1]+" [/fullpath/infile] [/fullpath/outfile] [searchterm1] [searchterm2] ... [searchterm N]</b>")

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
content = fileread(ifile)
slines = content.split("\n")
sresult = ""

for line in slines

	for ssearch in params // loop through params
		if ssearch != ifile and ssearch != ofile then // ... except the filename
			if line.indexOf(ssearch) >=0 then // do we get a position or null
				sresult = sresult + line + char(10)
			end if
		end if
	end for
	
end for

filewrite(ofile, sresult)
