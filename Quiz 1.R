getwd()
setwd("d:/Users/yangsu/Desktop")
getwd()

certain markdown examplges: http://rmarkdown.rstudio.com/

** Question 1 **

h1url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
help(download.file)
download.file(h1url,destfile="comdata.csv")
comdata<-read.table("comdata.csv",header=TRUE,sep=",")   # sep="," is important#

head(comdata)
names(comdata) 
nrow(comdata)  #doesn't include the header line when counting the row number
ncol(comdata)  

typeof(comdata$VAL)
newdata<-subset(comdata, comdata$VAL>23)
nrow(newdata)

# antoher code without subset, better one
length(comdata$VAL[!is.na(comdata$VAL) & comdata$VAL==24])

# check certain colname number #
which(colnames(comdata)=="VAL")


**Question 2**

comdata$FES
max(comdata$FES,na.rm = TRUE)
which(colnames(comdata)=="FES" )
table(comdata$FES)

# The answer is: tidy data has one variable per column… FES has: gender, marital status and empoloyement status.
# reference about tidy data: http://vita.had.co.nz/papers/tidy-data.pdf


**Question 3**

h3url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
# need to add mode="wb", otherwise the file will corrupted
download.file(h3url,destfile="gasdata.xlsx",mode="wb")
library(xlsx)
gasdata<-read.xlsx("gasdata.xlsx",sheetIndex=1,rowIndex=18:23,colIndex=7:15)
gasdata
sum(gasdata$Zip*gasdata$Ext,na.rm=T)


**Question4**

library(XML)
fileurl<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc<-xmlTreeParse(fileurl,useInternal=TRUE)
rootnode<-xmlRoot(doc)
names(rootnode)
names(rootnode[[1]][[1]])

zipcode<-xpathSApply(rootnode,"//zipcode",xmlValue)
zipcode
length(zipcode[zipcode=="21231"])
# or table(zipcode)


**Question 5**


h5url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(h5url,"acdata.csv")
library(data.table)
DT<-fread("acdata.csv",sep="auto")

# method 1
ptm <- proc.time()
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
proc.time()-ptm

ptm <- proc.time()
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
proc.time()-ptm

ptm <- proc.time()
mean(DT$pwgtp15,by=DT$SEX)
proc.time()-ptm

ptm <- proc.time()
for (i in 1:50){
tapply(DT$pwgtp15,DT$SEX,mean)
}
proc.time()-ptm

ptm <- proc.time()
for (i in 1:50){
DT[,mean(pwgtp15),by=SEX]
}
proc.time()-ptm

ptm <- proc.time()
for (i in 1:50){
sapply(split(DT$pwgtp15,DT$SEX),mean)
}
proc.time()-ptm

# method 2
system.time(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
system.time(tapply(DT$pwgtp15,DT$SEX,mean))

# method 3 - most recommended
check <- function(y, t) {
  message(sprintf("Elapsed time: %.10f", t[3]))
  print(y)
}

t <- system.time(y <- sapply(split(DT$pwgtp15, DT$SEX), mean))
check(y,t)
