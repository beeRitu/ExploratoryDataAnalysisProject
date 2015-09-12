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

#Plot3
plot.new()
jpeg(file="Plot3.jpeg")
with(data_subset,plot(data_subset$date_time,data_subset$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
#Sub_metering_1 and Sub_metering_2 data converted to class numeric from class factor
lines(data_subset$date_time,as.numeric(as.character(data_subset$Sub_metering_1)),type="l",col="black")
lines(data_subset$date_time,as.numeric(as.character(data_subset$Sub_metering_2)),type="l",col="red")
lines(data_subset$date_time,data_subset$Sub_metering_3,type="l",col="blue")
legend("topright",lwd=2,col = c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()