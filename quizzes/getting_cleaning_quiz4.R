### Getting and Cleaning Data - Quiz week 4


## Question 1

setwd("~/git/datasciencecoursera")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
file <- "housing.csv"
download.file(url, file, method="curl")
df.housing <- read.csv(file)
split.strings <- strsplit(names(df.housing), split="wgtp")
split.strings[[123]]


## Questions 2, 3 and 4

library(dplyr)
setwd("~/git/datasciencecoursera")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
file <- "gdp.csv"
download.file(url, file, method="curl")
df.gdp.raw <- read.csv(file, skip=5, header=FALSE, nrows=190, col.names=c("countrycode", "rank", "V3", "country", "gdp", "V6", "V7", "V8", "V9", "V10"))
df.gdp <- select(df.gdp.raw, c(1, 2, 4, 5))
df.gdp$gdp <- as.numeric(sapply(df.gdp$gdp, FUN=function(x) {gsub(x=x, pattern="(,| )", replacement="")}))
mean(df.gdp$gdp)

countryNames <- df.gdp$country
grep("^United",countryNames)

url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
file2 <- "edu.csv"
download.file(url2, file2, method="curl")
df.edu <- read.csv(file2)
df.gdp.edu <- merge(df.gdp, df.edu, by.x="countrycode", by.y="CountryCode")
grep(pattern="[Ff]iscal.*June", x=df.gdp.edu$Special.Notes, value=TRUE)


## Question 5

if(!require(lubridate)){install.packages("lubridate"); require(lubridate)}
if(!require(quantmod)){install.packages("quantmod"); require(quantmod)}
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
sum(year(sampleTimes)==2012)
sum(year(sampleTimes)==2012 & weekdays(sampleTimes)=="Monday")