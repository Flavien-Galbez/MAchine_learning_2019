###############################################
## TD4 -- Machine Learning -- Flavien Galbez ##
###############################################

#Q1

# Loading the dataset.. I have putted it into a folder called "datasets"
dataset <- read.csv('http://www.mghassany.com/MLcourse/datasets/Social_Network_Ads.csv')

# Describing and Exploring the dataset

str(dataset) # to show the structure of the dataset. 
summary(dataset) # will show some statistics of every column. 
# Remark what it shows when the column is a numerical or categorical variable.
# Remark that it has no sense for the variable User.ID

boxplot(Age ~ Purchased, data=dataset, col = "blue", main="Boxplot Age ~ Purchased")
# You know what is a boxplot right? I will let you interpret it.
boxplot(EstimatedSalary ~ Purchased, data=dataset,col = "red",
        main="Boxplot EstimatedSalary ~ Purchased")
# Another boxplot

aov(EstimatedSalary ~Purchased, data=dataset)
# Anova test, but we need to show the summary of 
# it in order to see the p-value and to interpret.

summary(aov(EstimatedSalary ~Purchased, data=dataset))
# What do you conclude ? -> On peut conclure que le modèle est bon car le Pr est faible
# Now another anova test for the variable Age
summary(aov(Age ~Purchased, data=dataset))

# There is a categorical variable in the dataset, which is Gender.
# Of course we cannot show a boxplot of Gender and Purchased.
# But we can show a table, or a mosaic plot, both tell the same thing.
table(dataset$Gender,dataset$Purchased)
# Remark for the function table(), that
# in lines we have the first argument, and in columns we have the second argument.
# Don't forget this when you use table() to show a confusion matrix!
mosaicplot(~ Purchased + Gender, data=dataset,
           main = "MosaicPlot of two categorical variables: Puchased & Gender",
           color = 2:3, las = 1)

# since these 2 variables are categorical, we can apply
# a Chi-square test. The null hypothesis is the independance between
# these variables. You will notice that p-value = 0.4562 which is higher than 0.5
# so we cannot reject the null hypothesis. 
# conclusion: there is no dependance between Gender and Purchased (who
# said that women buy more than men? hah!)

chisq.test(dataset$Purchased, dataset$Gender)

# Let's say we want to remove the first two columns as we are not going to use them.
# But, we can in fact use a categorical variable as a predictor in logistic regression.
# It will treat it the same way as in regression. Check Appendix C.
# Try it by yourself if you would like to.
dataset = dataset[3:5]
str(dataset) # show the new structure of dataset


# splitting the dataset into training and testing sets
library(caTools)
set.seed(123) # CHANGE THE VALUE OF SEED. PUT YOUR STUDENT'S NUMBER INSTEAD OF 123.
split = sample.split(dataset$Purchased, SplitRatio = 0.75)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# scaling
# So here, we have two continuous predictors, Age and EstimatedSalary.
# There is a very big difference in their scales (units).
# That's why we scale them. But it is not always necessary.

training_set[-3] <- scale(training_set[-3]) #only first two columns
test_set[-3] <- scale(test_set[-3])

# Note that, we replace the columns of Age and EstimatedSalary in the training and
# test sets but their scaled versions. I noticed in a lot of reports that you scaled
# but you did not do the replacing.
# Note too that if you do it column by column you will have a problem because 
# it will replace the column by a matrix, you need to retransform it to a vector then.
# Last note, to call the columns Age and EstimatedSalary we can it like I did or 
# training_set[c(1,2)] or training_set[,c(1,2)] or training_set[,c("Age","EstimatedSalary")]


# logistic regression

classifier.logreg <- glm(Purchased ~ Age + EstimatedSalary , family = binomial, data=training_set)
classifier.logreg
summary(classifier.logreg)

# prediction
pred.glm = predict(classifier.logreg, newdata = test_set[,-3], type="response")
# Do not forget to put type response. 
# By the way, you know what you get when you do not put it, right?

# Now let's assign observations to classes with respect to the probabilities
pred.glm_0_1 = ifelse(pred.glm >= 0.5, 1,0)
# I created a new vector, because we need the probabilities later for the ROC curve.

# show some values of the vectors
head(pred.glm)
head(pred.glm_0_1)

# confusion matrix
cm = table(test_set[,3], pred.glm_0_1)
cm
# First line to store it into cm, second line to show the matrix! 

# You remember my note about table() function and the order of the arguments?
cm = table(pred.glm_0_1, test_set[,3])
cm

# You can show the confusion matrix in a mosaic plot by the way
mosaicplot(cm,col=sample(1:8,2)) # colors are random between 8 colors.

