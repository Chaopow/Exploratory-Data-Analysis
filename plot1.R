## Unzip file & read file
unzip("exdata_data_household_power_consumption.zip")
data <- read.delim("household_power_consumption.txt", header = TRUE, sep = ";")

## Convert Date and Time to Date class and time class
library(lubridate)
data$Date <- dmy(data$Date)
data$Time <- as.character(data$Time)
data$Time <- format(strptime(data$Time, format = "%H:%M:%S"), format = "%H:%M:%S")

## Subset data to between 2007-02-01 and 2007-02-02
sub_dat <- subset(data, Date == c("2007-02-01", "2007-02-02"))

## Convert Global Active Power to numeric
sub_dat$Global_active_power <- as.character(sub_dat$Global_active_power)
sub_dat$Global_active_power <- as.numeric(sub_dat$Global_active_power)

## Plot 1
png(filename = "plot1.png", width = 480, height = 480)
with(sub_dat, hist(Global_active_power, main = "Global Active Power",
                   col = "red", 
                   xlab = "Global Active Power (Kilowatts)"))
dev.off()
