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

#Subset all coal combustion-related sources from both datasets
comBust <- grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE)
coalcomBust <- (comBust & coal)
ccSCC <- SCC[coalcomBust, ]$SCC
ccNEI <- NEI[NEI$SCC %in% ccSCC,]

# Store subsetted data in an object
g <- ggplot(ccNEI, aes(factor(year), Emissions/10^5,fill=year ))
#Plot data stored in object
g+geom_bar(stat="identity")+
  guides(fill=FALSE)+
  labs(x="Year", y= "Total Tons of PM2.5 Emissions 10^5",
       title = "U.S. Coal Combustion Emissions")+
  theme(plot.title = element_text(hjust = 0.5))

# Save as PNG
dev.copy(png,"plot4.png")
dev.off()



  


  

