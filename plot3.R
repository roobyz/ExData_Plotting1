###############################################################
# Plotting Assignment 1 for Exploratory Data Analysis
###############################################################

###############################################################
# Get File
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
myFile = "./household_power_consumption.zip"
download.file(fileUrl, destfile = myFile, method = "curl")

###############################################################
# Read the records for the two specified dates.
library(data.table)
lines <- readLines(unz(  "household_power_consumption.zip"
                       , "household_power_consumption.txt"))
good <- grep("^[12]/2/2007",lines)
data <- read.table(text=lines[good]
                   , header=F
                   , sep=";"
                   , na.strings=c("?","NA"))
colnames(data) <- strsplit(lines[1], ";")[[1]]  # assign the column names
# add datetime column
data$DateTime <- strptime(paste(as.Date(data$Date, format="%d/%m/%Y")
                                , data$Time, sep=" ")
                          ,format="%Y-%m-%d %H:%M:%S")

###############################################################
# Plot 3
png(filename = "plot3.png", width = 480, height = 480, bg = "transparent")
plot(data$DateTime, data$Sub_metering_1
     ,xlab = ""
     ,ylab = "Energe sub metering"
     ,type = "l"
     #,col  = "red"
)
lines(data$DateTime, data$Sub_metering_2
     ,xlab = ""
     ,ylab = "Global Active Power (kilowatts)"
     ,type = "l"
     ,col  = "red"
)
lines(data$DateTime, data$Sub_metering_3
     ,xlab = ""
     ,ylab = "Global Active Power (kilowatts)"
     ,type = "l"
     ,col  = "blue"
)
legend("topright"
       , lty = "solid"
       #, pch = c(NA, NA, 8)
       , col = c("black", "red", "blue")
       , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
