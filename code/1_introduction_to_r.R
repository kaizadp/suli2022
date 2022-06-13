## Session 1: Introduction to R
## June 3, 2022
## KFP

## check out the `introductoryR` repository for more info: https://github.com/kaizadp/introductoryR/wiki

## To run lines of code in a script, place the cursor on a line and click `Run` or use the CTRL+ENTER (CMD+RETURN) keys
## In the console, type the command and hit ENTER/RETURN.

# -------------------------------- #
# Basic mathematical operations
1+1
1+2

1-2
1*2
1/3
2^2  
2^3  

## Create a sequence of numbers
1:10
1:20

## Apply mathematical operations to entire sequences
(1:10) *2

# -------------------------------- #
# variables

## you can create variables with certain values
## use <- and -> operators to assign values, following the direction
## = and <- are interchangeable

x = 1
x <- 1
date <- 20220603

20220603 -> date 

# ^ these are all constant values

## to set current date (variable):
date2 = Sys.Date()


# -------------------------------- #

# reproducible workflows

## example 1: one variable
x = 25
(x + 1) * 2 + (3 * 4)

## by changing x and re-running the line above, we can get updated values for the formula


## example 2: two variables
variable1 <- 3
variable2 <- 4

variable1 * variable2


## the examples above were with numeric values
## we can also do this with character (non-numeric) variables

variable3 <- "hello"
variable4 <- 'hello'

## you can use "" or '', both give the same result
print(variable3)
print(variable4)


## example
your_name_here <- "Kaizad" # variable
print(paste("Hello", your_name_here))
print(paste("Hello", your_name_here, 5, "hahaha $$$$ % 121 34"))
# strings in quotations will be printed as is

# -------------------------------- #

# dataframes

## run the built-in `iris` dataset
View(iris)
str(iris)

## pull only Species values
iris$Species # use $ with column name
iris[,5] # pull the 5th column
iris[5,] # pull the 5th row

## there are additional built-in datasets, such as `cars` and `mtcars`
View(cars)
View(mtcars)
