library(lubridate)

data1 <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
        data1$Date <- dmy(data1$Date)
        rdate <- dmy(c("01/02/2007","02/02/2007"))
        
data2 <- data1[data1$Date %in% rdate,]
        data2$Global_active_power <- as.numeric(as.character(data2$Global_active_power))

png(file="plot1.png",width=480,height=480)
        hist(data2$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()