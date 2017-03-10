#Load Packages
library(downloader)
library(ggplot2)
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

#save data to an object
g <- ggplot(baltimore, aes(factor(year), Emissions))
            
#Plot data saved in g
g+geom_bar(stat="identity") + 
  guides(fill=FALSE)+
  facet_grid(.~type)+
  labs(title = "PM2.5 Emissions in Baltimore by Source Type",
       x = "Year", y = "Total Tons of Pm2.5 Emissions")+
  theme(plot.title = element_text(hjust = 0.5))

# Save as PNG
dev.copy(png,"plot3.png")
dev.off()