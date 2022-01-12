### read all data from the file on power consumption
powerDataset<-read.table("household_power_consumption.txt",header=TRUE,sep=";")
### convert the date column to the date format; drop all columns except date, time, submetering 1,2,3
powerDataset$Date<-as.Date(powerDataset$Date,"%d/%m/%Y")
### select the data for 01/02/2007 and 02/02/2007 into a separate object
twodaysDataset<-subset(powerDataset,(Date==as.Date("01/02/2007","%d/%m/%Y")|Date==as.Date("02/02/2007","%d/%m/%Y")))
### delete the powerDataset from memory
rm(powerDataset)
### Create a column with date and time and add it to the dataset
DateTime<-as.POSIXct(paste(twodaysDataset$Date,twodaysDataset$Time),format="%Y-%m-%d %H:%M:%S")
twodaysDataset$DateAndTime<-DateTime

### Open png device and prepare the device for 4 graphs; plot the graphs; close the device
png("plot4.png",width = 480,height = 480)
par(mfrow=c(2,2))
### plot global active power
with (twodaysDataset, plot(DateAndTime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=""))

### plot voltage
with (twodaysDataset, plot(DateAndTime,Voltage,type="l",ylab="Voltage",xlab="datetime"))

### plot sub_metering
with (twodaysDataset, plot(DateAndTime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=""))
lines(twodaysDataset$DateAndTime,twodaysDataset$Sub_metering_2,col="red")
lines(twodaysDataset$DateAndTime,twodaysDataset$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lwd=1,cex=0.5)

### plot global reactive power
with (twodaysDataset, plot(DateAndTime,Global_reactive_power,type="l",xlab="datetime"))
dev.off()
