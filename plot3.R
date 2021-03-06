library(lubridate)
library(dplyr)

#download the data
link <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(link,temp)

#read the data
data <- read.table( unz(filename="household_power_consumption.txt",temp) , sep = ";", stringsAsFactors = F)

df <- data
#renaming the dataframe column name
names(df) <- c("date", "time", "global.active.power", "global.reactive.power", "voltage",
               "global.intensity", "sub.metering.1", "sub.metering.2", "sub.metering.3")

#Reformat date
df <- df %>% mutate(datetime = paste(date, time))
df <- df %>% mutate(date2 = dmy(date))

#Subset the 2 date in february 2007
df <- filter(df, date2 %in% ymd(c("2007-02-01", "2007-02-02")))

#convert variables to numeric
df <- df %>% mutate(global.active.power = as.numeric(global.active.power), global.reactive.power = as.numeric(global.reactive.power), 
                    voltage = as.numeric(voltage), sub.metering.1 = as.numeric(sub.metering.1), 
                    sub.metering.2 = as.numeric(sub.metering.2), sub.metering.3 = as.numeric(sub.metering.3))

#convert time variable to POSIXct
df[, "datetime2"] <- as.POSIXct(strptime(df[,"datetime"], format="%d/%m/%Y %H:%M:%S"))


#Plot3
png(filename = "plot3.png", width=480, height=480)
with(df, plot(x = datetime2, y = sub.metering.1, type = "n", xlab = " ",ylab = "Energy sub metering"))
with(df, lines(x = datetime2, y = sub.metering.1))
with(df, lines(x = datetime2, y = sub.metering.2, col = "red"))
with(df, lines(x = datetime2, y = sub.metering.3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()
