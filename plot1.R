
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


#plotting 1 histogram
png(filename='plot1.png',width=480,height=480,units='px') 
# plot data 
hist(subset$Global_active_power,xlab="Global_active_power (kilowats)",col="red", main="Global Active Power")
# Turn off device 
dev.off() 

