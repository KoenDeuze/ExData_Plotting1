# download the zipfile to a temp-file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
energy_data <- read.csv2(unz(temp,"household_power_consumption.txt"),header = TRUE, sep = ";")
unlink(temp)


# convert the factor 'date' to a field of class Date
energy_data$NewDate <- as.Date(energy_data$Date,format = "%d/%m/%Y")

# create a combined date-time variable
energy_data$DateTime <- as.POSIXct(paste(energy_data$Date, energy_data$Time), format="%d/%m/%Y %H:%M:%S") 

# convert the factor 'GLobal Active Power' to a field of class numeric
energy_data$newGAP <- as.numeric(as.character(energy_data$Global_active_power))

# convert the factors '... metering' to fields of class numeric
energy_data$numMeter_1 <- as.numeric(as.character(energy_data$Sub_metering_1))
energy_data$numMeter_2 <- as.numeric(as.character(energy_data$Sub_metering_2))
energy_data$numMeter_3 <- as.numeric(as.character(energy_data$Sub_metering_3))

# convert the voltage to numeric
energy_data$numvoltage <- as.numeric(as.character(energy_data$Voltage))

# convert global reactive power to numeric
energy_data$numGRP <- as.numeric(as.character(energy_data$Global_reactive_power))
energy_data$numGRP_2 <- as.numeric(levels(energy_data$Global_reactive_power))[energy_data$Global_reactive_power]
warnings()
str(energy_data$numGRP_2)

# subset the dataset
energy_feb_2007 <- subset(energy_data, format.Date(NewDate, "%d") %in% c("01","02")  & format.Date(NewDate, "%m")=="02" & format.Date(NewDate, "%Y")=="2007")

# create the png file
png("plot4.png", type = "quartz")
par(mfrow=c(2,2),mar=c(4,4,2,1),oma=c(0,0,2,0))

# plot graph 1
plot(energy_feb_2007$DateTime,energy_feb_2007$newGAP, type="n",xlab="", ylab = "Global Active Power", width=480, height=480)
lines(energy_feb_2007$DateTime,energy_feb_2007$newGAP)

# plot graph 2
plot(energy_feb_2007$DateTime,energy_feb_2007$numvoltage, type="n",xlab="datetime", ylab = "Voltage", width=480, height=480)
lines(energy_feb_2007$DateTime,energy_feb_2007$numvoltage)

# plot graph 3
plot(energy_feb_2007$DateTime,energy_feb_2007$numMeter_1, type="n",xlab="", ylab = "Energy sub metering")
lines(energy_feb_2007$DateTime,energy_feb_2007$numMeter_1, col="black")
lines(energy_feb_2007$DateTime,energy_feb_2007$numMeter_2, col="red")
lines(energy_feb_2007$DateTime,energy_feb_2007$numMeter_3, col="blue")
legend("topright",lty=1 ,col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# plot graph 4
plot(energy_feb_2007$DateTime,energy_feb_2007$numGRP_2, type="n",xlab="datetime", ylab = "Global Reactive Power")
lines(energy_feb_2007$DateTime,energy_feb_2007$numGRP_2)

# close the png file
dev.off()


