library(readr)
library(dplyr)

powerConsumption <- read_delim("C:/Users/BhavaniC/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt", 
                   ";", escape_double = FALSE, trim_ws = TRUE)



powerConsumption2 <- powerConsumption[as.character(powerConsumption$Date) %in% c("1/2/2007", "2/2/2007"),]

# Concatante Date and Time variables

powerConsumption2$dateTime = paste(powerConsumption2$Date, powerConsumption2$Time)



# Convert to Date/Time class

powerConsumption2$dateTime <- strptime(powerConsumption2$dateTime, "%d/%m/%Y %H:%M:%S")

attach(powerConsumption2)



png("plot2.png", width=480, height=480, units="px")

# Plot of Global active power minute by minute

plot(dateTime, as.numeric(as.character(Global_active_power)), type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()


