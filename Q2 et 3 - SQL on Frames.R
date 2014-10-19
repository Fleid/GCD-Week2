library(sqldf)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",destfile="GCD-W2-Q2.csv",method="curl")
mydata <- read.table("GCD-W2-Q2.csv", sep=",", header=TRUE)
acs = as.data.frame(mydata)

## Dans un terminal : mysql.server start 

sqldf("select pwgtp1 from acs where AGEP < 50")

unique(acs$AGEP)
sqldf("select distinct AGEP from acs")
