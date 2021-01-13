## Exploratory Data Analysis - Course Project 1

## 0. Loading data set into R
        
        ## Reading data
        pre_power <- read.table("household_power_consumption.txt", skip = 1, 
                                sep = ";")
        colnames(pre_power) <- c("Date", "Time", "GlobalActivePower", 
                                 "GlobalReactivePower", "Voltage", 
                                 "GlobalIntensity", "SubMetering1", 
                                 "SubMetering2", "SubMetering3")
        
        ## Converting date and time variables
        library(lubridate)
        pre_power$Date <- dmy(pre_power$Date)
        pre_power$Time <- strptime(pre_power$Time, format="%H:%M:%S")
        
        ## Subsetting required data
        power_con <- subset(pre_power, Date == "2007-02-01" | Date == "2007-02-02")
        
        ## Re-formatting "Time" column
        power_con[1:1440, "Time"] <- format(power_con[1:1440, "Time"],
                                            "2007-02-01 %H:%M:%S")
        power_con[1441:2880, "Time"] <- format(power_con[1441:2880, "Time"],
                                            "2007-02-02 %H:%M:%S")

## 1. Building plot 1: Histogram
        
        png(filename = "plot1.png")
        hist(as.numeric(power_con$GlobalActivePower), col = "red", 
             xlab = "Global Active Power (kilowatts)", 
             main = "Global Active Power")
        dev.off()
        
## 2. Building plot 2: Global Active Power line plot across time
        
        png(filename = "plot2.png")
        plot(power_con$Time, as.numeric(power_con$GlobalActivePower), 
             xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
        dev.off()
        
## 3. Building plot 3: Sub Metering line plot across time
        
        png(filename = "plot3.png")
        plot(power_con$Time, power_con$SubMetering1, type = "n",
             xlab = "", ylab = "Energy sub metering")
        with(power_con, lines(Time, as.numeric(power_con$SubMetering1)))
        with(power_con, lines(Time, as.numeric(power_con$SubMetering2), 
                              col = "red"))
        with(power_con, lines(Time, as.numeric(power_con$SubMetering3), 
                              col = "blue"))
        legend("topright", lty = 1, col = c("black", "red", "blue"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        dev.off()
        
## 4. Building plot 4: Four plots
        
        png(filename = "plot4.png")
        
        par(mfcol = c(2,2))
        
        ## Plot 1
        plot(power_con$Time, as.numeric(power_con$GlobalActivePower), 
             xlab = "", ylab = "Global Active Power", type = "l")
        
        ## Plot 2
        plot(power_con$Time, power_con$SubMetering1, type = "n",
             xlab = "", ylab = "Energy sub metering")
        with(power_con, lines(Time, as.numeric(power_con$SubMetering1)))
        with(power_con, lines(Time, as.numeric(power_con$SubMetering2), 
                              col = "red"))
        with(power_con, lines(Time, as.numeric(power_con$SubMetering3), 
                              col = "blue"))
        legend("topright", lty = 1, col = c("black", "red", "blue"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        
        ## Plot 3
        plot(power_con$Time, as.numeric(power_con$Voltage), 
             xlab = "datetime", ylab = "Voltage", type = "l")
        
        ## Plot 4
        plot(power_con$Time, as.numeric(power_con$GlobalReactivePower), 
             xlab = "datetime", ylab = "Global_reactive_power", type = "l")
        
        dev.off()
        