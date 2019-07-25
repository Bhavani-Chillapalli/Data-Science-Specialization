library(readr)
library(dplyr)

hhpc <- read_delim("C:/Users/BhavaniC/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt", 
                                          ";", escape_double = FALSE, trim_ws = TRUE)

hhpc$Date <- as.Date(hhpc$Date, format = "%d/%m/%Y")
hhpc$Time <- strptime(hhpc$Time)




subset <- hhpc %>% filter(Date >= "2007-02-01" & Date <= "2007-02-02")

hist(subset$Global_active_power,main = "Global active power",col = "red",xlab = "Global active power(Kilowatts)")

dev.copy(png, file="plot1.png", height=480, width=480)

dev.off()