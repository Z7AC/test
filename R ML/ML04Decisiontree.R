library(rpart)

str(kyphosis)

tree <- rpart(Kyphosis ~ ., method = 'class', data = kyphosis)
printcp(tree)
library(rpart.plot)
prp(tree)

library(randomForest)
rf.model <- randomForest(Kyphosis ~ ., data=kyphosis)
print(rf.model)
