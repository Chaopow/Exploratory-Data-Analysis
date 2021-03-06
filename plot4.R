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

## Convert Energy Sub Metering to numeric
sub_dat$Sub_metering_1 <- as.character(sub_dat$Sub_metering_1)
sub_dat$Sub_metering_1 <- as.numeric(sub_dat$Sub_metering_1)
sub_dat$Sub_metering_2 <- as.character(sub_dat$Sub_metering_2)
sub_dat$Sub_metering_2 <- as.numeric(sub_dat$Sub_metering_2)
sub_dat$Sub_metering_3 <- as.character(sub_dat$Sub_metering_3)
sub_dat$Sub_metering_3 <- as.numeric(sub_dat$Sub_metering_3)

## Convert Voltage to numeric
sub_dat$Voltage <- as.character(sub_dat$Voltage)
sub_dat$Voltage <- as.numeric(sub_dat$Voltage)

## Convert global reactive power to numeric
sub_dat$Global_reactive_power <- as.character(sub_dat$Global_reactive_power)
sub_dat$Global_reactive_power <- as.numeric(sub_dat$Global_reactive_power)

## Plot
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

## Top Left Panel
plot(trial_sub$datetime,trial_sub$Global_active_power,type="l", 
     xlab = "", 
     ylab = "Global Active Power (Kilowatts)")

## Top Right Panel
plot(trial_sub$datetime, trial_sub$Voltage, type = "l", 
     xlab = "datetime", 
     ylab = "Voltage")

## Bottom Left Panel
plot(sub_dat$datetime, sub_dat$Sub_metering_1, 
     type = "n", 
     xlab = "", 
     ylab = "Energy sub metering")
lines(sub_dat$datetime, sub_dat$Sub_metering_1, col = "black")
lines(sub_dat$datetime, sub_dat$Sub_metering_2, col = "red")
lines(sub_dat$datetime, sub_dat$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1),
       bty = "n")

## Bottom Right Panel
plot(trial_sub$datetime, trial_sub$Global_reactive_power, type = "l", 
     xlab = "datetime", 
     ylab = "Global_reactive_power")
dev.off()
