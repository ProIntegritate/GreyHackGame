// Grep, ported to GreyHack by Ichinin
if params.len == 0 or params[0] == "-h" or params[0] == "--help" then exit("<b>Usage: "+program_path.split("/")[-1]+" [filename] [searchterm1] [searchterm2] ... [searchterm N]</b>")

fileread = function (filename)

	file = get_shell.host_computer.File(filename)
	result = file.get_content
	return result
	
end function

sfilename = params[0]
content = fileread(sfilename)
slines = content.split("\n")
ipos = 0
bshow = true

for line in slines

	bshow = true // default for each line

	for ssearch in params // loop through params
		
		if ssearch != sfilename then // ... except the filename

			ipos = line.indexOf(ssearch)

			if ipos >=0 then // do we get a position or null
				// ok
			else
				// null here
				bshow = false
			end if
		
		end if

	end for

	if bshow == true then // criteria(s) match
		print (line) // show stuff
	end if
	
end for
