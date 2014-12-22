# W3L1

set.seed(111)
x<-data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
x$var2[c(1,3)]=NA
x$var3[c(4)]=NA
x

#subsetting
x[,1]
x[2:3,"var2"]
x[(x$var1>3&x$var3<14),]   # try to find rows statisfy certain criteria
x[(x$var1>3|x$var3<14),]

sort(x$var1)

# sorting
x[which(x$var2>3&x$var3<14),]  # delete NA values
sort(x$var1,decreasing=TRUE)
sort(x$var2,x$var3)
x[order(x$var2,x$var3),]  # use var3 when there are same value in var2

install.packages("reshape")
library(reshape)
attach(leadership)

# sorting package
library(plyr)
arrange(x,desc(var2))  #NA always the last no matter desc or incre
arrange(x,var2)

# add columns or rows 
x$var4<-rnorm(5)
y<-cbind(x,rnorm(5))
z<-rbind(x,rnorm(5))

# useful resource
# http://www.biostat.jhsph.edu/~ajaffe/rsummer2014.html
# http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf

# ** W3L2. summarizing data** 

setwd("d:/Users/yangsu/Desktop")
getwd()
fileUrl<- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="rest.csv")
restdata<-read.csv("rest.csv")

head(restdata,n=3)  #default n=6
tail(restdata,n=2)  #default n=6
summary(restdata)  # text-based or factor variables - give counts, numerical variabes -data summary
str(restdata)  # return the structure of the objective

quantile(restdata$councilDistrict,rm.na=TRUE) # default 0,0.25,0.5,0.75,1
quantile(restdata$councilDistrict,probs=c(0.33,0.69,0.98),rm.na=TRUE)

table(restdata$zipCode,useNA="ifany")  # the table function doesn't count the missing value by default

#check missing value
sum(is.na(restdata$councilDistrict))
any(is.na(restdata$councilDistrict))
all(restdata$zipCode >0)
colSums(is.na(restdata))

table(restdata$zipCode %in% c("21212","21229"))
table(restdata$zipCode == "21212"|restdata$zipCode =="21229")  # same result as above

restdata[restdata$zipCode %in% c("21212","21229"),]  # don't forget the "," as we are selecting certain records/rows

data(UCBAdmissions)
df<-as.data.frame(UCBAdmissions)
summary(df)

xt<-xtabs(Freq~Gender+Admit, data=df) #Freq is the variable want to show in the table 

xt
ftable(xt)


rate<-(xt$Admited)/(xt$Admited+xt$Rejected)
xt1<-cbind(xt,rate)

# ** W3L3. adding variables **

s1<-seq(1,10,by=2)
s1

s2<-seq(1,10,length=2)
s2

s3<-c(1,3,6,7,10)
s3
seq(along=s3)

restdata$nearme<-restdata$neighborhood %in% c("Roland Park","Hampden")
restdata$nearme    # result is True or False
table(restdata$nearme)  

restdata$zipwrong<-ifelse(restdata$zipCode>0,TRUE,FALSE)  # true and false needs capital letter
table(restdata$zipwrong)

restdata$zipwrong<-ifelse(restdata$zipCode>0,1,2)
table(restdata$zipwrong)

restdata$zipgroup<-cut(restdata$zipCode,breaks=2)   # breaks means group number, not interval
table(restdata$zipgroup)

#cut library
library(Hmisc)
restdata$zipgroup<-cut2(restdata$zipCode,g=4)

#factor 
restdata$zcf<-factor(restdata$zipCode)
relevel(restdata$zcf,ref="-21226")  # ref defines the lowest level
restdata$zcn<-as.numeric(restdata$zcf)
table(restdata$zcn)
