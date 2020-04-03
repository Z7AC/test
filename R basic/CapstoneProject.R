# Moneyball

library(ggplot2)
library(dplyr)

# Data
batting <- read.csv('data/Batting.csv')
str(batting)
head(batting$AB)
head(batting$X2B)

# Feature engineering

batting$BA <- batting$H / batting$AB
tail(batting$BA,5)

batting$OBP <- (batting$BB+batting$H+batting$HBP)/(batting$AB+batting$BB+batting$HBP+batting$SF)
tail(batting$OBP)

batting$X1B <- batting$H-batting$X2B-batting$X3B-batting$HR
tail(batting$X1B)

batting$SLG <- (batting$X1B+ 2*batting$X2B + 3*batting$X3B + 4*batting$HR) / batting$AB
tail(batting$SLG)
str(batting)

# Merge salery data with bating data
sal <- read.csv('data/Salaries.csv')
temp <- subset(batting, yearID>=1985)
summary(temp)
combo <- merge(batting, sal,by=c('playerID','yearID'))
summary(combo)

# Analyzing the lost players
lost_players <- subset(combo, playerID %in% c('giambja01', 'damonjo01', 'saenzol01'))
lost_players <- subset(lost_players, yearID==2001)
lost_players <- subset(lost_players, select = c(playerID,H,X2B,X3B,HR,OBP,SLG,BA,AB))

# Replacment players
combo2001 <- subset(combo, yearID==2001, select = c(playerID, salary,AB,OBP))
combo2001 <- subset(combo2001, salary<=5000000)
combo2001 <- subset(combo2001, AB>=490)
combo2001 <- subset(combo2001, OBP>0.37)
arrange(combo2001, desc(OBP),salary,AB)