# Generate Plot 1

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

# Extract the points for plot1
p1Data <- data$Global_active_power[!is.na(data$Global_active_power)]

png("plot1.png", width = 480, height = 480)

hist(p1Data, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()
