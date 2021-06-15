    ###############################################
    ## TD1 -- Machine Learning -- Flavien Galbez ##
    ###############################################

#setwd("~/Cours ESILV/Année 4/S7/Machine Learning")    
    
########################################################
################## R rappels ###########################
########################################################

x <- c(1,3,2,5)
x
#ans> [1] 1 3 2 5

x = c(1,6,2)
x
#ans> [1] 1 6 2

y = c(1,4,3)
length(x)
#ans> [1] 3

length(y)
#ans> [1] 3

x+y
#ans> [1]  2 10  5

ls()
#ans> [1] "x" "y"
rm(x)
ls()
#ans> [1] "y"


#### Vectors : ###

# A handy way of creating sequences is the operator :
# Sequence from 1 to 5
1:5
#ans> [1] 1 2 3 4 5

# Storing some vectors
vec <- c(-4.12, 0, 1.1, 1, 3, 4)
vec
#ans> [1] -4.12  0.00  1.10  1.00  3.00  4.00

# Entry-wise operations
vec + 1
#ans> [1] -3.12  1.00  2.10  2.00  4.00  5.00
vec^2
#ans> [1] 16.97  0.00  1.21  1.00  9.00 16.00

# If you want to access a position of a vector, use [position]
vec[6]
#ans> [1] 4

# You also can change elements
vec[2] <- -1
vec
#ans> [1] -4.12 -1.00  1.10  1.00  3.00  4.00

# If you want to access all the elements except a position, use [-position]
vec[-2]
#ans> [1] -4.12  1.10  1.00  3.00  4.00

# Also with vectors as indexes
vec[1:2]
#ans> [1] -4.12 -1.00

# And also
vec[-c(1, 2)]
#ans> [1] 1.1 1.0 3.0 4.0

#Ex :
x <-c(1,7,3,4)
x
y<-100:1
y

x[3]+y[4]
cos(x[3])+sin(y[4])*exp(-y[2])

x[3]<-0
y[2]<-(-1)
y
x[3]+y[4]
cos(x[3])+sin(y[4])*exp(-y[2])

z<-y[x+1]
z

### Matrice : ###

# A matrix is an array of vectors
A <- matrix(1:4, nrow = 2, ncol = 2)
A
#ans>      [,1] [,2]
#ans> [1,]    1    3
#ans> [2,]    2    4

# Another matrix
B <- matrix(1:4, nrow = 2, ncol = 2, byrow = TRUE)
B
#ans>      [,1] [,2]
#ans> [1,]    1    2
#ans> [2,]    3    4

# Binding by rows or columns
rbind(1:3, 4:6)
#ans>      [,1] [,2] [,3]
#ans> [1,]    1    2    3
#ans> [2,]    4    5    6
cbind(1:3, 4:6)
#ans>      [,1] [,2]
#ans> [1,]    1    4
#ans> [2,]    2    5
#ans> [3,]    3    6

# Entry-wise operations
A + 1
#ans>      [,1] [,2]
#ans> [1,]    2    4
#ans> [2,]    3    5
A * B
#ans>      [,1] [,2]
#ans> [1,]    1    6
#ans> [2,]    6   16

# Accessing elements
A[2, 1] # Element (2, 1)
#ans> [1] 2
A[1, ] # First row
#ans> [1] 1 3
A[, 2] # Second column
#ans> [1] 3 4

# A data frame is a matrix with column names
# Useful when you have multiple variables
myDf <- data.frame(var1 = 1:2, var2 = 3:4)
myDf
#ans>   var1 var2
#ans> 1    1    3
#ans> 2    2    4

# You can change names
names(myDf) <- c("newname1", "newname2")
myDf
#ans>   newname1 newname2
#ans> 1        1        3
#ans> 2        2        4

# The nice thing is that you can access variables by its name with the $ operator
myDf$newname1
#ans> [1] 1 2

# And create new variables also (it has to be of the same
# length as the rest of variables)
myDf$myNewVariable <- c(0, 1)
myDf
#ans>   newname1 newname2 myNewVariable
#ans> 1        1        3             0
#ans> 2        2        4             1

# A list is a collection of arbitrary variables
myList <- list(vec = vec, A = A, myDf = myDf)

