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

## Convert Energy Sub Metering to numeric
sub_dat$Sub_metering_1 <- as.character(sub_dat$Sub_metering_1)
sub_dat$Sub_metering_1 <- as.numeric(sub_dat$Sub_metering_1)
sub_dat$Sub_metering_2 <- as.character(sub_dat$Sub_metering_2)
sub_dat$Sub_metering_2 <- as.numeric(sub_dat$Sub_metering_2)
sub_dat$Sub_metering_3 <- as.character(sub_dat$Sub_metering_3)
sub_dat$Sub_metering_3 <- as.numeric(sub_dat$Sub_metering_3)

## Plot 2
png(filename = "plot3.png", width = 480, height = 480)
plot(sub_dat$datetime, sub_dat$Sub_metering_1, 
     type = "n", 
     xlab = "", 
     ylab = "Energy sub metering")
lines(sub_dat$datetime, sub_dat$Sub_metering_1, col = "black")
lines(sub_dat$datetime, sub_dat$Sub_metering_2, col = "red")
lines(sub_dat$datetime, sub_dat$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1))
dev.off()
