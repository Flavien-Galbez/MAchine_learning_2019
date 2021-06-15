###############################################
## TD2 -- Machine Learning -- Flavien Galbez ##
###############################################

#Question 1
library(MASS)

# Check the dimensions of the Boston dataset
dim(Boston)
#ans> [1] 506  14

#Question 2
# Split the data by using the first 400 observations as the training
# data and the remaining as the testing data
train <- 1:400
test <- -train

# Speficy that we are going to use only two variables (lstat and medv)

training_data <- Boston[train, ]
testing_data <- Boston[test, ]

#Question 3

cor(training_data$medv,training_data$age)
# La valeur absolue est pres de 1 donc les variables n'ont pas de relation lineaire

#Question 4
plot(training_data$age, training_data$medv)
model1<-lm(medv ~ age, data = training_data)
model1
abline(model1, col = 'red')

#Question 5
model2<-lm(medv ~ age + log(lstat) , data = training_data)
model2

#Question 6
summary(model2)

#Question 7
#Les predicateurs sont signifiant car les Pr(>|t|) sont tres faibles

#Question 8
#Le model est globalement signifiant car Adjusted R-squared est proche de 1 et p-value est proche de 0

#Question 9
model3<-lm(medv ~ .,data = training_data)
model3

summary(model3)

#Question 10
model4<-lm(medv ~ .-lstat+log(lstat),data = training_data)
model4
summary(model4)

#Question 11
#Le R2 s'ameliore, en effet il passe de 0.7249 a 0.7777

#Question 12
M<-round(cor(training_data),2)
M

#Question 13
library(corrplot)
corrplot(M,method="circle")

#Question 14
#tax et rad sont fortement correles car leur point est tres gros

#Question 15
model5<-lm(medv ~ .-tax-lstat+log(lstat),data = training_data)
model5
summary(model5)
#Le R2 diminue et le F a augmente

#Question 16
y <- testing_data$medv

# Compute the predicted value for this y (y hat)
y_hat <- predict(model5, data.frame(testing_data))

# Now we have both y and y_hat for our testing data. 
# let's find the mean square error
error <- y-y_hat
error_squared <- error^2
MSE <- mean(error_squared)
MSE
#Ans : 23,33963

#Question 17
str(training_data$chas)
sum(training_data$chas)
# Present 35 fois egal a 1

#Question 18
boxplot(medv~chas,data=training_data)

#Question 19
aggregate(formula=medv~chas, data=training_data, FUN=mean)

#Question 20
anovatest=aov(formula=medv~chas,data=training_data)
anovatest
summary(anovatest)
#Il y a une difference significative sur les prix si la riviere est proche ou nom

#Question 21
model6<- lm(medv ~ chas + crim, data=training_data)
model6
summary(model6)

#Le R2 est mauvais (proche de 0) donc la presence de la riviere ne donne pas d'informations sur le prix

#Question 22
# Il est moins signifiant en presence de plus de predicteurs

#Question 23
model7<- lm(medv ~ lstat*age, data=training_data)
model7
summary(model7)

#Question 24
model8 <- lm(medv ~ .*., data=training_data)
model8
summary(model8)

