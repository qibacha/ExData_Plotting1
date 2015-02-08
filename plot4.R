#################################################################
# Read in household_power_consumption data from working directory
#################################################################
raw_data <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
                      
#################################################################
# Convert the Date field from string in dd/mm/yyyy format to date
################################################################# 
raw_data$Date <- as.Date(raw_data$Date, format="%d/%m/%Y")

#################################################################
# Subset data in 2 days, and delete raw_data from memory
################################################################# 
subdata <- subset(raw_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(raw_data)

#################################################################
# Concatenate Date and Time to create time stamp field
#################################################################
datetime <- paste(as.Date(subdata$Date), subdata$Time)
subdata$Datetime <- as.POSIXct(datetime)

#################################################################
# Plot "Global Active power", 
#      "Voltage"
#      "Energy Sub Metering"
#      "Global_reactive_power" plots - Plot 4
#################################################################
par(mfrow = c(2, 2))
with(subdata, {
    plot(Global_active_power~Datetime, type="l", 
         ylab="Global Active Power", xlab="")
    plot(Voltage~Datetime, type="l", 
         ylab="Voltage", xlab="datetime")
    plot(Sub_metering_1~Datetime, type="l", 
         ylab="Energy Sub Metering", xlab="")
    lines(Sub_metering_2~Datetime,type="l",col='Red')
    lines(Sub_metering_3~Datetime,type="l",col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")       
    plot(Global_reactive_power~Datetime, type="l", 
         ylab="Global_reactive_power",xlab="datetime")
})

#################################################################
# Save the plot inot PNG format, turn off the graphics device
#################################################################
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

