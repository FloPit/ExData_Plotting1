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


#make the plot 3: 
#set output device to "png" file,
#make plot of x=Timestamp, y=Energy sub metering, set parameters for layout
#Add description with weekdays -> engish weekdays
png(filename="plot3.png" ,width = 480, height = 480)
plot(x=mydata$TimeStamp, y=mydata$Sub_metering_1, type="n", main="Energy sub meterings by time", ylab="Energy sub metering", xlab="Please note: Do=Thursday, Fr=Friday, Sa=Saturday")
points(x=mydata$TimeStamp, y=mydata$Sub_metering_1, type="l", col="black")
points(x=mydata$TimeStamp, y=mydata$Sub_metering_2, type="l", col="red")
points(x=mydata$TimeStamp, y=mydata$Sub_metering_3, type="l", col="blue")
#add legend
legend("topright", lty=1, col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#close device
dev.off()
