# install.packages("Amelia") # for processing NA data

df_train <- read.csv('data/titanic_test.csv')
head(df_train)
str(df_train)

library(Amelia)
missmap(df_train, main = 'Missing Map', col = c('red','black'))

