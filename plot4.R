#Download the data

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./Dataset.zip",method="curl")
unzip(zipfile="./Dataset.zip",exdir=".")

df<-read.table("household_power_consumption.txt", sep=";", header=T, na.strings="?")

#Clean and subset the dataylab = "Energy sub metering", xlab="",
df$DateTime<-paste(df$Date, df$Time)
df$DateTime<-strptime(df$DateTime, format="%d/%m/%Y %H:%M:%S")

df$Date<-as.Date(df$Date, format="%d/%m/%y")

df$Date <- as.character(df$Date)
subdata <-df[which(df$Date %in% c("1/2/2007", "2/2/2007")),]


#Construct the plot n.3
par(mfrow=c(2,2))

plot(type="l", x=subdata$DateTime, y=subdata$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab="")

plot(type="l", x=subdata$DateTime, y=subdata$Voltage, ylab = "Voltage", xlab="datetime")

plot(type="l", subdata$DateTime, y=subdata$Sub_metering_1, ylab = "Energy sub metering", xlab="")
lines(x=subdata$DateTime, y=subdata$Sub_metering_2,  col="red")
lines(x=subdata$DateTime, y=subdata$Sub_metering_3,  col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"), bty = "n", cex = 0.75)

plot(type="l", x=subdata$DateTime, y=subdata$Global_reactive_power, ylab = "Global_reactive_power", xlab="datetime")

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
