##Read data from file but only rows with date between 2007-02-01 and 2007-02-02
##Sets appropriate column classes and column names
##Script assumes "household_power_consumption.txt" is in the same working directory
hpcData <- read.table(file="household_power_consumption.txt", header = TRUE, sep = ";",
                      na.strings = "?", comment.char = "", nrows=2880, skip=66636,
                      colClasses = c("character", "character", "numeric", "numeric", "numeric",
                                     "numeric", "numeric", "numeric", "numeric"),
                      col.names = c("Date", "DateTime", "GlobalActivePower", "GlobalReactivePower",
                                    "Voltage", "GlobalIntensiy", "SubMetering1", "SubMetering2",
                                    "SubMetering3"), stringsAsFactors = FALSE)

##Convert Date and Time columns into one DateTime column and remove extra Date column
hpcData$DateTime <- as.POSIXct(paste(hpcData$Date, hpcData$DateTime), format="%d/%m/%Y %H:%M:%S", tz="")
hpcData$Date <- NULL

##Save plot to PNG file
png(filename="plot4.png", width=480, height=480)

par(mfcol=c(2,2))
##Produce required plot as shown in assingment instructions

plot(hpcData$DateTime, hpcData$GlobalActivePower, ylab="Global Active Power (kilowatts)",
     type="l", xlab="")


plot(hpcData$DateTime, hpcData$SubMetering1, ylab="Energy sub metering",
     xlab="", type="l")
lines(hpcData$DateTime, hpcData$SubMetering2, col="red")
lines(hpcData$DateTime, hpcData$SubMetering3, col="blue")
legend("topright", legend=c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"),
       col=c("black", "red", "blue"), lty=1, lwd=2)

plot(hpcData$DateTime, hpcData$Voltage, ylab="Voltage", xlab="Date Time", type="l")

plot(hpcData$DateTime, hpcData$GlobalReactivePower, ylab="Global Reactive Power",
     xlab="Date Time", type="l")

dev.off()
