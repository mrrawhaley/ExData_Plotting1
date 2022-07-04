# load libraries

 library(data.table); library(tidyverse)

# read data, subset for February 1 and 2, 2007

plot1_data <- fread("household_power_consumption.txt") %>% 
  subset(Date == "1/2/2007" | Date == "2/2/2007")

# create histogram with red bars

with(plot1_data, hist(as.numeric(Global_active_power), col = "red", 
                      main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
                      ylab = "Frequency"))

# print to PNG

dev.print(device = png, file = "plot1.png", width = 480, height = 480)