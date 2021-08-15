#Download the data

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./Dataset.zip",method="curl")
unzip(zipfile="./Dataset.zip",exdir=".")

df<-read.table("household_power_consumption.txt", sep=";", header=T, na.strings="?")

#Clean and subset the data
df$DateTime<-paste(df$Date, df$Time)
df$DateTime<-strptime(df$DateTime, format="%d/%m/%Y %H:%M:%S")

df$Date<-as.Date(df$Date, format="%d/%m/%y")

df$Date <- as.character(df$Date)
subdata <-df[which(df$Date %in% c("1/2/2007", "2/2/2007")),]

#Construct the plot n.1

hist(subdata$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
