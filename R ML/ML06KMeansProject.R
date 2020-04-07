library(ggplot2)

dfw <- read.csv('data/winequality-white.csv',sep = ';')
dfr <- read.csv('data/winequality-red.csv',sep = ';')

dfw$label <- 'white'
dfr$label <- 'red'

head(dfw)
head(dfr)

wine <- rbind(dfw,dfr)
str(wine)

pl <- ggplot(wine, aes(x=residual.sugar)) + geom_histogram(aes(fill=label), color='black')
print(pl)

pl2 <- ggplot(wine, aes(x=citric.acid)) +geom_histogram(aes(fill=label),color='black')
print(pl2)

pl3 <- ggplot(wine, aes(x=alcohol)) +geom_histogram(aes(fill=label),color='black')
print(pl3)

pl4 <- ggplot(wine, aes(x=citric.acid,y=residual.sugar)) + geom_point(aes(color=label),alpha=0.5)
print(pl4)

pl5 <- ggplot(wine, aes(x=volatile.acidity,y=residual.sugar)) + geom_point(aes(color=label),alpha=0.5)
print(pl5)

clusdata <- wine[,-13]
head(clusdata)

wine.cluster <- kmeans(x = clusdata,centers = 2, nstart = 20)
# clust <- cbind(clusdata, wine.cluster$cluster)
# ave <- rbind(sapply(subset(clust,wine.cluster$cluster==1),mean),sapply(subset(clust,wine.cluster$cluster==2),mean))
# head(ave)

# above replaced by:
print(wine.cluster$centers)

table <- table(wine$label,wine.cluster$cluster)
print(table)
