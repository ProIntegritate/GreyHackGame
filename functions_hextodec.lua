// Hex to dec and reverse. Written by Ichinin
// hextodec takes 1 byte (2 characters) as inparameter, i.e. hextodec("ff")
// dectohex takes 1 byte (0-255) as inparameter, i.e. dectohex(255)

hextodec = function (hex)

	highchar = slice(hex, 0,1)
	lowchar = slice(hex, 1,2)

	hexstring = "0123456789abcdef"

	a = (hexstring.indexOf(highchar) * 16)
	a = a + (hexstring.indexOf(lowchar))
	return a

end function

dectohex = function(intval)

	hexstring = "0123456789abcdef"
	lowbyte = intval % 16
	highbyte = intval - lowbyte
	highbyte = highbyte / 16

	sresult = slice(hexstring, highbyte, highbyte + 1)
	sresult = sresult + slice(hexstring, lowbyte, lowbyte + 1)

	return sresult

end function

// test code
print (hextodec("ff"))
print (dectohex(255))
