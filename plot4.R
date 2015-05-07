#load data from website

zipfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

temp <- tempfile()
download.file(zipfile,temp)
#interpret "?" as NA when reading the data
data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE, na.strings=c("?"), stringsAsFactors=FALSE)
unlink(temp)


#subset: use data only from dates "2007-02-01" and "2007-02-02"
mydata <- subset(data, Date=="1/2/2007" | Date=="2/2/2007")

#Convert Date and Time Columns to Timestamps, add Timestamp Column to data frame
x <- paste(mydata$Date, mydata$Time)
TimeStamp <- strptime(x, "%d/%m/%Y %H:%M:%S")
mydata  <- cbind(mydata, TimeStamp)


#make the plot 4: give plots to the right "datetime" as xlab
#set output device to "png" file, make four subplots
png(filename="plot4.png" ,width = 480, height = 480)
par(mfrow= c(2,2))

#xlab="Please note: Do=Thursday, Fr=Friday, Sa=Saturday"

#subplot 4.1: global active power
plot(x=mydata$TimeStamp, y=mydata$Global_active_power, type="l", ylab="Global Active Power", xlab="")

#subplot 4.2: Voltage
plot(x=mydata$TimeStamp, y=mydata$Voltage, type="l", ylab="Voltage", xlab="datetime")

#subplot 4.3: Energy sub metering, bty="n" removes box
plot(x=mydata$TimeStamp, y=mydata$Sub_metering_1, type="n", main="", xlab="", ylab="Energy sub metering")
points(x=mydata$TimeStamp, y=mydata$Sub_metering_1, type="l", col="black")
points(x=mydata$TimeStamp, y=mydata$Sub_metering_2, type="l", col="red")
points(x=mydata$TimeStamp, y=mydata$Sub_metering_3, type="l", col="blue")
legend("topright", bty="n", lty=1, col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#subplot 4.4: Global reactive power
plot(x=mydata$TimeStamp, y=mydata$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

#close device
dev.off()
