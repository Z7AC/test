loan <- data.frame(read.csv('data/loan_data.csv'))
summary(loan)
str(loan)


loan$inq.last.6mths <- factor(loan$inq.last.6mths)
loan$delinq.2yrs <- factor(loan$delinq.2yrs)
loan$pub.rec <- factor(loan$pub.rec)
loan$not.fully.paid <- factor(loan$not.fully.paid)
loan$credit.policy <- factor(loan$credit.policy)

library(ggplot2)
pl1 <- ggplot(loan,aes(fico)) + geom_histogram(aes(fill=not.fully.paid),bins = 40)
print(pl1)

pl2 <- ggplot(loan,aes(purpose)) + geom_bar(aes(fill=not.fully.paid),position='dodge')
print(pl2)

pl3 <- ggplot(loan, aes(x=int.rate,y=fico)) + geom_point(aes(color=not.fully.paid),alpha=0.6)
print(pl3)

library(caTools)
set.seed(101)
sample <- sample.split(loan[,1],0.7)
train <- subset(loan, sample==T)
test <- subset(loan, sample==F)

library(e1071)
model <- svm(not.fully.paid ~ ., data = train)
summary(model)
pred <- predict(model,test)
table <- table(pred,test[,14])
print(table)

tune_result <- tune(svm, train.x=not.fully.paid~., data=train, kernel='radial', ranges=list(gamma=c(0.1),cost=c(100,200)))
summary(tune_result)

nmodel <- svm(not.fully.paid ~ ., data=train, cost=100, gamma=0.1)
npred <- predict(nmodel,test)
ntable <- table(npred,test[,14])
print(ntable)

