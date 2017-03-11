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

#Search and subset vehicle data
veH <- grepl("vehicles", SCC$SCC.Level.Two, ignore.case=TRUE)
veHSCC <- SCC[veH,]$SCC
veHNEI <- NEI[NEI$SCC %in% veHSCC,]


#Subset all Baltimore data
BalveH <- veHNEI[veHNEI$fips == 24510,]

#Subset all LA data
laveH<- veHNEI[veHNEI$fips=="06037",]

#Combine both
both <- rbind(BalveH,laveH)

#Relabel fips to the city names
both$fips[both$fips== "24510"] <- "Baltimore"
both$fips[both$fips== "06037"] <- "LA County"


# Store subsetted data in an object
g <- ggplot(both, aes(factor(year), Emissions,fill=year))

#Plot data stored in object
g+geom_bar(stat="identity")+
  facet_grid(.~fips)+
  guides(fill=FALSE)+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(x="Year", y= "Emission of PM2.5 in tons",
       title = "PM2.5 by Motor Vehicle Sources in LA County and Baltimore")






