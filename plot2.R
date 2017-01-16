##using the dates to determine the exact rows to be read into the data frame
date1 = strptime("16/12/2006;17:24:00",format = "%d/%m/%Y;%H:%M:%S")
date2=strptime("01/02/2007;00:00:00",format = "%d/%m/%Y;%H:%M:%S")
date3=strptime("02/02/2007;23:59:00",format = "%d/%m/%Y;%H:%M:%S")

##number of rows to skip is the difference in dates 1 and 2 +1 
##(due to the header row)
skip_rows_count = difftime(date2,date1,units = "mins")+1
##number of rows to be read is the difference in dates 2 and 3 in minutes +1 
##(as the row with date3 has to be included)
nrows_count = difftime(date3,date2,units = "mins")+1

##the data file is in a folder parallel to ExData_Plotting1 so that the large file
##doesn't go into github
power_consumption = read.table("../household_power_consumption.txt",header=FALSE,
                    sep = ";",skip = skip_rows_count,nrows = nrows_count,
                    stringsAsFactors = FALSE)

##header is read separately and added to the data frame
power_consumption_header=read.table("../household_power_consumption.txt",nrows = 1,
                         sep = ";",header = FALSE,stringsAsFactors = FALSE)
colnames(power_consumption)=unlist(power_consumption_header)

##plot 2 is a line chart of the data set with Global Active Power col on y axis
## and Date+Time on x axis 
with(power_consumption,plot(strptime(paste(Date,Time),format = "%d/%m/%Y %H:%M:%S"),
                            Global_active_power, type = "line", 
                            ylab = "Global Active Power (kilowatts)", xlab = ""))

dev.copy(png, file = "plot2.png")

dev.off()
