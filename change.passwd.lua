if params.len != 2 or params[0] == "-h" or params[0] == "--help" then exit("<b>Usage: "+program_path.split("/")[-1]+" [ip_address] [port]</b>")
metaxploit = include_lib("/lib/metaxploit.so")
if not metaxploit then
    metaxploit = include_lib(current_path + "/metaxploit.so")
end if
if not metaxploit then exit("Error: Can't find metaxploit library in the /lib path or the current folder")
address = params[0]
port = params[1].to_int
net_session = metaxploit.net_use( address, port )
if not net_session then exit("Error: can't connect to net session")
metaLib = net_session.dump_lib
newPass = user_input("Enter new password: ")

//
// Exploit chain. No particular order needed.
//
result = metaLib.overflow("0xoffset", "function", newPass) // libxxx 1.0.0
if not result then result = metaLib.overflow("0xoffset", "function", newPass) // libxxx 1.0.0

if not result then exit("Program ended")
