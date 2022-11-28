// Uniq, ported to GreyHack by Ichinin
if params.len == 0 or params[0] == "-h" or params[0] == "--help" then exit("<b>Usage: "+program_path.split("/")[-1]+" [filename]</b>")

sfile = params[0]
file = get_shell.host_computer.File(sfile)

stuff = file.get_content

foo = stuff.split("\n")

result = ""

for x in foo
	
	if result.indexOf(x) >= 0 then
	else
		result = result + x + ","
	end if

end for

print (result.replace(",","\n"))
