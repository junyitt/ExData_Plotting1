library(lubridate)

data1 <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
        data1$Date <- dmy(data1$Date)
        rdate <- dmy(c("01/02/2007","02/02/2007"))
        data2 <- data1[data1$Date %in% rdate,]
                data2$Global_active_power[data2$Global_active_power == "?"] <- NA
                data2$Global_active_power <- as.numeric(as.character(data2$Global_active_power))

d <- data2[, c("Time","Date","Global_active_power")]
d$fday <- as.POSIXct(paste(d$Date, d$Time), format="%F %H:%M:%S")

png(file="plot2.png",width=480,height=480)
        plot(y = d$Global_active_power, x= d$fday, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()