library(tidyverse)
#### 3.2 First Steps ####
# do cars with big engines use more fuel than cars with small engines?
ggplot(data = mpg,mapping = aes(x=displ, y=hwy)) +
  geom_point()

# 3.2.4 Excercises
#1. Run ggplot(data = mpg). What do you see?
ggplot(data=mpg) # a blank plot, gray

#2(a). How many rows are in mpg?
nrow(mpg) #234

#2(b). How many columns are in mpg?
ncol(mpg) #11

# 3. What does the drv variable describe?
?mpg #f = front-wheel drive, r = rear wheel drive, 4 = 4wd

# 4.. Make a scatterplot of hwy vs cyl.
ggplot(mpg, aes(y=hwy, x=cyl)) +
  geom_point()

# 5. What happens if you make a scatterplot of class vs drv? Why is the plot not useful?
ggplot(mpg, aes(x=class, y=drv)) +
  geom_point() #it's not useful becuase it doesn't give any useful information

#### 3.3 Aesthestics ####
ggplot(mpg, aes(y=hwy, x=displ)) +
         geom_point(aes(color=class))

ggplot(mpg, aes(y=hwy, x=displ)) +
  geom_point(aes(color=class, size=class))

#all the points are blue
ggplot(mpg)+
  geom_point(mapping=aes(y=hwy, x=displ), color="blue")

#3.3.1 Exercises

#1. What's wrong with this code? Why aren't the points blue?
ggplot(data = mpg) + 
geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))

#Because the aesthetics needs to go outside of the aes function call:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

#2 Which variables in mpg are categorical? Which variables are continuous?
str(mpg)
# Categorical: Manufacturer, Model, Trans, Drv, Fl, Class
# Continuous: displ, year, cyl, cty, hwy

#3 Map a continuous variable to color, size, and shape. How do these aesthetics behave differently for categorical vs. continuous variables?

ggplot(mpg) +
  geom_point(aes(x=displ, y=cty), color=mpg$hwy) #continuous variables

ggplot(mpg) +
  geom_point(aes(x=displ, y=cty), size=mpg$hwy) #continuous variables

ggplot(mpg) +
  geom_point(aes(x=displ, y=cty), shape=mpg$hwy) #continuous variables

ggplot(mpg) +
  geom_point(aes(x=displ, y=cty), color=mpg$trans) # R says these are invalid colors,shapes, sizes

#4 What happens if you map the same variable to multiple aesthetics?
ggplot(mpg) +
  geom_point(aes(x=mpg$displ, y=mpg$cty), color=mpg$displ, shape=mpg$displ, size=mpg$displ)
# it does work, but the columns need to be called directly with a $

#5. What does the stroke aesthetic do? What shapes does it work with? (Hint: use ?geom_point)
ggplot(mpg) +
  geom_point(aes(x=mpg$displ, y=mpg$cty), stroke=mpg$cty)
# it adds stroke to the shape - it is the outline around a specific shape. The opposite of fill.

#6 What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ < 5)?
ggplot(mpg) +
  geom_point(aes(x=mpg$displ, y=mpg$cty), color=mpg$cyl==4)
#R gives a response that this is invalid.

#### 3.5 Facets ####
# when doing facet on one factor use facet_wrap
p <- ggplot(mpg) +
  geom_point(aes(x=mpg$displ, y=mpg$cty)) +
  facet_wrap(~class, nrow=2)
p

# when using 2 factors, use facet_grid
p <- ggplot(mpg) +
  geom_point(aes(x=mpg$displ, y=mpg$cty)) +
  facet_grid(year~class)
p

#3.5.1 Exercises
#1. What happens if you facet on a continuous variable?
p <- ggplot(mpg) +
  geom_point(aes(x=mpg$displ, y=mpg$cty)) +
  facet_wrap(~cty, nrow=4)
p

#2 What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they relate to this plot?
p <- ggplot(mpg) +
  geom_point(aes(x=mpg$displ, y=mpg$cty)) +
  facet_grid(drv~cyl)
p
# The empty cells indiate there is no data that matches those conditions (e.g. no cars have 5 cylinders)

#3 What plots does the following code make? What does . do?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv~.) # facets on the drv variable

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl) # facets on the number of cylinders

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(~cyl)

#4. Take the first faceted plot in this section:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
#What are the advantages to using faceting instead of the colour aesthetic?
# the results are much easier to see, the plot is not "busy"

#What are the disadvantages?
# it is more difficult to compare in some situations

#How might the balance change if you had a larger dataset?
# graphs might be more crowded, might be more difficult to sort out

#Read ?facet_wrap. What does nrow do?
# control the number of rows in the plot
?facet_wrap
#What does ncol do?
# control the number of columns in the plot
#What other options control the layout of the individual panels?
# Why doesn’t facet_grid() have nrow and ncol arguments? Because they are determined by the functon

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(~ class)

#When using facet_grid() you should usually put the variable with more unique levels in the columns. Why?
# fewer column names than column row numbers (usually!)

#### 3.6 Geometric Objects ####
# using dots:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy)) # note geom_smooth

ggplot(data=mpg) +
  geom_smooth(mapping = aes(x=displ, y=cty, linetype=drv, color=drv)) +
  geom_point(mapping = aes(x=displ, y=cty, color=drv))

# let's look at grouping:
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy)) # base graph

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv)) # group by drive

ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y=hwy, color=drv),
              show.legend = FALSE)

# to display multiple geoms in one plot, use multiple geoms!
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data=mpg,mapping = aes(x=displ, y=cty)) +
  geom_point(mapping = aes(color=class)) +
  geom_smooth()

mpg$class=as.factor(mpg$class)
str(mpg)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(filter(mpg, class=="2seater")) # filter for a specific variable!!

# 3.6.1 Exercises

#What geom would you use to draw a line chart? geom_line()
#A boxplot? geom_box()
#A histogram? geom_hist()
#An area chart? geom_area()

#line plot
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_line(mapping = aes(x=displ, y=hwy))

#boxplot
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_boxplot()

#histogram
ggplot(data = mpg, mapping = aes(x=hwy)) + 
  geom_histogram()

# area cheart
ggplot(data = mpg, mapping = aes(x=hwy, y=displ)) + 
  geom_area()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# What does show.legend = FALSE do? # it shows the legend for the graph
# What happens if you remove it? The graph is the same, but no legend
#  Why do you think I used it earlier in the chapter? to show which variables are being mapped

#What does the se argument to geom_smooth() do?
# it mapes the standard error of the results (line, etc.)

# Will these two graphs look different? Why/why not?
# same, they are two different ways of plotting the same results

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()


ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# reproduce these six graphs
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy)) +
  geom_smooth(mapping=aes(x=displ, y=hwy),se=FALSE)

ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy)) +
  geom_smooth(mapping=aes(x=displ, y=hwy, group=drv),se=FALSE)

ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy, color=drv)) +
  geom_smooth(mapping=aes(x=displ, y=hwy),se=FALSE)

ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy, color=drv)) +
  geom_smooth(mapping=aes(x=displ, y=hwy, group=drv, linetype=drv),se=FALSE)
