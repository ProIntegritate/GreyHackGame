metaxploit = include_lib("/lib/metaxploit.so")
if not metaxploit then
    metaxploit = include_lib(current_path + "/metaxploit.so")
end if
if not metaxploit then exit("Error: Can't find metaxploit library in the /lib path or the current folder")
metaLib = metaxploit.load("/lib/kernel_module.so")
if not metaLib then exit("Can't find " + "/lib/kernel_module.so")

// 
// Exploit chain
// 
result = metaLib.overflow("0x1302850E", "lusb")
if not result then result = metaLib.overflow("0x5A9D2353", "orlinentainenumobjectev")
if not result then result = metaLib.overflow("0x2F15DD42", "contextree")
if not result then result = metaLib.overflow("0x40B4A387", "stored_bitsdyn_dt")
if not result then result = metaLib.overflow("0x1302850E", "lusb")
if not result then result = metaLib.overflow("0x6DD0D081", "note")
if not result then result = metaLib.overflow("0x7B9BE70A", "bofitext")
if not result then result = metaLib.overflow("0x75E941FB", "viewporttextefferro")
if not result then result = metaLib.overflow("0x7B9BE70A", "greattim")

if not result then exit("Program ended")
if typeof(result) == "shell" then
	result.start_terminal
else
	print("Error: expected shell, obtained: " + result)
end if
