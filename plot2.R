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
png(filename="plot2.png", width=480, height=480)

##Produce required plot as shown in assingment instructions
plot(hpcData$DateTime, hpcData$GlobalActivePower, ylab="Global Active Power (kilowatts)",
     xlab="", type="l")

dev.off()
