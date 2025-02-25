if params.len != 2 then
	print ("<b>Usage: wificrack [Signal Strength Start, i.e. 100] [Signal Strength Stop, i.e. 10]</b>")
	exit ("Written by Ichinin.")
end if

iStart = params[0].to_int
iStop = params[1].to_int

fileread = function (filename)

	file = get_shell.host_computer.File(filename)
	result = ""
	if file then result = file.get_content
	return result
	
end function

filewrite = function (filefullpath, content)

	filename = filefullpath.split("/")[-1]
	filepath = filefullpath.replace(filename,"")

	h = get_shell.host_computer
	h.touch(filepath,filename)

	foo = get_shell.host_computer.File(filepath + filename)
	foo.set_content(content)

end function

sFilename = current_path + "/wifi_cracked.txt"
sresult = ""
sresult = fileread(sFilename)

clear_screen
crypto = include_lib("/lib/crypto.so")
networks = get_shell.host_computer.wifi_networks("wlan0")

airmonResult = crypto.airmon("start", "wlan0")
if typeof(airmonResult) == "number" then 
	print("<color=#ffcc00>Successfully set WiFi for <b>wlan0</b> to <b>Monitor Mode</b></color>")
end if
wait(2)

icount = 0
iprevious = sresult.split(char(10))
if iprevious.len > 0 then icount = iprevious.len - 1

for cpwr in range(iStart,iStop)
	for index in networks
		clear_screen
		print ("<color=#7f7fff>Processing " + networks.len + " networks, strongest to weakest signal.</color>\n")
		print ("<color=#ffff7f>Selected Signal strenght range: " + iStart + "% -> " + iStop + "%</color>")
		print ("<color=#7fff7f>Current results: (" + icount + "/" + networks.len + ")</color>\n" + sresult)
		parsed = index.split(" ")
		bssid = parsed[0]
		pwr = parsed[1][:-1].to_int
		essid = parsed[2]
		potentialAcks = floor(275000 / pwr)  // Less insane runtine on this one.
		if pwr == cpwr then
			if sresult.indexOf(bssid) >= 0 then
			else
				print ("<color=#7fff7f>Processing network: " + index + "</color>\n")
				print ("<color=#cccc00>Your already cracked WiFi credentials are saved (as wifi_cracked.txt), so you can cancel this program at any time. Any already existing file will be continued from.</color>\n")
				print ("<color=#ff7fff>Potential ACK's (search space): " + potentialAcks + "</color>")
				crypto.aireplay(bssid, essid, potentialAcks )	// -> file.pcap
				wifiPassword = crypto.aircrack(current_path + "/file.cap")
				print("<color=#00ff7f>Wifi password for " + essid + " is " + wifiPassword + "</color>")	
				sresult = sresult + bssid + "," + pwr + "%," +  essid + "," + wifiPassword + char(10)
				icount = icount + 1
			end if			
		end if
		filewrite(sFilename,sresult)
	end for
end for

clear_screen
print("Final results:\n" + sresult)
filewrite(sFilename,sresult)
print("Wrote results to: " + sFilename)