# ROC
require(ROCR)
score <- prediction(pred.glm,test_set[,3]) # we use the predicted probabilities not the 0 or 1
performance(score,"auc") # y.values
plot(performance(score,"tpr","fpr"),col="green")
abline(0,1,lty=8)


# Q2
pred.glm 
slope<- -coef(classifier.logreg)[2]/coef(classifier.logreg)[3]
intercept<- coef(classifier.logreg)[1]/coef(classifier.logreg)[3]
plot(test_set$Age,test_set$EstimatedSalary, xlab='Age',ylab='Estimated Salary')

#Q3

title(main = points(test_set[1:2],pch=21,bg=ifelse (pred.glm_0_1==1,'green4','red3')))
abline(intercept,slope,lwd=2)


#Q4
points(test_set[1:2],pch=21, bg= ifelse(test_set[3]==1, 'green4','red3'))
abline(intercept,slope, lwd=2)


#Q5

library(MASS)
classifier.lda <-lda(Purchased~Age+EstimatedSalary, data=training_set)

#Q6
classifier.lda

classifier.lda$prior
classifier.lda$means

#Q7
pred.lda<-predict(classifier.lda,test_set[-3])

str(pred.lda)

#Q8
cm.lda = table(test_set[,3],pred.lda$class)

acc1 <- (cm[1,1]+cm[2,2])/(cm[1,1]+cm[2,2]+cm[1,2]+cm[2,1])
acc1
acc2 <- (cm.lda[1,1]+cm.lda[2,2])/(cm.lda[1,1]+cm.lda[2,2]+cm.lda[1,2]+cm.lda[2,1])
acc2
dif <- acc1-acc2
dif

#Q9
# create a grid corresponding to the scales of Age and EstimatedSalary
# and fill this grid with lot of points
X1 = seq(min(training_set[, 1]) - 1, max(training_set[, 1]) + 1, by = 0.01)
X2 = seq(min(training_set[, 2]) - 1, max(training_set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
# Adapt the variable names
colnames(grid_set) = c('Age', 'EstimatedSalary')

# plot 'Estimated Salary' ~ 'Age'
plot(test_set[, 1:2],
     main = 'Decision Boundary LDA',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))

# color the plotted points with their real label (class)
points(test_set[1:2], pch = 21, bg = ifelse(test_set[, 3] == 1, 'green4', 'red3'))

# Make predictions on the points of the grid, this will take some time
pred_grid = predict(classifier.lda, newdata = grid_set)$class

# Separate the predictions by a contour
contour(X1, X2, matrix(as.numeric(pred_grid), length(X1), length(X2)), add = TRUE)

#Q11
# qda() is a function of library(MASS)
classifier.qda <- qda(Purchased~., data = training_set)
classifier.qda

#Q12
pred.qda<-predict(classifier.qda,test_set[-3])
cm.qda = table(test_set[,3],pred.qda$class)
cm.qda

acc3 <- (cm.qda[1,1]+cm.qda[2,2])/(cm.qda[1,1]+cm.qda[2,2]+cm.qda[1,2]+cm.qda[2,1])
acc3
acc2

#On obtient une meilleur precision

#Q13

X1 = seq(min(training_set[,1])-1,max(training_set[,1])+1, by = 0.01)
X2 = seq(min(training_set[,2])-1,max(training_set[,2])+1, by = 0.01)
grid_set = expand.grid(X1, X2)

colnames(grid_set)=c('Age','EstimatedSalary')

plot(test_set[,3],min='Decision')

plot(test_set[, -3],
     main = 'Decision Boundary LDA',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))

points(test_set, pch = 21, bg = ifelse(test_set[, 3] == 1, 'green4', 'red3'))


pred_grid = predict(classifier.qda, newdata = grid_set)$class

contour(X1, X2, matrix(as.numeric(pred_grid), length(X1), length(X2)), add = TRUE, lwd=2)


#Q14
# ROC
library(ROCR)


pred.glm = predict(classifier.logreg, newdata = test_set[,-3], type="response")

score.glm <- prediction(pred.glm,test_set[,3])
score.lda <- prediction(pred.lda$posterior[,2],test_set[,3])
score.qda <- prediction(pred.qda$posterior[,2],test_set[,3])


performance(score.glm,"auc")@y.values
performance(score.lda,"auc")@y.values
performance(score.qda,"auc")@y.values

plot(performance(score.glm,"tpr","fpr"),col="green")
plot(performance(score.lda,"tpr","fpr"),col="red",add=T)
plot(performance(score.qda,"tpr","fpr"),col="blue",add=T)
abline(0,1,lty=8)