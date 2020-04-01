# DV project

library(ggplot2)
library(ggplot2movies)
library(dplyr)

df <- read.csv('Economist_Assignment_Data.csv', drop(1))
pl <- ggplot(df, aes(x=CPI, y=HDI)) + geom_point(aes(color=Region), size=5, shape=1) + 
  geom_smooth(method = 'lm', aes(group=1),formula = y ~ log(x), se=FALSE, color='red')
# print(pl)
# pl2 <- pl + geom_text(aes(label=Country, color=Region))
# print(pl2)
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")
pl2 <- pl + geom_text(aes(label = Country), color = "gray20", 
                       data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)

# print(pl2)
pl3 <- pl2 + theme_bw() + 
  scale_x_continuous(breaks = 1:10, name = 'Corruption Percetion Indax, 2011 (10=least corrupt)', limits = c(0.8,10.2)) +
  scale_y_continuous( name = 'Human Development Indax, 2011 (1=Best)', limits = c(0.15,1.05), breaks = seq(0.2,1.0, by=0.2)) +
  ggtitle(label = 'Corruption and human development')
print(pl3)