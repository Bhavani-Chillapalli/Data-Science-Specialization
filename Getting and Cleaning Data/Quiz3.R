library(httr)
library(jsonlite)
library(dplyr)
library(jpeg)
library(data.table)

##Question 1

file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(file_url,"C:/Users/BhavaniC/Downloads/FSS.csv",method = "curl")
ffs <- read.csv("C:/Users/BhavaniC/Downloads/FSS.csv")

agricultureLogical <- ffs$ACR == 3 & ffs$AGS == 6
which(agricultureLogical)

##Answer - 125,238,262

##Question 2



file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(file_url,"C:/Users/BhavaniC/Downloads/jeff.jpg",method = "curl")
jpg <- readJPEG("C:/Users/BhavaniC/Downloads/jeff.jpg",native = TRUE)
quantiles(jpg,c(0.3,0.8))

##Answer - -15259150 -594524 


##Question 3

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
sum(!is.na(unique(merged_data$rankingGDP)))
merged_data[order(merged_data$rankingGDP,decreasing = TRUE),list(CountryCode,Long.Name.x,rankingGDP)][13]


##Answer - 190 matches, 13th country is St.Kitts and Nevis

##Question 4

dt <- merged_data %>% group_by(Income.Group) %>% summarise(avg = mean(rankingGDP,na.rm = TRUE))

##Answer - 32.96667, 91.91304


##Question 5
group <- quantile(merged_data$rankingGDP,probs = seq(0,1,0.2),na.rm = TRUE)
merged_data$quantileGDP <- cut(merged_data$rankingGDP, breaks = group)
merged_data[Income.Group == "Lower middle income", .N, by = c("Income.Group", "quantileGDP")]

##Answer - 5

