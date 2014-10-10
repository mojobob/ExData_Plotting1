# Generate Plot 4

# The source of the raw data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# The data file - in the working directory
dataFile <- "household_power_consumption.txt"

# Only download and unpack the raw data if the data file in the working directory does not yet exist
if (!file.exists(dataFile)) {
        # Download the raw, zipped data into a temporary file
        zipFile <- tempfile(fileext = ".zip")
        download.file(fileUrl, destfile = zipFile, method = "curl")

        # Unzip the raw data into the working directory - overwrite any existing files since they are the same
        unzip(zipFile, overwrite = TRUE)

        # Delete the temporary zip file
        unlink(zipFile)
}

# Read the data
data <- read.table(dataFile, header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

# Limit to the dates of interest
data <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]

# Generate the datetime values from the Date and Time columns
datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S", tz = "GMT")

png("plot4.png", width = 480, height = 480)

# Generate two rows of two graphs
par(mfrow = c(2, 2))

# Plot 1,1
valid <- !is.na(data$Global_active_power)
plot(datetime[valid], data$Global_active_power[valid], type = "l", xlab = "", ylab = "Global Active Power")

# Plot 1,2
valid <- !is.na(data$Voltage)
plot(datetime[valid], data$Voltage[valid], type = "l", xlab = "datetime", ylab = "Voltage")

# Plot 2,1
valid <- !is.na(data$Sub_metering_1)
plot(datetime[valid], data$Sub_metering_1[valid],  type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
valid <- !is.na(data$Sub_metering_2)
points(datetime[valid], data$Sub_metering_2[valid], type = "l", col = "red")
valid <- !is.na(data$Sub_metering_3)
points(datetime[valid], data$Sub_metering_3[valid], type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

# Plot 2,2
valid <- !is.na(data$Global_reactive_power)
plot(datetime[valid], data$Global_reactive_power[valid], type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
