# *Quiz3_Q1* 

setwd("d:/Users/yangsu/Desktop")
getwd()
q1url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(q1url,destfile="distdata.csv")
distdata<-read.csv("distdata.csv")

distdata$agricultureLogical<- ifelse(distdata$ACR=="3"&distdata$AGS=="6",TRUE,FALSE)
#the same as distdata$agricultureLogical1<- distdata$ACR==3&distdata$AGS==6
table(distdata$agricultureLogical)
which(distdata$agricultureLogical==TRUE)
# same as which(distdata$agricultureLogical1)


# *Quiz3_Q2* 

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
f <- file.path(getwd(), "jeff.jpg")
download.file(url, f, mode="wb")
library(jpeg)
img <- readJPEG(f, native=TRUE)
img
quantile(img, probs=c(0.3, 0.8))


# *Quiz3_Q3*

getwd()
file.url<- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
file.dest <- 'GDP1222.csv'
download.file(file.url, file.dest)
gdp <- read.csv('GDP.csv', header=F, skip=4, nrows=380,blank.lines.skip = TRUE)
dgp1<-na.omit(gdp)
View(dgp1)

url2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url2,destfile="edu.csv")
edu<-read.csv("edu.csv",sep=",",blank.lines.skip = TRUE)
View(edu)
str(edu)

comdata<-merge(dgp1,edu,by.x="V1",by.y="CountryCode",all.x=FALSE,all.y=FALSE)
View(comdata)
nrow(comdata)
ordercomdata<-comdata[order(-comdata$V2),]
ordercomdata[13,1:3]


# *Quiz3_Q4*

View(comdata)
d1<-comdata[(comdata$Income.Group=="High income: OECD"),]
mean(d1$V2)

mean(comdata[(comdata$Income.Group=="High income: nonOECD"),]$V2)


# *Quiz3_Q5*

install.packages("Hmisc")
library(Hmisc)
comdata$group<-cut2(comdata$V2,g=5)
View(comdata)
table(comdata$group,comdata$Income.Group)
