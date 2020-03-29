temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
data <- read.csv2(unz(temp, "household_power_consumption.txt"), dec=".", na.strings="?")
unlink(temp)
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %X")
data <- data[,c(ncol(data), 3:(ncol(data)-1))]
data <- data[!is.na(data$DateTime) & data$DateTime >= as.POSIXct("2007-02-01") & data$DateTime < as.POSIXct("2007-02-03"), ]

png("plot3.png")
with(data, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(data, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(data, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"),lty=1)
dev.off() 
 
