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
power2 <- filter(power,Date == "1/2/2007" | Date == "2/2/2007")
power2$date_time = mdy_hms(paste(power2$Date, power2$Time))
power2$Global_active_power <- as.numeric(power2$Global_active_power)
power2$Global_reactive_power <- as.numeric(power2$Global_reactive_power)
power2$Voltage <- as.numeric(power2$Voltage)
power2$Global_intensity <- as.numeric(power2$Global_intensity)
power2$Sub_metering_1 <- as.numeric(power2$Sub_metering_1)
power2$Sub_metering_2 <- as.numeric(power2$Sub_metering_2)
power2$Sub_metering_3 <- as.numeric(power2$Sub_metering_3)
hist(power2$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.copy(png, file = "plot1.png")
dev.off()
