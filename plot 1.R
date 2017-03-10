#Load Packages
library(downloader)
#set working directory
setwd("C:/wd/EDA/Assign2")
#Download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download(fileUrl, dest="dataset.zip", mode="wb") 
#Unzip file
unzip(zipfile="./dataset.zip",exdir=".")

# Read data and store in to objects
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get the emission total for each year
emTotal <- aggregate(Emissions ~ year,NEI, sum)

#convert number to scientific notation
emTotal2 <- (emTotal$Emissions)/10^6

#Draw plot
barplot(emTotal2, emTotal$year, names.arg=emTotal$year, 
        xlab = "year", ylab = "Total Tons of PM2.5 Emissions 10^6", 
        col = "green", main = "Total PM2.5 Emissions From All Sources in the United States")

# Save as PNG
dev.copy(png,"plot1.png")
dev.off()