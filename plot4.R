# load libraries"

library(data.table); library(tidyverse); library(lubridate)

# read data, subset for February 1 and 2, 2007

plot4_data <- fread("household_power_consumption.txt") %>% 
  subset(Date == "1/2/2007" | Date == "2/2/2007")
plot4_data$Date <- dmy(plot4_data$Date)
plot4_data$Global_reactive_power <- sapply(plot4_data$Global_reactive_power, as.numeric)
plot4_data$Sub_metering_1 <- sapply(plot4_data$Sub_metering_1, as.numeric)
plot4_data$Sub_metering_2 <- sapply(plot4_data$Sub_metering_2, as.numeric)
plot4_data$Sub_metering_3 <- sapply(plot4_data$Sub_metering_3, as.numeric)

# create line graph with days as x-axis tick marks

plot.new()

par(mfrow = c(2, 2))

  # plot 1

with(plot4_data, plot(as.numeric(Global_active_power), type = "l", 
                      ylab = "Global Active Power", xlab = "", 
                      xaxt = "n"))
axis(1, at = c(1, nrow(plot4_data) * 0.5, nrow(plot4_data)), labels = c("Thu", "Fri", "Sat"))

  # plot 2

with(plot4_data, plot(as.numeric(Voltage), type = "l", 
                      ylab = "Voltage", xlab = "datetime", 
                      xaxt = "n"))
axis(1, at = c(1, nrow(plot4_data) * 0.5, nrow(plot4_data)), labels = c("Thu", "Fri", "Sat"))

  # plot 3

with(plot4_data, plot(Sub_metering_1, col = "black", type = "l", xlab = "", xaxt = "n", 
                      ylab = "Energy sub metering"))
with(plot4_data, lines(Sub_metering_2, col = "red", type = "l"))
with(plot4_data, lines(Sub_metering_3, col = "blue", type = "l"))

axis(1, at = c(1, nrow(plot4_data) * 0.5, nrow(plot4_data)), labels = c("Thu", "Fri", "Sat"))

legend("topright", legend = c("Sub-metering 1", "Sub-metering 2", "Sub-metering 3"),
       lty = c(1, 1, 1), col = c("black", "red", "blue"), bty = "n")

  # plot 4

with(plot4_data, plot(Global_reactive_power, type = "l", xlab = "datetime", 
                      xaxt = "n", yaxt = "n"))

axis(1, at = c(1, nrow(plot4_data) * 0.5, nrow(plot4_data)), labels = c("Thu", "Fri", "Sat"))
axis(2, at = seq(0.0, 0.5, by = 0.1))

# print to PNG

dev.print(device = png, file = "plot4.png", width = 480, height = 480)