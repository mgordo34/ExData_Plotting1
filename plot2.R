
#Set working directory
setwd("c:/Users/Molly/Documents/DataScience/Course4/")


#Download zipped file
FileURL <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(url=FileURL, destfile="household_power_consumption.zip")






#Unzip the file
unzip("household_power_consumption.zip")

#Create a variable called data that has the table separated based on ";" to generate 9 columns 
data <- read.table('household_power_consumption.txt', header=T, sep=";")

#Subset based off the dates for the assignment
data <- data[which(data$Date == "1/2/2007" | data$Date == "2/2/2007"),] 

for( i in 3:9 ){
  data[[i]] <- sapply(data[[i]], as.character)
  data[[i]] <- sapply(data[[i]], as.numeric)
}

data$Date <- as.Date(data$Date, "%d/%m/%Y")
#Combine Date and Time column
dateTime <- paste(data$Date, data$Time)
#Name the vector
dateTime <- setNames(dateTime, "DateTime")
#Remove Date and Time column
data <- data[ ,!(names(data) %in% c("Date","Time"))]
#Add DateTime column
data <- cbind(dateTime, data)
#Format dateTime Column
data$dateTime <- as.POSIXct(dateTime)

#plot2
png(file="plot2.png", width=480, height=480)

plot(data$dateTime, data$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")

dev.off()
