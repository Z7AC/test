# Moneyball

library(ggplot2)
library(dplyr)

batting <- read.csv('data/Batting.csv')
batting$BA <- batting$H / batting$AB
tail(batting$BA,5)