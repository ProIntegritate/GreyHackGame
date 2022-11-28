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
result = metaLib.overflow("0x7BEBCBE9", "dentp", newPass) // libHTTP 1.0.0
if not result then result = metaLib.overflow("0x1677DF43", "note", newPass) // libHTTP 1.0.1
if not result then result = metaLib.overflow("0x5D51D0FD", "diomixergroundopos", newPass) // libHTTP 1.0.2
if not result then result = metaLib.overflow("0x1677DF43", "note", newPass) // libHTTP 1.0.2 -> 1.0.3

if not result then result = metaLib.overflow("0x452684EF", "oroutlinent_codes", newPass) // libSSH 1.0.0
if not result then result = metaLib.overflow("0x61D11589", "guide", newPass) // libSSH 1.0.3
if not result then result = metaLib.overflow("0x5FE1917F", "olorscrollx", newPass) // libSSH 1.0.3 - 1.0.4
if not result then result = metaLib.overflow("0x5FE1917F", "orrunt++", newPass) // libSSH 1.0.3 - 1.0.4
if not result then result = metaLib.overflow("0x452684EF", "text", newPass) // libSSH 1.0.3
if not result then result = metaLib.overflow("0x31B2E17F", "etfocusonspritextsin", newPass) // libSSH 1.0.4

if not result then result = metaLib.overflow("0x3AFB18A2", "ertypelendlistantsremoverlaytransf", newPass) // libSQL 1.0.0
if not result then result = metaLib.overflow("0x67EAA167", "transformsizedeltaddregro", newPass) // libSQL 1.0.0

if not result then result = metaLib.overflow("0x3842879F", "sthangenqueuetoncolor", newPass) // libFTP 1.0.0
if not result then result = metaLib.overflow("0x3B2AD9BA", "esetd", newPass) // libFTP 1.0.0

if not result then result = metaLib.overflow("0x22154A26", "kremoverlaysourcevolumeractivetr", newPass) // libSMTP 1.0.0

if not result then exit("Program ended")
