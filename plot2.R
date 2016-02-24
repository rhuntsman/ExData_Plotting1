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
# subset the data to include only Feb 1 and Feb 2 2007
power2 <- filter(power,Date == "1/2/2007" | Date == "2/2/2007")
# Create a new date_time field that has the proper format for the charts
power2$date_time = dmy_hms(paste(power2$Date, power2$Time),locale="English")
# Format all variables as numeric or date, where appropriate
power2$Global_active_power <- as.numeric(power2$Global_active_power)
power2$Global_reactive_power <- as.numeric(power2$Global_reactive_power)
power2$Voltage <- as.numeric(power2$Voltage)
power2$Global_intensity <- as.numeric(power2$Global_intensity)
power2$Sub_metering_1 <- as.numeric(power2$Sub_metering_1)
power2$Sub_metering_2 <- as.numeric(power2$Sub_metering_2)
power2$Sub_metering_3 <- as.numeric(power2$Sub_metering_3)
power2$Date <- dmy(power2$Date, locale = "English")
plot(power2$date_time,power2$Global_active_power,lwd=2,type="n",xlab="", ylab="Global Active Power (kilowatts)")
lines(power2$date_time,power2$Global_active_power,lwd=1)
dev.copy(png,file = "plot2.png")
dev.off()