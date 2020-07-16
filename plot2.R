## Unzip file & read file
unzip("exdata_data_household_power_consumption.zip")
data <- read.delim("household_power_consumption.txt", header = TRUE, sep = ";")

## Convert Date and Time to Date class 
library(lubridate)
data$Date <- dmy(data$Date)
data$Time <- as.character(data$Time)

## Subset data to between 2007-02-01 and 2007-02-02
sub_dat <- subset(data, Date == c("2007-02-01", "2007-02-02"))

## Create datetime using Date and Time
sub_dat$datetime <- strptime(paste(sub_dat$Date, sub_dat$Time), format = "%Y-%m-%d %H:%M:%S")

## Convert Global Active Power to numeric
sub_dat$Global_active_power <- as.character(sub_dat$Global_active_power)
sub_dat$Global_active_power <- as.numeric(sub_dat$Global_active_power)

## Plot 2
png(filename = "plot2.png", width = 480, height = 480)
plot(trial_sub$datetime,trial_sub$Global_active_power,type="l", 
     xlab = "", 
     ylab = "Global Active Power (Kilowatts)")
dev.off()
