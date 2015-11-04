# Libraries
library(XML)

# Download xml file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
file <- "./data.xml"
download.file(url, file, method="curl")

# Retrieve data from xml
restaurants <- xmlTreeParse(file, useInternal=TRUE)
zipcodes <- xpathSApply(restaurants,"//zipcode",xmlValue)
sum(zipcodes=="21231")


### Question 5

# Libraries
library(data.table)

# Global variables
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
file <- "idaho_housing.csv"

# Download data
download.file(url, file, method="curl")

# Read data
DT <- fread(file)