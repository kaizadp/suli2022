## Session 2: Working directories, workflows, packages, and {ggplot2}
## June 16, 2022
## KFP


# -------------------------------- #

# working directory


## the working directory is the folder on your computer where R will look for files
## and export files to
## all files being used in the script *must* be in the working directory, or R will not be able to import them.


## you can access the current working directory using:
getwd()

## DO NOT SET THE WORKING DIRECTORY USING A HARD-CODED FILEPATH. 
## THAT IS A HORRIBLE WAY TO CODE.


## instead, create an Rproject for each of your projects
## Rprojects allow you to organize all your files and scripts within a single WD, 
## and will also allow you to open and run multiple projects simultaneously.


# -------------------------------- #

# packages

## packages are add-ons to R that allow us to perform additional functions
## packages can serve different purposes - statistical tests, data cleaning, graphs, etc.

## some packages are available on CRAN (the official R network), and some are available on GitHub.
## check out how to download and install packages here: https://github.com/kaizadp/introductoryR/wiki/packages

## you will need to install the packages only once, when you first install R/RStudio, or when you update R/RStudio.
## after that, you only need to load the packages using `library()`

# -------------------------------- #

# ggplot

# install.packages("ggplot2")
library(ggplot2)

## using {palmerpenguins} package to load a fun dataset
# install.packages("palmerpenguins")
library(palmerpenguins)

View(penguins)
names(penguins)

## more info here: https://github.com/kaizadp/introductoryR/wiki/ggplot2%3A-the-Grammar-of-Graphics

## basic scatterplot

ggplot(
  data = penguins, # set the source dataset
  aes(x = body_mass_g, y = bill_length_mm))+ # set x and y axes within the aesthetic
  geom_point() # add a geometry. in this case, geom_point --> scatterplot

ggplot(
  data = penguins,
  aes(x = island, y = bill_length_mm))+
  geom_point()

## using geom_jitter instead of geom_point
## jitter adds a small random noise along the x axis (in this case), so you can see all the points clearly
ggplot(data = penguins, 
       aes(x = island, y = bill_length_mm)) + 
  geom_jitter(width = 0.2)
