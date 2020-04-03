df <- read.csv('data/bikeshare.csv')
head(df)

#EDA
library(ggplot2)
library(ggplot2movies)
pl <- ggplot(df,aes(x=temp,y=count)) + geom_point(aes(color=temp),alpha=0.5,size=3)
print(pl)
df$datetime <- as.POSIXct(df$datetime)
pl2 <- ggplot(df, aes(x=datetime,y=count)) + geom_point(aes(color=temp)) + scale_color_gradient(low = 'blue', high = 'red')
print(pl2)

library(corrgram)
library(corrplot)
any(is.na(df))
df2 <- subset(df,select = c(temp,count))
num.col <- sapply(df2, is.numeric)
cor.data <- cor(df2[,num.col])
corrplot(cor.data, method = 'color')

pl3 <- ggplot(df, aes(x=factor(season),y=count)) + geom_boxplot(aes(color=factor(season)))
print(pl3)

# Feature Engineering
time.stamp <- format(df$datetime, format="%H")
df$hour <- time.stamp
head(df)

pl4 <- ggplot(subset(df,workingday==1), aes(x=hour,y=count)) + geom_point(aes(color=temp),size=2,position=position_jitter(w=1, h=0), alpha=0.5) + scale_color_gradientn(colours = rainbow(n=150, rev = TRUE, start = 0, end = 0.7))
print(pl4)

pl5 <- ggplot(subset(df,workingday==0), aes(x=hour,y=count)) + geom_point(aes(color=temp),size=2,position=position_jitter(w=1, h=0), alpha=0.5) + scale_color_gradientn(colours = rainbow(n=15, rev = TRUE, start = 0, end = 0.65))
print(pl5)

# Building the Model
train <- subset(df, )
temp.model <- lm(count ~ temp, df)
summary(temp.model)
# rough prediction of 25 degree
mean(predict(temp.model, subset(df,24.5<=temp&temp<=25.5)))
df$hour <- sapply(df$hour, as.numeric)
# use more columns
model <- lm(count ~ . - casual - registered - datetime - atemp,data = df)
summary(model)
