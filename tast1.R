# install.packages("ggplot2")
# install.packages("ggplot2movies")

library(ggplot2)
library(ggplot2movies)

# Histrogram
# Data & Aesthetics
pl <- ggplot(movies,aes(x=rating))
# Geometry
pl2 <- pl + geom_histogram(binwidth = 0.1, color = 'red', fill = 'black', alpha = 0.4 )
pl3 <- pl2 + xlab('Rating') + ylab('Num')
# print(pl3 + ggtitle('My Tital'))



# Scatterplot
pl <- ggplot(mtcars,aes(x=wt,y=mpg))
pl2 <- pl + geom_point(alpha=0.7, size=5, aes(color=hp))
pl3 <- pl2 + scale_color_gradient(low = '#03fcf4', high = '#2003fc')
print(pl3)
