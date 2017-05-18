
##import data

# File URL to download
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Local data file for zip
zipdatafile<-"./graphics.zip"

# Directory
dirFile<-"./"

# Download the dataset(.zip) which does not exist
if(file.exists(zipdatafile)==FALSE){ 
  +   download.file(url, destfile=zipdatafile)}

# Unzip data file
if(file.exists(dirFile)==FALSE){
  +   unzip(zipdatafile) }

#read file with separator ";" and header is true
info<-read.delim("./household_power_consumption.txt", header=TRUE, sep=";",na.strings="?")

info2<-info
#check file

head(info)
head(info2)


#filter correct time 2007-02-01 and 2007-02-02
#Convert the Date and Time variables to Date/Time classes in R using the strptime()  and as.Date() functions.
#Note that in this dataset missing values are coded as ?.

subset<-info2[info2$Date=='1/2/2007'|info2$Date=='2/2/2007',]
library(lubridate)
subset$datetime<-dmy(subset$Date)+hms(subset$Time)
head(subset)
tail(subset)

#plotting 4 voltage
png(filename="plot4.png",width=480,height=480,units="px")
#open print device with for graphs
par(mfrow=c(2,2))
#graph1
plot(subset$datetime,subset$Global_active_power,type="l",xlab="",ylab="Global active power (kilowats)")
#graph2
plot(subset$datetime,subset$Voltage, type="l", xlab="daytime", ylab="Voltage")
#graph3
lgnd<-c("sub_metering_1","sub_metering_2", "sub_metering_3")
coln<-c("red","blue","black")
plot (subset$datetime,subset$Sub_metering_1,type="l",col=coln[1],xlab="",
      ylab="Energy sub metering")
lines(subset$datetime,subset$Sub_metering_2,type="l",col=coln[2])
lines(subset$datetime,subset$Sub_metering_3,type="l",col=coln[3])
legend("topright", legend=lgnd, col=coln, lty="solid")
#graph4
plot(subset$datetime,subset$Global_active_power,type="l",xlab="day time")
dev.off()