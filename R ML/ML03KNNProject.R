# 
library(ISLR)
head(iris)

species <- iris[,5]
standarded_iris <- scale(iris[,-5])

library(caTools)
set.seed(101)

sample <- sample.split(standarded_iris[,1],0.7)
train <- subset(standarded_iris, sample==TRUE)
train.y <- subset(species, sample==TRUE)
test <- subset(standarded_iris, sample==FALSE)
test.y <- subset(species, sample==FALSE)

library(class)
pred <- knn(train = train, test = test, cl = train.y, k=1)
missclasserr <- mean(test.y != pred)
print(missclasserr)

K <- 10
for (n in 1:K) {
  pred <- knn(train = train, test = test, cl = train.y, k=n)
  missclasserr[n] <- mean(test.y != pred)
}
k_value <- 1:K
prediction <- data.frame(missclasserr,k_value)
library(ggplot2)
pl <- ggplot(prediction,aes(x=k_value,y=missclasserr)) + geom_line()
print(pl)

