library(httr)
library(jsonlite)
library(dplyr)


##Question 1 

##To make your own application, register at

#    https://github.com/settings/developers. Use any URL for the homepage URL

#    (http://github.com is fine) and  http://localhost:1410 as the callback url 


oauth_endpoints("github")

myapp <- oauth_app("hub_API", key = "3a054211299ad5563ee4",
                   secret = "0c93508a9047165dd9f470797c16815f6df918d5")

# Get credentials
github_token <- oauth2.0_token(oauth_endpoints("github"),myapp)


# Use API 
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos",gtoken)

stop_for_status(req)
json1 = content(req)
json2 = fromJSON(toJSON(json1))
dat <- json2 %>% filter(json2$name == "datasharing")
dat$created_at

##Answer - 2013-11-07T13:25:07Z


##Question 2

library(sqldf)
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url,"C:/Users/BhavaniC/Downloads/ACS.csv",method = "curl")

acs <- read.csv("C:/Users/BhavaniC/Downloads/ACS.csv")
sqldf("select pwgtp1 from acs where AGEP < 50")

##Answer - sqldf("select pwgtp1 from acs where AGEP < 50")

##Question 3

sqldf("select distinct AGEP from acs")

##Answer - sqldf("select distinct AGEP from acs")

##Question 4

con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
htmlCode

nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])

##Answer - 45,31,7,25

##Question 5

x <- read.fwf(
  file=url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"),
  skip = 4,
  widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
sum(x$V4)

##Answer - 32426.7
