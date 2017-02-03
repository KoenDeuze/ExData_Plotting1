# download the zipfile to a temp-file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
energy_data <- read.csv2(unz(temp,"household_power_consumption.txt"),header = TRUE, sep = ";")
unlink(temp)

# convert the factor 'date' to a field of class Date
energy_data$NewDate <- as.Date(energy_data$Date,format = "%d/%m/%Y")
energy_data$newGAP <- as.numeric(as.character(energy_data$Global_active_power))

energy_feb_2007 <- subset(energy_data, format.Date(NewDate, "%d") %in% c("01","02")  & format.Date(NewDate, "%m")=="02" & format.Date(NewDate, "%Y")=="2007")

hist(energy_feb_2007$newGAP, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", breaks = 25)

dev.copy(png,file="plot1.png", width=480, height=480)
dev.off()