# Access elements by names
myList$vec
#ans> [1] -4.12 -1.00  1.10  1.00  3.00  4.00
myList$A
#ans>      [,1] [,2]
#ans> [1,]    1    3
#ans> [2,]    2    4
myList$myDf
#ans>   newname1 newname2 myNewVariable
#ans> 1        1        3             0
#ans> 2        2        4             1

# Reveal the structure of an object
str(myList)
#ans> List of 3
#ans>  $ vec : num [1:6] -4.12 -1 1.1 1 3 4
#ans>  $ A   : int [1:2, 1:2] 1 2 3 4
#ans>  $ myDf:'data.frame': 2 obs. of  3 variables:
#ans>   ..$ newname1     : int [1:2] 1 2
#ans>   ..$ newname2     : int [1:2] 3 4
#ans>   ..$ myNewVariable: num [1:2] 0 1
str(myDf)
#ans> 'data.frame': 2 obs. of  3 variables:
#ans>  $ newname1     : int  1 2
#ans>  $ newname2     : int  3 4
#ans>  $ myNewVariable: num  0 1

# A less lengthy output
names(myList)
#ans> [1] "vec"  "A"    "myDf"


### Graphics : ###

x=rnorm(100)
# The rnorm() function generates a vector of random normal variables,
# rnorm() with first argument n the sample size. Each time we call this
# function, we will get a different answer.
y=rnorm(100)
plot(x,y)


# with titles
plot(x,y,xlab="this is the x-axis",ylab="this is the y-axis",
     main="Plot of X vs Y")


### Distributions : ###

# R allows to sample [r], compute density/probability mass [d],
# compute distribution function [p] and compute quantiles [q] for several
# continuous and discrete distributions. The format employed is [rdpq]name,
# where name stands for:
# - norm -> Normal
# - unif -> Uniform
# - exp -> Exponential
# - t -> Student's t
# - f -> Snedecor's F (Fisher)
# - chisq -> Chi squared
# - pois -> Poisson
# - binom -> Binomial
# More distributions: ?Distributions


# Sampling from a Normal - 100 random points from a N(0, 1)
rnorm(n = 10, mean = 0, sd = 1)
#ans>  [1]  0.593  0.789 -0.598  0.992  0.342 -1.260  0.320  0.115  0.375  0.276

# If you want to have always the same result, set the seed of the random number
# generator
set.seed(45678)
rnorm(n = 10, mean = 0, sd = 1)
#ans>  [1]  1.440 -0.720  0.671 -0.422  0.378 -1.667 -0.508  0.443 -1.799 -0.618

# Plotting the density of a N(0, 1) - the Gauss bell
x <- seq(-4, 4, l = 100)
y <- dnorm(x = x, mean = 0, sd = 1)
plot(x, y, type = "l")

# Plotting the distribution function of a N(0, 1)
x <- seq(-4, 4, l = 100)
y <- pnorm(q = x, mean = 0, sd = 1)
plot(x, y, type = "l", lwd = 3, main="The distribution function of a N(0, 1)")

# Computing the 95% quantile for a N(0, 1)
qnorm(p = 0.95, mean = 0, sd = 1)
#ans> [1] 1.64

# All distributions have the same syntax: rname(n,...), dname(x,...), dname(p,...)  
# and qname(p,...), but the parameters in ... change. Look them in ?Distributions
# For example, here is que same for the uniform distribution

# Sampling from a U(0, 1)
set.seed(45678)
runif(n = 10, min = 0, max = 1)
#ans>  [1] 0.9251 0.3340 0.2359 0.3366 0.7489 0.9327 0.3365 0.2246 0.6474 0.0808

# Plotting the density of a U(0, 1)
x <- seq(-2, 2, l = 100)
y <- dunif(x = x, min = 0, max = 1)
plot(x, y, type = "l")

# Computing the 95% quantile for a U(0, 1)
qunif(p = 0.95, min = 0, max = 1)
#ans> [1] 0.95

#Ex :

qf(p=0.90,df1=1,df2=5)
qf(p=0.95,df1=1,df2=5)
qf(p=0.99,df1=1,df2=5)

set.seed(45678)
rpois(n=100,lambda=5)

x<- seq(-4,4,l=100)
y<- dt(x=x,df=1)
plot(x, y, type = "l",ylim=c(0,0.4))
y1<- dt(x=x,df=5)
lines(x,y1,type="l",col="blue")
y2<- dt(x=x,df=10)
lines(x,y2,type="l",col="red")
y3<- dt(x=x,df=50)
lines(x,y3,type="l",col="green")
y4<- dt(x=x,df=100)
lines(x,y4,type="l",col="orange")


