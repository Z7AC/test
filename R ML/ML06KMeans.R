library(ISLR)
library(ggplot2)
pl <- ggplot(iris,aes(Petal.Length,Petal.Width,color=Species)) + geom_point(size=4)
print(pl)

library(caTools)
set.seed(101)

cluster <- kmeans(iris[,1:4],3,nstart = 20)
print(cluster)

table <- table(cluster$cluster,iris$Species)
print(table)

library(cluster)
clusplot(iris[,1:4],cluster$cluster,color=T,shade=T,labels=0,lines=0)
