
#Getting and Cleaning Data - Week 2


### Problème d'installation RMySQL
-> [La Solution](http://stackoverflow.com/questions/24537257/installing-rmysql-in-mavericks)


### Connection à un serveur MySQL

```myDBconnect <- **dbConnect**(MySQL(), user ="genome", host="genome-mysql.cse.ucsc.edu")
```

```myResult <- **dbGetQuery(myDBconnect,"show databases;")**
```

---

```myDB_hg19 <- dbConnect(MySQL(), user ="genome", **db="hg19"**, host="genome-mysql.cse.ucsc.edu")
```

```allTables <- **dbListTables(myDB_hg19)**
```

```**dbListFields**(myDB_hg19,"affyU133Plus2")
```

---

dbGetQuery(myDB_hg19,"select count(*) from affyU133Plus2")

myData <- **dbReadTable**(myDB_hg19,"affyU133Plus2")

*Préférer dbGetQuery ou dbReadTable à dbSendQuery, qui ne fetch pas tout le dataset en une passe*

myQuery <- **dbSendQuery**(myDB_hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")

**fetch**(myQuery)

**fetch**(myQuery,n=10) ##TOP 10
---------
*Cloture des connexions*

dbDisconnect(myDBconnect)

dbClearResult(dbListResults(myDB_hg19)[[1]]) ##parce qu'on a dbSendQuery

dbDisconnect(myDB_hg19)