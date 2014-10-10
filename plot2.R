# Generate Plot 2

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

png("plot2.png", width = 480, height = 480)

# Limit to the defined data for plot2
valid <- !is.na(data$Global_active_power)
plot(datetime[valid], data$Global_active_power[valid], type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()