### Loading Data : ###

Auto=read.table("Auto.data",header=T,na.strings ="?")
# For this file we needed to tell R that the first row is the
# names of the variables.
# na.strings tells R that any time it sees a particular character
# or set of characters (such as a question mark), it should be
# treated as a missing element of the data matrix.

dim(Auto) # To see the dimensions of the data set
#ans> [1] 397   9
nrow(Auto) # To see the number of rows
#ans> [1] 397
ncol(Auto) # To see the number of columns
#ans> [1] 9
Auto[1:4,] # The first 4 rows of the data set
#ans>   mpg cylinders displacement horsepower weight acceleration year origin
#ans> 1  18         8          307        130   3504         12.0   70      1
#ans> 2  15         8          350        165   3693         11.5   70      1
#ans> 3  18         8          318        150   3436         11.0   70      1
#ans> 4  16         8          304        150   3433         12.0   70      1
#ans>                        name
#ans> 1 chevrolet chevelle malibu
#ans> 2         buick skylark 320
#ans> 3        plymouth satellite
#ans> 4             amc rebel sst

# Once the data are loaded correctly, we can use names()
# to check the variable names.
names(Auto)
#ans> [1] "mpg"          "cylinders"    "displacement" "horsepower"  
#ans> [5] "weight"       "acceleration" "year"         "origin"      
#ans> [9] "name"


#######################################################
################ Regression : #########################
#######################################################

# Load the dataset, when we load an .RData using load()
# function we do not attribute it to a name like we did
# when we used read.table() or when we use read.csv()

load("EU.RData")

# lm (for linear model) has the syntax: 
# lm(formula = response ~ predictor, data = data)
# The response is the y in the model. The predictor is x.
# For example (after loading the EU dataset)
mod <- lm(formula = Seats2011 ~ Population2010, data = EU)

# We have saved the linear model into mod, which now contains all the output of lm
# You can see it by typing
mod
#ans> 
#ans> Call:
#ans> lm(formula = Seats2011 ~ Population2010, data = EU)
#ans> 
#ans> Coefficients:
#ans>    (Intercept)  Population2010  
#ans>       7.91e+00        1.08e-06

# mod is indeed a list of objects whose names are
names(mod)
#ans>  [1] "coefficients"  "residuals"     "effects"       "rank"         
#ans>  [5] "fitted.values" "assign"        "qr"            "df.residual"  
#ans>  [9] "na.action"     "xlevels"       "call"          "terms"        
#ans> [13] "model"

# We can access these elements by $
# For example
mod$coefficients
#ans>    (Intercept) Population2010 
#ans>       7.91e+00       1.08e-06

# The residuals
mod$residuals
#ans>        Germany         France United Kingdom          Italy          Spain 
#ans>         2.8675        -3.7031        -1.7847         0.0139        -3.5084 
#ans>         Poland        Romania    Netherlands         Greece        Belgium 
#ans>         1.9272         1.9434         0.2142         1.8977         2.3994 
#ans>       Portugal Czech Republic        Hungary         Sweden        Austria 
#ans>         2.6175         2.7587         3.2898         2.0163         2.0575 
#ans>       Bulgaria        Denmark       Slovakia        Finland        Ireland 
#ans>         1.9328        -0.8790        -0.7606        -0.6813        -0.7284 
#ans>      Lithuania         Latvia       Slovenia        Estonia         Cyprus 
#ans>         0.4998        -1.3347        -2.1175        -3.3552        -2.7761 
#ans>     Luxembourg          Malta 
#ans>        -2.4514        -2.3553

# The fitted values
mod$fitted.values
#ans>        Germany         France United Kingdom          Italy          Spain 
#ans>          96.13          77.70          74.78          72.99          57.51 
#ans>         Poland        Romania    Netherlands         Greece        Belgium 
#ans>          49.07          31.06          25.79          20.10          19.60 
#ans>       Portugal Czech Republic        Hungary         Sweden        Austria 
#ans>          19.38          19.24          18.71          17.98          16.94 
#ans>       Bulgaria        Denmark       Slovakia        Finland        Ireland 
#ans>          16.07          13.88          13.76          13.68          12.73 
#ans>      Lithuania         Latvia       Slovenia        Estonia         Cyprus 
#ans>          11.50          10.33          10.12           9.36           8.78 
#ans>     Luxembourg          Malta 
#ans>           8.45           8.36

