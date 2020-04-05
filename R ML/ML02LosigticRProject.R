# Logistic Regression Project
adult <- read.csv('data/adult_sal.csv')
library(dplyr)
adult <- select(adult,-X)


# Data cleaning
# Type_employer column
adult$type_employer <-  as.character(adult$type_employer)
# Stupied try
# for (x in 1:length(adult$type_employer)) {
#   if(adult$type_employer[x]=="Never-worked"|adult$type_employer[x]=='Without-pay'){
#     adult$type_employer[x] <- 'Unemployed'
#   }
# }
adult$type_employer[adult$type_employer %in% c('Without-pay',"Never-worked")] <- 'Unemployed'
adult$type_employer[adult$type_employer %in% c('State-gov',"Local-gov")] <- 'SL-gov'
adult$type_employer[adult$type_employer %in% c('Self-emp-inc','Self-emp-not-inc')]<- 'self-emp'
adult$type_employer <- factor(adult$type_employer)
table(adult$type_employer)


# Marital column
adult$marital <- as.character(adult$marital)
adult$marital[adult$marital %in% c('Married-AF-spouse','Married-civ-spouse','Married-spouse-absent')] <- 'Married'
adult$marital[adult$marital %in% c('Separated','Divorced','Widowed')] <- 'Not-Married'
adult$marital <- factor(adult$marital)
table(adult$marital)


# Country Column
adult$country <- as.character(adult$country)
# countries <- levels(adult$country)
Asia <- c("Cambodia","China","Hong","India","Iran","Japan","Laos","Philippines","Taiwan","Thailand","Vietnam")
North.America <- c("Canada","United-States",'Puerto-Rico')
Europe <- c("England","France","Germany","Holand-Netherlands","Hungary","Ireland","Italy",
            "Poland","Portugal","Scotland","Yugoslavia",'Greece')
Latin.and.South.America <- c("Columbia","Cuba","Dominican-Republic",
                             "Ecuador","El-Salvador","Honduras","Jamaica","Mexico","Nicaragua",
                             "Peru","Outlying-US(Guam-USVI-etc)","Trinadad&Tobago",'Guatemala','Haiti')
Other <- c('?',"South")
adult$country[adult$country %in% Asia] <- 'Asia'
adult$country[adult$country %in% North.America] <- 'North.America'
adult$country[adult$country %in% Europe] <- 'Europe'
adult$country[adult$country %in% Latin.and.South.America] <- 'Latin.and.South.America'
adult$country[adult$country %in% Other] <- 'Other'
adult$country <- factor(adult$country)
table(adult$country)


# Missing data
library(Amelia)
adult[adult=='?'] <- NA
missmap(adult,y.at=c(1),y.labels = c(''),col=c('yellow','black'))
adult <- na.omit(adult)
missmap(adult,y.at=c(1),y.labels = c(''),col=c('yellow','black'), main = 'after omit')


#EDA
library(ggplot2)
pl1 <- ggplot(adult,aes(x=age)) + geom_histogram(aes(color=income), binwidth = 1)
print(pl1)
pl2 <- ggplot(adult,aes(x=hr_per_week)) + geom_histogram(aes(fill=income))
print(pl2)
names(adult)[names(adult)=='country'] <- 'region'
pl3 <- ggplot(adult, aes(x=region)) + geom_bar(aes(fill=income))
print(pl3)


#Building a Model
library(caTools)
set.seed(101)
sample <- sample.split(adult$income, SplitRatio = 0.7)
train <- subset(adult, sample==TRUE)
test <- subset(adult,sample==FALSE)
model <- glm(income ~ ., data = train,family=binomial(logit))
test$predincome <- predict(model, newdata = test, type = 'response')
tab <- table(test$income,test$predincome>0.5)
acc <- sum(diag(tab))/sum(tab)
print('Acc is',acc)
print(tab)
# Recall / Precision ?

# Choose a model by AIC in a Stepwise Algorithm
# nmodel <- step(model)
# summary(nmodel)
# pred <- predict(model, newdata = test, type = 'response')
# results <- cbind(pred, test$income)
# colnames(results) <- c('pred','actual')
# results <- as.data.frame(results)


