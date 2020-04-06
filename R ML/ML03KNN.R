# install.packages("ISLR")
library(ISLR)

str(Caravan)
summary(Caravan$Purchase)
any(is.na(Caravan))

purchase <- Caravan$Purchase
# standardization
standarded_caravan <- scale(Caravan[,-86])
print(var(standarded_caravan[,1]))
print(var(standarded_caravan[,2]))

# split train/test set
test.index <- 1:1000
test <- standarded_caravan[test.index,]
test_y <- purchase[test.index]

train <- standarded_caravan[-test.index,]
train.y <- purchase[-test.index]


### KNN
library(class)
set.seed(101)
pred.purchase <- knn(train=train,test=test,cl=train.y,k=1)
head(pred.purchase)

missclasserr <- mean(test_y != pred.purchase)
print(missclasserr)

### choose a K-value
pred.purchase <- knn(train=train,test=test,cl=train.y,k=5)
head(pred.purchase)

missclasserr <- mean(test_y != pred.purchase)
print(missclasserr)

### using a loop
for (n in 1:20) {
  set.seed(101)
  pred.purchase <- knn(train=train,test=test,cl=train.y,k=n)
  missclasserr[n] <- mean(test_y != pred.purchase)
}
print(missclasserr)

### Visualization
library(ggplot2)
K_Value <- 1:20
error.df <- data.frame(missclasserr,K_Value)
pl <- ggplot(error.df,aes(x=K_Value, y=missclasserr)) + geom_line()
print(pl)