# Summary of the model
sumMod <- summary(mod)
sumMod
#ans> 
#ans> Call:
#ans> lm(formula = Seats2011 ~ Population2010, data = EU)
#ans> 
#ans> Residuals:
#ans>    Min     1Q Median     3Q    Max 
#ans> -3.703 -1.951  0.014  1.980  3.290 
#ans> 
#ans> Coefficients:
#ans>                Estimate Std. Error t value Pr(>|t|)    
#ans> (Intercept)    7.91e+00   5.66e-01    14.0  2.6e-13 ***
#ans> Population2010 1.08e-06   1.92e-08    56.3  < 2e-16 ***
#ans> ---
#ans> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#ans> 
#ans> Residual standard error: 2.29 on 25 degrees of freedom
#ans>   (1 observation deleted due to missingness)
#ans> Multiple R-squared:  0.992,   Adjusted R-squared:  0.992 
#ans> F-statistic: 3.17e+03 on 1 and 25 DF,  p-value: <2e-16

###### Prediction : ##################

# First, install the MASS package using the command: install.packages("MASS")

# load MASS package
library(MASS)

# Check the dimensions of the Boston dataset
dim(Boston)
#ans> [1] 506  14

# Split the data by using the first 400 observations as the training
# data and the remaining as the testing data
train = 1:400
test = -train

# Speficy that we are going to use only two variables (lstat and medv)
variables = which(names(Boston) ==c("lstat", "medv"))
training_data = Boston[train, variables]
testing_data = Boston[test, variables]

# Check the dimensions of the new dataset
dim(training_data)
#ans> [1] 400   2

# Scatterplot of lstat vs. medv
plot(training_data$lstat, training_data$medv)

model = lm(medv ~ log(lstat), data = training_data)
model
#ans> 
#ans> Call:
#ans> lm(formula = medv ~ log(lstat), data = training_data)
#ans> 
#ans> Coefficients:
#ans> (Intercept)   log(lstat)  
#ans>        51.8        -12.2

summary(model)
#ans> 
#ans> Call:
#ans> lm(formula = medv ~ log(lstat), data = training_data)
#ans> 
#ans> Residuals:
#ans>     Min      1Q  Median      3Q     Max 
#ans> -11.385  -3.908  -0.779   2.245  25.728 
#ans> 
#ans> Coefficients:
#ans>             Estimate Std. Error t value Pr(>|t|)    
#ans> (Intercept)   51.783      1.097    47.2   <2e-16 ***
#ans> log(lstat)   -12.203      0.472   -25.9   <2e-16 ***
#ans> ---
#ans> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#ans> 
#ans> Residual standard error: 5.6 on 398 degrees of freedom
#ans> Multiple R-squared:  0.627,   Adjusted R-squared:  0.626 
#ans> F-statistic:  669 on 1 and 398 DF,  p-value: <2e-16

names(model)
#ans>  [1] "coefficients"  "residuals"     "effects"       "rank"         
#ans>  [5] "fitted.values" "assign"        "qr"            "df.residual"  
#ans>  [9] "xlevels"       "call"          "terms"         "model"

model$coefficients
#ans> (Intercept)  log(lstat) 
#ans>        51.8       -12.2

confint(model, level = 0.95)
#ans>             2.5 % 97.5 %
#ans> (Intercept)  49.6   53.9
#ans> log(lstat)  -13.1  -11.3

# Scatterplot of lstat vs. medv
plot(log(training_data$lstat), training_data$medv)

# Add the regression line to the existing scatterplot
abline(model)

# Predict what is the median value of the house with lstat= 5%
predict(model, data.frame(lstat = c(5)))
#ans>    1 
#ans> 32.1

# Predict what is the median values of houses with lstat= 5%, 10%, and 15%
predict(model, data.frame(lstat = c(5,10,15), interval = "prediction"))
#ans>    1    2    3 
#ans> 32.1 23.7 18.7

# Save the testing median values for houses (testing y) in y
y = testing_data$medv

# Compute the predicted value for this y (y hat)
y_hat = predict(model, data.frame(lstat = testing_data$lstat))

# Now we have both y and y_hat for our testing data. 
# let's find the mean square error
error = y-y_hat
error_squared = error^2
MSE = mean(error_squared)
MSE
#ans> [1] 17.7