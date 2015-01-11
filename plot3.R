
## Reading the data
data_full <- read.csv("data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subsetting the relevant days
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

## Converting dates to the right format
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot 3

png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(7, 6, 5, 4))

with(data, {
        plot(Sub_metering_1~Datetime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", lty = c(1, 1), lwd = c(1, 1, 1), 
       col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()