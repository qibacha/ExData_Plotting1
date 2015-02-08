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
# Plot "Energy Sub Metering" plot - Plot 3
#################################################################
with(subdata, {
 plot(Sub_metering_1~Datetime, type="l",
      ylab="Energy Sub Metering", xlab="")
 lines(Sub_metering_2~Datetime,col='Red')
 lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#################################################################
# Save the plot inot PNG format, turn off the graphics device
################################################################# 
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()