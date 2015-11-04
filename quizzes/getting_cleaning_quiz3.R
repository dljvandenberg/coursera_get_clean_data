### Getting and Cleaning Data - quiz week 3


## Question 1

# Prepare
setwd("~/git/datasciencecoursera")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
destfile <- "idaho_housing_data.csv"
download.file(url, destfile, method="curl")
df.housing <- read.csv(destfile)

# Create a logical vector that identifies the households on greater than 10 acres
# who sold more than $10,000 worth of agriculture products.
# Assign that logical vector to the variable agricultureLogical.
# Apply the which() function like this to identify the rows of the data frame
# where the logical vector is TRUE. which(agricultureLogical).
# What are the first 3 values that result?
agricultureLogical <- df.housing$ACR == 3 & df.housing$AGS == 6
which(agricultureLogical)[1:3]


## Question 2

setwd("~/git/datasciencecoursera")
library(jpeg)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
destfile <- "jeff.jpg"
download.file(url, destfile, mode="wb", method="curl")
image <- readJPEG(destfile, native = TRUE)
quantiles <- quantile(image, probs=c(0.3, 0.8))
quantiles


## Question 3

library(dplyr)
setwd("~/git/datasciencecoursera")
url_gdp <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url_edu <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
file_gdp <- "gdp.csv"
file_edu <- "edu.csv"
download.file(url_gdp, file_gdp, method="wget")
download.file(url_edu, file_edu, method="wget")
df.gdp <- read.csv(file_gdp, skip=5, header=FALSE, nrows=190)
df.edu <- read.csv(file_edu)
df.gdp <- select(df.gdp, c(1, 2, 4, 5))
names(df.gdp) <- c("countrycode", "ranking", "country", "gdp")
length(intersect(df.gdp$countrycode, df.edu$CountryCode))
df.merged <- merge(df.gdp, df.edu, by.x="countrycode", by.y="CountryCode")
df.merged.sorted <- arrange(df.merged, desc(ranking))
df.merged.sorted$country[[13]]


## Question 4 (uses data of Question 3)

summarize(group_by(df.merged, Income.Group), mean(ranking))


## Question 5 (uses data of Question 3)

library(Hmisc)
df.merged.quantiled <- mutate(df.merged, rankingquantile=cut2(df.merged$ranking, g=5))
table(df.merged.quantiled$rankingquantile, df.merged.quantiled$Income.Group)