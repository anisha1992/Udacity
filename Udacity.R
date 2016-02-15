#Udacity Lesson 1

####Setting up packages, library and data set 
install.packages("ggplot2")
library(ggplot2)
dataggpl(diamonds)



##"Historgram of price data"
qplot(x = price, data = diamonds)



###"Summary Informaiton about Price"
summary(diamonds)


sum(diamonds$price < 500)

sum(diamonds$price < 250)

sum(diamonds$price < 250)

sum(diamonds$price >= 15000)

###Playing aroudn with the histogram using ggplot instead of qplot

p1 <-  ggplot(aes(x = price), data = diamonds) + geom_histogram()

ggplot(aes(x = price), data = diamonds) + geom_histogram() + scale_x_continuous(0,5000)

###Adjusting scale to log? ""
ggplot(aes(x = price), data = diamonds) + geom_histogram() + scale_x_log10()

### Final Adjustment
ggplot(aes(x = price), data = diamonds) + geom_histogram(color = "black", fill = "blue", binwidth=100) +
 scale_x_continuous(limits = c(0, 7500)) + 
  xlab("Price") + ylab("Count")



##Price and Cut
ggplot(aes(x = price), data = diamonds) + geom_histogram(color = "black", fill = "blue", binwidth=100) +
  scale_x_continuous(limits = c(0, 7500)) + 
  facet_grid(cut~.) +
  xlab("Price") + ylab("Count")


###Analysing the 5 histograms
by(diamonds$price, diamonds$cut, max)
by(diamonds$price, diamonds$cut, min)
by(diamonds$price, diamonds$cut, median)


###Using qplot to do the histogram
qplot(x = price, data = diamonds) + facet_wrap(~cut)


##Transforming x axis to log and adjusting bin width 
ggplot(aes(x = price), data = diamonds) + geom_histogram(color = "black", fill = "blue", binwidth=0.1) +
  +     scale_x_log10() + 
  +     facet_grid(cut~.) +
  +     xlab("Price") + ylab("Count")


##Boxplot by color  
qplot(x = color, y = price, data = diamonds, geom= 'boxplot') +
  + coord_cartesian(ylim = c(0, 10000))


##Numerical Statisctics for price of diamonds by color
by(diamonds$price, diamonds$color, summary)


##boxplot of price/carat by color
qplot(x = color, y = price/carat, data = diamonds, geom= 'boxplot') 
+ coord_cartesian(ylim = c(2000, 6000))


##Frequency polygon for weight of carat 
qplot(x = carat, data = diamonds, binwidth =0.01, geom = 'freqpoly') +
  coord_cartesian(xlim = c(0,3))
