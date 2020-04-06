library(ISLR)
library(dplyr)
df <- data.frame(College)

library(ggplot2)
pl1 <- ggplot(df, aes(x=Room.Board,y=Grad.Rate)) + geom_point(aes(color=Private))
print(pl1)

pl2 <- ggplot(df, aes(x=F.Undergrad)) + geom_histogram(aes(fill=Private),color = 'black')
print(pl2)

pl3 <- ggplot(df, aes(x=Grad.Rate)) + geom_histogram(aes(fill=Private),color = 'black')
print(pl3)
print(subset(df, Grad.Rate == 100))

library(caTools)
set.seed(101)
sample <- sample.split(df$Private,0.7)
train <- subset(df, sample==T)
train.y <- subset(df$Private,sample==T)
test <- subset(df, sample==F)
test.y <- subset(df$Private,sample==F)

library(rpart)
library(rpart.plot)

tree <- rpart(Private ~ ., data = train, method = 'class')
print(tree)
pred <- predict(tree, test, method='class')

joint <- function(n){
  if (n>=0.5) {
    return('Yes')
  }else{
    return('No')
  }
}
pred.joint <- sapply(pred[,2], joint)
table <- table(pred.joint,test.y)
print(table)
prp(tree)

library(randomForest)
rf <- randomForest(Private ~ .,data = train,importance=TRUE)
print(rf$confusion)
print(rf$importance)
pred.rf <- predict(rf, test, method='class')
table <- table(pred.rf,test.y)
print(table)



