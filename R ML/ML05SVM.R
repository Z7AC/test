library(ISLR)
print(head(iris))

library(e1071)
model <- svm(Species ~ ., data=iris)
summary(model)
pred <- predict(model, iris[1:4])
table(pred,iris[,5])

tune.result <- tune(svm,train.x = iris[1:4],train.y = iris[,5],kernel=('radial'),ranges = list(gamma=c(0.5,1,2),cost=c(0.1,1,10)))
summary(tune.result)