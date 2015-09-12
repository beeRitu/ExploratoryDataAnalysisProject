library(dplyr)

#Read the data file stored in the current working directory
data <-
  read.table("./household_power_consumption.txt",sep = ";",header = TRUE)

#Combine date and time,change to date and time format and add it to a new column date_time
data <-
  mutate(data,date_time = as.POSIXct(paste(data$Date, data$Time), format =
                                       "%d/%m/%Y %H:%M:%S"))

#filter out the data to be used by date condition
data_subset <- filter(data,date_time >= "2007-02-01 00:00:00") %>%
  filter(date_time < "2007-02-03 00:00:00")

#Change global active power to class numeric 
data_subset$Global_active_power <-
  as.numeric(as.character(data_subset$Global_active_power))

#Plot 1
png(file="Plot1.png")
with(data_subset,hist(
  as.numeric(data_subset$Global_active_power),main="Global Active Power",col = "red",xlab = "Global Active Power (kilowatts)"
))
dev.off()

