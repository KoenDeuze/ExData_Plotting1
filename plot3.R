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

# subset the dataset
energy_feb_2007 <- subset(energy_data, format.Date(NewDate, "%d") %in% c("01","02")  & format.Date(NewDate, "%m")=="02" & format.Date(NewDate, "%Y")=="2007")

# create the chart
png("plot3.png", width = 480, height = 480, type = "quartz")
plot(energy_feb_2007$DateTime,energy_feb_2007$numMeter_1, type="n",xlab="", ylab = "Energy sub metering")
lines(energy_feb_2007$DateTime,energy_feb_2007$numMeter_1, col="black")
lines(energy_feb_2007$DateTime,energy_feb_2007$numMeter_2, col="red")
lines(energy_feb_2007$DateTime,energy_feb_2007$numMeter_3, col="blue")
legend("topright",lty=1 ,col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()