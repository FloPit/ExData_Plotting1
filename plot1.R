#load data from website

zipfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

temp <- tempfile()
download.file(zipfile,temp)
#interpret "?" as NA when reading the data
data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE, na.strings=c("?"), stringsAsFactors=FALSE)
unlink(temp)


#subset: use data only from dates "2007-02-01" and "2007-02-02"
mydata <- subset(data, Date=="1/2/2007" | Date=="2/2/2007")



#make the plot: 
#set output device to "png" file,
#make histogram of global active power, set hist-parameters for layout
#close device
png(filename="plot1.png" ,width = 480, height = 480)
hist(mydata$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()
