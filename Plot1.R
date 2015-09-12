library(dplyr)

data <-
  read.table("./household_power_consumption.txt",sep = ";",header = TRUE)
data <-
  mutate(data,date_time = as.POSIXct(paste(data$Date, data$Time), format =
                                       "%d/%m/%Y %H:%M:%S"))
data_subset <- filter(data,date_time >= "2007-02-01 00:00:00") %>%
  filter(date_time < "2007-02-03 00:00:00")
data_subset$Global_active_power <-
  as.numeric(as.character(data_subset$Global_active_power))

#Plot 1
jpeg(file="Plot1.jpeg")
with(data_subset,hist(
  as.numeric(data_subset$Global_active_power),main="Global Active Power",col = "red",xlab = "Global Active Power (kilowatts)"
))
dev.off()

