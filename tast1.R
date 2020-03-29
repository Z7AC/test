# Visualization exercise
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
# However if you want to align the title centered add the line:  + theme(plot.title = element_text(hjust=0.5))



# Scatterplot
pl <- ggplot(mtcars,aes(x=wt,y=mpg))
pl2 <- pl + geom_point(alpha=0.7, size=5, aes(color=hp))
pl3 <- pl2 + scale_color_gradient(low = '#03fcf4', high = '#2003fc')
# print(pl3)

# Barplot
df <- mpg
pl <- ggplot(df, aes(x=class))
pl+geom_bar(aes(fill=factor(cyl)),position = 'dodge')
pl+geom_bar(aes(fill=factor(cyl)),position = 'fill')

# Boxplot
df <- mtcars
pl <- ggplot(df,aes(x=factor(cyl),y=hp))
# print(pl + geom_boxplot())

# 2 Variable plotting
pl <- ggplot(movies,aes(x=year,y=rating))
pl2 <- pl + geom_bin2d(binwidth=c(3,2))
# print(pl2)

# Coordinates and Faceting
pl <- ggplot(mpg, aes(x=displ,y=hwy)) + geom_point()
# pl2 <- pl + coord_cartesian(xlim = c(2,6), ylim = c(20,40))
# pl2 <- pl + coord_fixed(ratio = 2)
# print(pl2)
pl + facet_grid(. ~ cyl)



# Exercise
pl <- ggplot(mpg, aes(hwy)) + geom_histogram()
# print(pl)
pl2 <- ggplot(mpg, aes(manufacturer)) + geom_bar(aes(fill=factor(cyl)))
# print(pl2)

df <- txhousing
pl <- ggplot(txhousing, aes(x=sales,y=volume)) + geom_point() + geom_smooth(color='red')
print(pl)





