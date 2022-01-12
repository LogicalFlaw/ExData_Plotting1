### read all data from the file on power consumption
powerDataset<-read.table("household_power_consumption.txt",header=TRUE,sep=";")
### convert the date column to the date format; drop all columns except date, time, global active power
powerDataset$Date<-as.Date(powerDataset$Date,"%d/%m/%Y")
powerDataset<-powerDataset[,1:3]
### select the data for 01/02/2007 and 02/02/2007 into a separate object
twodaysDataset<-subset(powerDataset,(Date==as.Date("01/02/2007","%d/%m/%Y")|Date==as.Date("02/02/2007","%d/%m/%Y")))
### delete the powerDataset from memory
rm(powerDataset)
### Create a column with date and time and add it to the dataset
DateTime<-as.POSIXct(paste(twodaysDataset$Date,twodaysDataset$Time),format="%Y-%m-%d %H:%M:%S")
twodaysDataset$DateAndTime<-DateTime
### Open png device and create the plot; close the device
png("plot2.png",width = 480,height = 480)
with (twodaysDataset, plot(DateAndTime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=""))
dev.off()
