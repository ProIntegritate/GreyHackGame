date = current_date
time = date.split("-")[1]
time = trim(time)
date = date.split("-")[0]
date = trim(date)
units = date.split("/")
date = units[2] + "/" + units[1] + "/" + units[0]
print (date + " " + time)
