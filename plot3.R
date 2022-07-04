# load libraries

library(data.table); library(tidyverse)

# read data, subset for February 1 and 2, 2007

plot3_data <- fread("household_power_consumption.txt") %>% 
  subset(Date == "1/2/2007" | Date == "2/2/2007")

plot3_data$Sub_metering_1 <- sapply(plot3_data$Sub_metering_1, as.numeric)
plot3_data$Sub_metering_2 <- sapply(plot3_data$Sub_metering_2, as.numeric)
plot3_data$Sub_metering_3 <- sapply(plot3_data$Sub_metering_3, as.numeric)

# create line graph for each sub-metering measure

plot.new()

with(plot3_data, plot(Sub_metering_1, col = "black", type = "l", xlab = "", xaxt = "n", 
                      ylab = "Energy sub metering"))
with(plot3_data, lines(Sub_metering_2, col = "red", type = "l"))
with(plot3_data, lines(Sub_metering_3, col = "blue", type = "l"))

axis(1, at = c(1, nrow(plot3_data) * 0.5, nrow(plot3_data)), labels = c("Thu", "Fri", "Sat"))

# add legend

legend("topright", legend = c("Sub-metering 1", "Sub-metering 2", "Sub-metering 3"),
       lty = c(1, 1, 1), col = c("black", "red", "blue"))

# print to PNG

dev.print(device = png, file = "plot3.png", width = 480, height = 480)