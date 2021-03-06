
#Getting and Cleaning Data - Week 2


### Problème d'installation RMySQL
-> [La Solution](http://stackoverflow.com/questions/24537257/installing-rmysql-in-mavericks)

-> Démarrer le serveur, dans le terminal Mac OS X : 
```
mysql.server start
```

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

### Connection web
Scrapper avec readLines:
```
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlcode = readLines(con)
close(con)
htmlCode
```
Parsing avec XML:
```
library(XML)
url<-"http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url,useInternalNodes=T)

xpathSApply(html,"//title",xmlValue)
```
GET avec le package httr:
```
library(httr);
url<-"http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml,"//title",xmlValue)
```
Sites authentification:
```
pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user","passwd"))
names(pg2)
```
Utiliser des handles:
```
google = handle("http://google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")
```

### Connection à une API (oauth+httr)
Accéder à Twitter:
```
myapp = oauth_app("twitter", key="...", secret="...")
sig = sign_oauth1.0(myapp,token="...", token_secret="...")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json",sig)
```
Conversion en JSON de l'objet:
```
json1 = content(homeTL)
json2 = jsonlite:fromJSON(toJSON(json1))
json2
```

### Autres sources
* Depuis des fichiers : file, url, gzfile, bzfile...
* Depuis des softs : read.arff (Weka), read.dta (Stat), read.mtp (Minitab), read.octave, read.spss, read.xport (SAS)
* Depuis des bases: RPostgreSQL, RODBC, RMongo...
* Depuis des images : jpeg, readbitmap, png...
* Données géographiques : rdgal, rgeos, raster
* ...
