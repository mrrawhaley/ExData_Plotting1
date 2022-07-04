# load libraries"

library(data.table); library(tidyverse); library(lubridate)

# read data, subset for February 1 and 2, 2007

plot2_data <- fread("household_power_consumption.txt") %>% 
  subset(Date == "1/2/2007" | Date == "2/2/2007")
plot2_data$Date <- dmy(plot2_data$Date)

# create line graph with days as x-axis tick marks

with(plot2_data, plot(as.numeric(Global_active_power), type = "l", 
                      ylab = "Global Active Power (kilowatts)", xlab = "", 
                      xaxt = "n"))
axis(1, at = c(1, nrow(plot2_data) * 0.5, nrow(plot2_data)), labels = c("Thu", "Fri", "Sat"))

# print to PNG

dev.print(device = png, file = "plot2.png", width = 480, height = 480)