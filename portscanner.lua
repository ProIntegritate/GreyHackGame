// Portscanner, quite basic, Written just for fun.
// syntax: scan <ip> <start port> <end port>
// Written in 2022, Ichinin

metaxploit = include_lib("/lib/metaxploit.so")
if not metaxploit then
    metaxploit = include_lib(current_path + "/metaxploit.so")
end if
if not metaxploit then exit("metaxploit.so not found")

host = params[0]
iStart = params[1].to_int
iStop = params[2].to_int

iPort = iStart
sResult = ""

while iPort <= iStop

	net_session = metaxploit.net_use( host , iPort )
	if net_session then 
		sResult = sResult + host + ":" + iPort + "\n"
	end if

	if iPort % 10 == 0 then
		print(iPort)
	end if
		
	iPort = iPort + 1

end while

clear_screen
print("Port scan results:")
print(sResult)

