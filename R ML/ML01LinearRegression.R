library(ggplot2)
library(dplyr)
library(corrgram)
library(corrplot)

df <- read.csv('data/student-mat.csv', sep = ';')
any(is.na(df))
num.col <- sapply(df, is.numeric)
cor.data <- cor(df[,num.col])
corrplot(cor.data, method = 'color')

library(caTools)
set.seed(101)
sample <- sample.split(df$G3, SplitRatio = 0.7)

train <- subset(df, sample==TRUE)
test <- subset(df,sample==FALSE)

model <- lm(G3 ~ ., data = train)

# print(summary(model))
g3pred <- predict(model,test)

results <- cbind(g3pred, test$G3)
colnames(results) <- c('pred','actual')
results <- as.data.frame(results)
print(head(results))
# to zero
to_zero <- function(x){
  if(x<0){
    return(0)
  }else{
    return(x)
  }
}
results$predtozero <- sapply(results$pred, to_zero)


pl <- ggplot(results, aes(x=predtozero,y=actual)) + geom_point()
print(pl)