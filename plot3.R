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
png(filename = "plot3.png", 
    width = 480, 
    height = 480,
    units = "px", 
    bg = "transparent")
plot(DateTime, Sub_metering_1, 
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
legend("topright", 
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
dev.off()