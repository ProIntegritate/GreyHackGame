// ver.src, Get version of file. Enter full path to lib file
// Written in 2022, Ichinin

print ("Usage: ver <!!FULL!! path to /lib/file.so>")

metaxploit = include_lib("/lib/metaxploit.so")
if not metaxploit then
    metaxploit = include_lib(current_path + "/metaxploit.so")
end if

lib = metaxploit.load(params[0])
print (params[0] + " " + lib.version)
