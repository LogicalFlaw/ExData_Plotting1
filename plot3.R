### read all data from the file on power consumption
powerDataset<-read.table("household_power_consumption.txt",header=TRUE,sep=";")
### convert the date column to the date format; drop all columns except date, time, submetering 1,2,3
powerDataset$Date<-as.Date(powerDataset$Date,"%d/%m/%Y")
powerDataset<-powerDataset[,c("Date","Time","Sub_metering_1","Sub_metering_2","Sub_metering_3")]
### select the data for 01/02/2007 and 02/02/2007 into a separate object
twodaysDataset<-subset(powerDataset,(Date==as.Date("01/02/2007","%d/%m/%Y")|Date==as.Date("02/02/2007","%d/%m/%Y")))
### delete the powerDataset from memory
rm(powerDataset)
### Create a column with date and time and add it to the dataset
DateTime<-as.POSIXct(paste(twodaysDataset$Date,twodaysDataset$Time),format="%Y-%m-%d %H:%M:%S")
twodaysDataset$DateAndTime<-DateTime
### Open png device and create the plot; close the device
png("plot3.png",width = 480,height = 480)
with (twodaysDataset, plot(DateAndTime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=""))
lines(twodaysDataset$DateAndTime,twodaysDataset$Sub_metering_2,col="red")
lines(twodaysDataset$DateAndTime,twodaysDataset$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lwd=1)
dev.off()
