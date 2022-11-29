// Version scanner, scans a subnet for vulnerable hosts given a version string, supports any service.

if params.len == 0 or params[0] == "-h" or params[0] == "--help" then exit("<b>Usage: "+program_path.split("/")[-1]+" [net, i.e. 1.1.1.] [port, i.e. 22] [version, i.e. 1.0.2]</b>")

// Imports Metaxploit
metaxploit = include_lib("/lib/metaxploit.so")
if not metaxploit then
    metaxploit = include_lib(current_path + "/metaxploit.so")
end if
if not metaxploit then exit("metaxploit.so not found")

// get params
host = params[0]
port = params[1].to_int
ver = params[2]

meta = include_lib("/lib/metaxploit.so")

icounter = 0
results = ""
iwrapper = 0

while icounter <= 255

	rhost = host + icounter
	print ("Connecting to " + rhost + "...")
	net = meta.net_use(rhost, port)
	if not net then
	else
		lib = net.dump_lib
		if lib.version.indexOf(ver) >= 0 then
			print("<color=#00ff00>" + lib.lib_name + ", " + lib.version + "</color>")
			results = results + rhost + ", "
			iwrapper = iwrapper + 1
			if iwrapper == 6 then 
				iwrapper = 0
				results = results + "\n"
			end if
		end if
	end if

	icounter = icounter + 1

	

end while

print("")
results = "Found " + lib.lib_name + " version " + lib.version + " on the following hosts:" + "\n" + results 
print (results)
