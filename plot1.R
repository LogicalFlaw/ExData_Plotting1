
  ### read all data from the file on power consumption
  powerDataset<-read.table("household_power_consumption.txt",header=TRUE,sep=";")
  ### convert the date column to the date format
  powerDataset$Date<-as.Date(powerDataset$Date,"%d/%m/%Y")
  ### select the data for 01/02/2007 and 02/02/2007 into a separate object
  twodaysDataset<-subset(powerDataset,(Date==as.Date("01/02/2007","%d/%m/%Y")|Date==as.Date("02/02/2007","%d/%m/%Y")))
  ### delete the powerDataset from memory
  rm(powerDataset)
  ### Transform the data in Global_active_power column to numeric
  twodaysDataset$Global_active_power<-as.numeric(twodaysDataset$Global_active_power)
  ### Open png device and create the histogram; close the device
  png("plot1.png",width=480,height = 480)
  hist(twodaysDataset$Global_active_power,xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power",col="red",breaks=12,ylim=c(0,1200))
  dev.off()
