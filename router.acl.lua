if params.len != 1 or params[0] == "-h" or params[0] == "--help" then exit("<b>Usage: "+program_path.split("/")[-1]+" [ip_address]</b>")
metaxploit = include_lib("/lib/metaxploit.so")
if not metaxploit then
    metaxploit = include_lib(current_path + "/metaxploit.so")
end if
if not metaxploit then exit("Error: Can't find metaxploit library in the /lib path or the current folder")
address = params[0]
net_session = metaxploit.net_use( address )
if not net_session then exit("Error: can't connect to net session")
metaLib = net_session.dump_lib

// Exploit chain
metaLib.overflow("0xoffset", "function")
if not result then metaLib.overflow("0xoffset", "function")

if not result then exit("Program ended")
