# install.packages("MASS")
library(MASS)

head(Boston)
any(is.na(Boston))

data <- Boston

# Normalize data
maxs <- apply(data,2,max)
mins <- apply(data, 2, min)
data.standarded <- scale(data, center = mins, scale = maxs-mins)
scaled <- as.data.frame(data.standarded)

library(caTools)
set.seed(101)
sample <- sample.split(scaled,0.7)
train <- subset(scaled, sample==T)
test <- subset(scaled,sample==F)

# install.packages("neuralnet")
library(neuralnet)
n <- names(train)

f <- as.formula(paste('medv ~',paste(n[!n %in% 'medv'], collapse = '+')))

# build model
nn <- neuralnet(f, data = train, hidden = c(5,3), linear.output = T)
plot(nn)
pred <- compute(nn,test[1:13])

# convert data
true.pred <- pred$net.result * (max(data$medv)-min(data$medv)) + min(data$medv)
true.test <- test$medv*(max(data$medv)-min(data$medv)) + min((data$medv))
MSE.nn <- sum((true.pred - true.test)^2/nrow(test))
print(MSE.nn)

# Visualize error
error <- data.frame(true.test,true.pred)
library(ggplot2)
pl <- ggplot(error, aes(x=true.test,y=true.pred)) + geom_point() + stat_smooth()
print(pl)

