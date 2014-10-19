url <- "http://biostat.jhsph.edu/~jleek/contact.html"

con = url(url)
htmlcode = readLines(con)
close(con)

v <- c(10,20,30,100)

htmlcode

for (i in v) {print( c(i,nchar(htmlcode[i]),htmlcode[i]) )}