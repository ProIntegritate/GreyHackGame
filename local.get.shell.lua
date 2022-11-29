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
result = metaLib.overflow("0xoffset", "function")
if not result then result = metaLib.overflow("0xoffset", "function")

if not result then exit("Program ended")
if typeof(result) == "shell" then
	result.start_terminal
else
	print("Error: expected shell, obtained: " + result)
end if
