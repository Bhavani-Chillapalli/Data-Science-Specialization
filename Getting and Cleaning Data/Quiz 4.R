library(httr)
library(jsonlite)
library(dplyr)
library(jpeg)
library(data.table)
library(lubridate)

##Question 1

file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(file_url,"C:/Users/BhavaniC/Downloads/FSS.csv",method = "curl")
ffs <- read.csv("C:/Users/BhavaniC/Downloads/FSS.csv")
strsplit(names(ffs),"wgtp")[[123]]

##Answer - "" "15"


##Question 2

file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(file_url,"C:/Users/BhavaniC/Downloads/GDP.csv",method = "curl")
gdp <- data.table(read.csv("C:/Users/BhavaniC/Downloads/GDP.csv",skip = 4,nrows = 215))

gdp$X.4 <- as.numeric(gsub(",","",gdp$X.4))
mean(gdp$X.4,na.rm = TRUE)

##Answer - 377652.4


##Question 3

isUnited <- grepl("^United", gdp$X.3)
summary(isUnited)

##Answer -grep("^United",countryNames), 3


##Question 4

file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(file_url,"C:/Users/BhavaniC/Downloads/GDP.csv",method = "curl")
gdp <- data.table(read.csv("C:/Users/BhavaniC/Downloads/GDP.csv",skip = 4,nrows = 215))
gdp <- gdp[gdp$X != ""]
gdp <- gdp[,list(X,X.1,X.3,X.4)]
setnames(gdp, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))

file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(file_url,"C:/Users/BhavaniC/Downloads/EDU.csv",method = "curl")
edu <- data.table(read.csv("C:/Users/BhavaniC/Downloads/EDU.csv"))
names(gdp)
names(edu)
merged_data <- merge(gdp,edu,all = TRUE,by = c("CountryCode"))

fiscal_year_flag <- grepl("fiscal year end",tolower(merged_data$Special.Notes))
june_flag <- grepl("june",tolower(merged_data$Special.Notes))
table(fiscal_year_flag,june_flag)

##Answer - 13


##Question 5


library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

addmargins(table(year(sampleTimes), weekdays(sampleTimes)))
