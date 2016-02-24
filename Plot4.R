# Load Libraries

library(timeSeries)
library(timeDate)
library(lubridate)
library(dplyr)
library(DBI)
library(lazyeval)
# Load the base data
fileURL <- # Confidential file location
power <- read.csv(fileURL,header=TRUE,sep=";",stringsAsFactors=FALSE)
power <- data.frame(power)
# Subset the data frame to include only 2/1/07 and 2/2/07
power2 <- filter(power,Date == "1/2/2007" | Date == "2/2/2007")
# Create a new date-time field for charting
power2$date_time = dmy_hms(paste(power2$Date, power2$Time),locale="English")
# Convert fields to be plotted into numeric fields
power2$Global_active_power <- as.numeric(power2$Global_active_power)
power2$Global_reactive_power <- as.numeric(power2$Global_reactive_power)
power2$Voltage <- as.numeric(power2$Voltage)
power2$Global_intensity <- as.numeric(power2$Global_intensity)
power2$Sub_metering_1 <- as.numeric(power2$Sub_metering_1)
power2$Sub_metering_2 <- as.numeric(power2$Sub_metering_2)
power2$Sub_metering_3 <- as.numeric(power2$Sub_metering_3)
# Properly format the datae field
power2$Date <- dmy(power2$Date, locale = "English")
# Set up a 2 x 2 charting frame
par(mfrow = c(2,2), mar= c(4,4,2,1), oma = c(0, 0, 2,0))
# Add charts
with(power2, {
  plot(date_time,Global_active_power,lwd=2,type="n",xlab="", ylab="Global Active Power (kilowatts)")
  lines(date_time,Global_active_power,lwd=1)
  plot(date_time,Voltage,type="n",xlab="datetime",ylab="Voltage",col="black")
  lines(date_time,Voltage,lwd=1)
  plot(date_time,power2$Sub_metering_1,lwd=2,type="n", xlab="",ylab="Energy sub metering")
  lines(date_time,Sub_metering_1,lwd=1, col="black")
  lines(date_time,Sub_metering_2,lwd=1, col="red")
  lines(date_time,Sub_metering_3,lwd=1, col="blue")
  legend("topright",lty=c(1,1,1),col=c("black","red","blue"),cex=.5,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(date_time,Global_reactive_power,type="n",xlab="datetime",col="black")
  lines(date_time,Global_reactive_power,lwd=1)
  })

dev.copy(png, file = "Plot4.png")
dev.off()