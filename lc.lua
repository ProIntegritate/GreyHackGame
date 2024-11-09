// lc, ported to GreyHack by Ichinin
if params.len != 1 or params[0] == "-h" or params[0] == "--help" then exit("<b>Usage: "+program_path.split("/")[-1]+" [/fullpath/infile] [/fullpath/outfile] [searchterm1] [searchterm2] ... [searchterm N]</b>")

fileread = function (filename)

	file = get_shell.host_computer.File(filename)
	result = file.get_content
	return result
	
end function

stuff = fileread(params[0])
lines = stuff.split(char(10))
print ("Lines: " + lines.len)
