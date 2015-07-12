## --------------------------
## Code for read the source
## --------------------------
filename <- "data/household_power_consumption.txt"
data <- read.table(filename,
                   header = TRUE,
                   sep = ";",
                   colClasses = c("character", "character", rep("numeric",7)),
                   na = "?")
dim(data) # 2075259 obs. of 9 variables
attach(data)
## We only need data of 2 days.
subSet <- Date == "1/2/2007" | Date == "2/2/2007"
newData <- data[subSet, ]
attach(newData)
x <- paste(Date, Time)
newData$DateTime <- strptime(x, "%d/%m/%Y %H:%M:%S")
rownames(newData) <- 1:nrow(newData)
dim(newData) # 2880 obs. of 10 variables
attach(newData)

## --------------------------
## Lines of code for create the image
## --------------------------
png(filename = "plot4.png", 
    width = 480, 
    height = 480,
    units = "px", 
    bg = "transparent")
par(mfrow = c(2, 2))
## Image locate Top-left
plot(DateTime, 
     Global_active_power, 
     type = "l",
     xlab = "", 
     ylab = "Global Active Power")
## Image locate Top-right
plot(DateTime, 
     Voltage,
     type = "l",
     xlab = "datetime", 
     ylab = "Voltage")
## Image locate Bottom-left
plot(DateTime, 
     Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "", 
     ylab = "Energy sub metering")
lines(DateTime, 
      Sub_metering_2, 
      col = "red")
lines(DateTime, 
      Sub_metering_3, 
      col = "blue")
# Remove the border of legend here.
legend("topright", 
       bty = "n",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
## Image locate Bottom-right
plot(DateTime, 
     Global_reactive_power, 
     type = "l",
     col = "black",
     xlab = "datetime", ylab = colnames(newData)[4])
dev.off()