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
# Plot 4
png(filename = "plot4.png", width = 480, height = 480, bg = "transparent")
par(mfcol = c(2, 2), mar = c(5, 4, 4, 2), oma = c(0, 0, 0, 0))
with(data, {
    plot(DateTime, Global_active_power
         ,xlab = ""
         ,ylab = "Global Active Power"
         ,type = "l"
         #,col  = "red"
    )
    plot(DateTime, Sub_metering_1
         ,xlab = ""
         ,ylab = "Energe sub metering"
         ,type = "l"
         #,col  = "red"
    )
        lines(DateTime, Sub_metering_2
              ,type = "l"
              ,col  = "red"
        )
        lines(DateTime, Sub_metering_3
              ,type = "l"
              ,col  = "blue"
        )
        legend("topright"
               , lty = "solid"
               , bty = "n"
               , col = c("black", "red", "blue")
               , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(DateTime, Voltage
         ,xlab = "datetime"
         ,ylab = "Voltage"
         ,type = "l"
         #,col  = "red"
    )
    plot(DateTime, Global_reactive_power
         ,xlab = "datetime"
         ,ylab = "Global_reactive_power"
         ,type = "l"
         #,col  = "red"
    )
})
dev.off()


