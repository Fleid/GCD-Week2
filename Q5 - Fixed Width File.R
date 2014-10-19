
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",destfile="GCD-W2-Q5.for",method="curl")

x <- read.fwf(
  file="GCD-W2-Q5.for",
  skip=4,
  widths=c(12, 7,4, 9,4, 9,4, 9,4),
  col.names=c("Week","Nino1+2.SST","Nino1+2.SSTA","Nino3.SST","Nino3.SSTA","Nino34.SST","Nino34.SSTA","Nino4.SST","Nino4.SSTA")
)

sum(x$Nino3.SST)