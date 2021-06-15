############################################################
############################################################
######### TD5 Machine Learning : Flavien GALBEZ ############
############################################################
############################################################

#setwd("~/Cours ESILV/Annee 4/S7/Machine Learning")

library(MASS)
library(corrplot)
library(caTools)
#' Importing the Data set :
set.seed(706888)
dataset <- read.csv("C:/Users/flavi/OneDrive/Bureau/flow_dataset.csv")

dim(dataset)
summary(dataset)
str(dataset)
#' We can see the different data
#' In us case, we want to describe the number of travel following diferent parameters
#' We can already see that the relative data with the students and employees are unusable
#' We will not use the name of cities and their number so we remove them:

dataset$Origin <- NULL
dataset$Name_origin <- NULL
dataset$Destination <- NULL
dataset$Name_destination <- NULL

#' So as well many data are unusable and not interesting because they are null

dataset$Pros <- NULL
dataset$Students <- NULL
dataset$Pro_PT <- NULL
dataset$Pro_2R <- NULL
dataset$Pros_plus_Students <- NULL
dataset$Pro_PC <- NULL
dataset$Pro_soft <- NULL

dim(dataset)
summary(dataset)
str(dataset)

#' We explore and describe the data set
M<-round(cor(dataset),2)
corrplot(M)

#' 
set.seed(706888)
split = sample.split(dataset$Flow_OD, SplitRatio = 0.75)
#' We choose to split 75% of data
training_set = subset(dataset, split == TRUE)
training_set [,1:4] = scale(training_set)[,1:4]
# we use subset to split the SNA_Data
test_set = subset(dataset, split == FALSE)
test_set [,1:4] = scale(test_set)[,1:4]

dim(training_set)
summary(training_set)
str(training_set)
dim(test_set)
summary(test_set)
str(test_set)

plot(training_set$Pop_Or, training_set$Flow_OD)
plot(training_set$Pop_Dest, training_set$Flow_OD)
plot(training_set$Distance, training_set$Flow_OD)

cor(training_set$Pop_Or, training_set$Flow_OD)
cor(training_set$Pop_Dest, training_set$Flow_OD)
cor(training_set$Distance, training_set$Flow_OD)
#' The values are all close to 1, so there is no linear relationship (as we could imagine with the plots).
#' This is not a classification problem because the y is a countnuous value, it's a regretion problem
model1<-lm(Flow_OD ~ Distance,data = training_set)
model1
#'abline(model1, col = 'red')
summary(model1)

#' The predicators are significant because Pr(|>t|) is near to 0
#' The model is not as a whole sgnificant because Adjusted R-squared is near to 0 (even if p-value is near to 0)

model2<-lm(Flow_OD ~ .,data = training_set)
#'abline(model2, col = 'blue')
summary(model2)
#' The predicators are significant because Pr(|>t|) is near to 0
#' The model is not as a whole significant because Adjusted R-squared is near to 0 (even if p-value is near to 0)
#' model2 is better than model1 because R^2 improve

#' We find the mean square error
y <- test_set$Flow_OD
y_hat <- predict(model2, data.frame(test_set))

error <- y-y_hat
error_squared <- error^2
MSE <- mean(error_squared)
MSE

# My model don't fit at all, already seen with the Adjusted R-squared near to 0 and also now with this big MSE

plot(1/2+training_set$Distance, training_set$Flow_OD)
# we add 2 in order to avoid 0
training_set$Distance=1/(2+training_set$Distance)
test_set$Distance=1/(2+test_set$Distance)
model3<-lm(Flow_OD ~ .,data = training_set)
summary(model3)

#' The predicators are significant because Pr(|>t|) is near to 0
#' The model is now as a whole significant because Adjusted R-squared is near to 1 and p-value is near to 0)
#' model3 is better than model2 because R^2 improve
#' 
y <- test_set$Flow_OD
y_hat <- predict(model3, data.frame(test_set))

error <- y-y_hat
error_squared <- error^2
MSE <- mean(error_squared)
MSE
# The MSE is not very good but can be ok