
#Getting and Cleaning Data - Week 2


### Problème d'installation RMySQL
-> [La Solution](http://stackoverflow.com/questions/24537257/installing-rmysql-in-mavericks)


### Connection à un serveur MySQL
Connexion à un serveur:
```
myDBconnect <- dbConnect(MySQL(), user ="genome", host="genome-mysql.cse.ucsc.edu")
```
Lister les bases:
```
myResult <- dbGetQuery(myDBconnect,"show databases;")
```

---
Connexion à une base:
```
myDB_hg19 <- dbConnect(MySQL(), user ="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
```
Lister les tables:
```
allTables <- dbListTables(myDB_hg19)
```
Lister les champs d'une table:
```
dbListFields(myDB_hg19,"affyU133Plus2")
```

---
Exécuter une query:
```
dbGetQuery(myDB_hg19,"select count(*) from affyU133Plus2")
```
Importer une table complète:
```
myData <- dbReadTable(myDB_hg19,"affyU133Plus2")
```
Exécuter une query (option2 - *mais préférer dbGetQuery ou dbReadTable à dbSendQuery, qui ne fetch pas tout le dataset en une passe*)
```
myQuery <- dbSendQuery(myDB_hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
```
Aller chercher le résultat:
```
fetch(myQuery)
fetch(myQuery,n=10) ##TOP 10
```

---
Cloture des connexions:
```
dbDisconnect(myDBconnect)
```
Si on s'est servi d'un dbSendQuery + Fetch:
```
dbClearResult(dbListResults(myDB_hg19)[[1]]) 
dbDisconnect(myDB_hg19)
```

### Connection à HDF5
File format spécifique pour les gros volumes et datasets multiples

Installation du package:
```
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
```
Création d'un fichier:
```
created = h5createFile("example.h5")
```
Création de groupes dans le fichier
```
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")
```
On peut écrire dans les groupes, des matrices, array, data.frame...
```
h5write(A, "example.h5","foo/A")
```
Pour les lire:
```
readA = h5read("example.h5","foo/A")
```
