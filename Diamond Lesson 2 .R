#Project 2

### Setting up the packages,library and dataset 
install.packages("ggplot2")

library(ggplot2)

data(diamonds)

names(diamonds)

summary(diamonds)

## X vs Price 
### X vs price - scatter plot 
ggplot(aes(x = x, y = price), data = diamonds) + geom_point()


##Correlations between price; x, y and z
cor.test(x = diamonds$price, y = diamonds$x, method = "pearson")
cor.test(x = diamonds$price, y = diamonds$y, method = "pearson")
cor.test(x = diamonds$price, y = diamonds$z, method = "pearson")

##Depth vs Price 
### price vs depth - scatter plot
ggplot(aes(x = price, y = depth), data = diamonds) + geom_point()

### price vs depth - scatter plot with alpha and scale x adjusted 
ggplot(aes(x = price, y = depth), data = diamonds) + geom_point() + geom_point(alpha = 0.01) + scale_x_continuous(breaks = seq(0, 19000, 2000))



### Correlation between depth and price
cor(x = diamonds$price, y = diamonds$depth, method = "pearson")

##  Carat vs Price 
##Creating a subset data set for carat and price, limiting the top 1%
diamonds_subset <- subset(diamonds,diamonds$price <= quantile(diamonds$price,0.99) & diamonds$carat <= quantile(diamonds$carat,0.99))

## Scatterplot of carat vs price using this new subet database
ggplot(aes(x = carat, y = price), data = diamonds_subset) + geom_point()


## Price vs volume  
###Creating the volume variable
diamonds$volume = diamonds$x * diamonds$y * diamonds$z

### Scatterplot of Price vs volume 
ggplot(aes(x = volume, y = price), data = diamonds) + geom_point() + scale_x_continuous(limits = c(0, 1000))

### Correlation between volume and price

### Creating subset based on volume greater than 0 but less than or equal to 800
num8 <- diamonds[diamonds$volume<800 & diamonds$volume>0,]

##Now calculating the volume and price correlation 
cor(num8$volume, num8$price)


## Diamonds by Clarity
install.packages("dplyr")

library(dyplyr)

diamondsByClarity <- diamonds %>% group_by(clarity) %>%
  +   summarise(mean_price=mean(price), median_price=median(price),
                +             min_price=min(price), max_price=max(price), n=n())


## Bar Charts of Mean Price
## All new subsets created 
data(diamonds)
library(dplyr)

diamonds_by_clarity <- group_by(diamonds, clarity)
diamonds_mp_by_clarity <- summarise(diamonds_by_clarity, mean_price = mean(price))


diamonds_by_color <- group_by(diamonds, color)

diamonds_mp_by_color <- summarise (diamonds_by_color, mean_price = mean(price))
                                  
##Bar charts Code

install.packages("gridExtra")


library(gridExtra)


p1 <- ggplot(diamonds_mp_by_clarity, aes(x=clarity, y=mean_price)) + geom_bar(stat='identity')

p2 <- ggplot(diamonds_mp_by_color, aes(x=color, y=mean_price)) + geom_bar(stat='identity')

grid.arrange(p1,p2,ncol = 1)


###Mean Price By Cut 

diamonds_by_cut <- group_by(diamonds, cut)

diamonds_mp_by_cut <- summarise(diamonds_by_cut, mean_price = mean(price))
                                
p3 <- ggplot(diamonds_mp_by_cut, aes(x=cut, y=mean_price)) + 
                                  +     geom_bar(stat='identity')

grid.arrange(p1,p2,p3, ncol=1)

                                