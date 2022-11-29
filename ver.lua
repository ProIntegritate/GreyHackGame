// ver.src, Get version of file. Enter full path to lib file
// Written in 2022, Ichinin

if params.len == 0 or params[0] == "-h" or params[0] == "--help" then exit("<b>Usage: "+program_path.split("/")[-1]+" [full path to lib]</b>")

metaxploit = include_lib("/lib/metaxploit.so")
if not metaxploit then
    metaxploit = include_lib(current_path + "/metaxploit.so")
end if

lib = metaxploit.load(params[0])
print (params[0] + " " + lib.version)
