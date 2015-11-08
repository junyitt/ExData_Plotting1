library(lubridate)

data1 <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
        data1$Date <- dmy(data1$Date)
        rdate <- dmy(c("01/02/2007","02/02/2007"))
        data2 <- data1[data1$Date %in% rdate,]
d <- data2
for(i in 3:9){
        d[,i] <- as.numeric(as.character(d[,i]))
}
d$fday <- as.POSIXct(paste(d$Date, d$Time), format="%F %H:%M:%S")

png(file="plot3.png",width=480,height=480)
        plot(y = d$Sub_metering_1, x= d$fday, type = "l", xlab = "", ylab = "Energy sub metering")
        lines(y = d$Sub_metering_2, x= d$fday, type = "l", xlab = "", ylab = "Energy sub metering", col = "Red")
        lines(y = d$Sub_metering_3, x= d$fday, type = "l", xlab = "", ylab = "Energy sub metering", col = "Blue")
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("Black", "Red","Blue"), lty = c(1,1,1), cex = 0.75)
dev.off()