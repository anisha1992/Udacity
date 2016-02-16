# **Project 3**

install.packages("ggplot2")
install.packages("ggthemes")

##Creating the Histogram of Price, faceted by color and filled in/stacked by cut

ggplot(aes(x = price), data = diamonds) + geom_histogram(aes(fill = cut)) 
   + facet_wrap(~color) 
       + scale_fill_brewer("cut", type = 'qual', palette = "Set1")

###Observations
-Color D-G highest proportion of voume and also had the higher proportion of ideal cut
-ideal cut proportion is on the lower price range side. Is this because ideal cuts are hard to find in big sizes? 

####*Saving image*
ggsave('Histogrambypricecolorcut.png')


##Creating Scatterplot of Price vs Table

ggplot(aes(x = table, y = price), data = diamonds) 
   + geom_point(aes(color = cut), size = 3) 
       + scale_x_continuous(limits = c(50, 70))

###Observations
####Fair has most variability 

####*Saving Image*
ggsave('Histogrambypricecolorcut.png')

###Typical Table range for majority of ideal cut: 53 to 57
###Typical Table range for majority of premium cut: 58 to 62 



##Scatterplot of price vs volume, color the points by clarity
ggplot(aes(x = volume, y = price), data = subset(diamonds, volume < quantile(diamonds$volume, 0.99)))  + geom_point(aes(color = clarity)) + scale_y_log10() + scale_color_brewer(type = 'div')

###Observations
-Large volume affects price
-clarity and price are directly related

--------

##**Using Pseudo Facebook Data** 
  library(pseudo_facebook)

###Creating New Variable for proportion of friends initiated 
pseudo_facebook$prop_initiated = (pseudo_facebook$friendships_initiated) / (pseudo_facebook$friend_count)


###Line graph of median prop of friends initiated, color by year joined bucket
####First create the year joined variable and cut by bucket
pseudo_facebook$year_joined <- floor(2014-(pseudo_facebook$tenure/365))
pseudo_facebook$year_joined.bucket <- cut(pseudo_facebook$year_joined, breaks = c(2004, 2009, 2011, 2012, 2014))

###Creating the Median Line Graph
ggplot(aes(x = tenure, y = prop_initiated), data = pseudo_facebook) +
  geom_line(aes(color = year_joined.bucket), stat = 'summary', fun.y = median)

###Observations
-Users that have been on facebook for longer are less active. 
-Most noice in the 2004-2009 bucket -
-People who joined after 2012 intiating the most friendships - they are late to the game and also more active

###Smoothning the Previous Graph 
ggplot(aes(x = 20 * round(tenure / 20), y = prop_initiated), data = pseudo_facebook) +
  +   geom_line(aes(color = year_joined.bucket), stat = 'summary', fun.y = median)

###Mean Proportation Observations
with(subset(pseudo_facebook, pseudo_facebook$year_joined.bucket == "(2012,2014]"), table(year_joined.bucket))

with(subset(pseudo_facebook, year_joined.bucket == "(2012,2014]"), mean(prop_initiated, na.rm=TRUE))


### Scatter plot of Price/Carat Binned, Faceted, & Colored

ggplot(aes(x = cut, y = (price/carat)), data = diamonds) 
+ geom_jitter(aes(color = color), alpha = 0.5, position = position_jitter(h = 0)) 
+ facet_wrap(~ clarity) 
+ scale_color_brewer(type = 'div')

####*Saving Image*
ggsave('diamondplotfinal.png')

###Observations
-average price/cut increases with cut type 
-more variability in price per carat with higher cut.
-Generally color is valued higher at d and lower at J. But this is nott seen in 1st and 3rd cut level 