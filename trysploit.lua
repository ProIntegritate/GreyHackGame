// Trysploit: Test an exploit directly to see what it does
// Usage: trysploit <full path to lib file> <offset> <function name>

if params.len == 0 or params[0] == "-h" or params[0] == "--help" then exit("<b>Usage: "+program_path.split("/")[-1]+" [libfile.so] [0xoffset] [functionname]</b>")

metaxploit = include_lib("/lib/metaxploit.so")
if not metaxploit then
    metaxploit = include_lib(current_path + "/metaxploit.so")
end if
if not metaxploit then exit("Error: Can't find metaxploit library in the /lib path or the current folder")
metaLib = metaxploit.load(params[0])
if not metaLib then exit("Can't find " + params[0])
result = metaLib.overflow(params[1], params[2])
print("Resulting Handle: " + typeof(result) + " (=object being exploited)")
