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

#Subset data for Baltimnore
baltimore <- NEI[NEI$fips=="24510",]

# Get the emission total for each year
bmTotal <- aggregate(Emissions ~ year,baltimore, sum)

#Draw plot
barplot(bmTotal$Emissions, bmTotal$year, names.arg=bmTotal$year, 
        col = "red", xlab = "Year", main = "Total PM2.5 Emissions from Baltimore",
        ylab = "Tons of PM2.5 Emissions")

# Save as PNG
dev.copy(png,"plot1.png")
dev.off()