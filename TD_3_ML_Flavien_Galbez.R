###############################################
## TD3 -- Machine Learning -- Flavien Galbez ##
###############################################
library(MASS)
library(corrplot)
## Question 1 :
SNA_Data <- read.csv("C:/Users/flavi/OneDrive/Bureau/Social_Network_Ads.csv")

## Quesiton 2 :
str(SNA_Data)
summary(SNA_Data)

SNA_Data$Gender[which(SNA_Data$Gender=="Male")] <- "1"
SNA_Data$Gender[which(SNA_Data$Gender=="Female")] <- "0"
SNA_Data$Gender <- as.numeric(SNA_Data$Gender)
cor(SNA_Data$Age,SNA_Data$EstimatedSalary)
#hist(SNA_Data$Gender,col="orange",main="Repartition des genres",xlab="Genre",ylab="Effectif")
#hist(SNA_Data$Age,col="brown",main="Repartition des ages",xlab="Ages",ylab="Effectif")
#hist(SNA_Data$EstimatedSalary,col="blue",main="Repartition des salaires estimes",xlab="Salaire estime",ylab="Effectif")
#hist(SNA_Data$Purchased,col="red",main="Repartition des achats",xlab="achat",ylab="Effectif")
M<-round(cor(SNA_Data),2)
corrplot(M)

## Question 3 :
library(caTools) # install it first in the console
set.seed(706888)
# we use the function set.seed() with the same seed number
# to randomly generate the same values, you already know that right? 
#and you know why we want to generate the same values, am I wrong? 
split = sample.split(SNA_Data$Purchased, SplitRatio = 0.75)
# here we chose the SplitRatio to 75% of the SNA_Data,
# and 25% for the test set.
training_set = subset(SNA_Data, split == TRUE)
# we use subset to split the SNA_Data
test_set = subset(SNA_Data, split == FALSE)

## Question 4 :
scale(training_set)
scale(test_set)
# 

## Question 5 :
model1<-glm(Purchased ~ Age,family = "binomial", data=training_set)
summary(model1)

## Question 6 :
# On choisit "binomial" car Purchased est soit egal à 0 ou 1 => Loi binomiale car distribuion de Bernoulli

## Question 7 :
#logistic(x)= 1/(1+e^(8.063-0.19x)) grâce aux valeurs de b1 et b0 obtenues dans le summary

## Question 8 :
# L'age est significatif car les Pr sont tres proches de 0 (inferieur a 0.05)

## Question 9 :
# La valeur du AIC modele est 256.11

## Question 10 :
plot(training_set$Age,training_set$Purchased, col='blue',main="Achat en fonction de l'age",xlab="Age",ylab="Achat")
curve(predict(model1,data.frame(Age=x),type="response"), col = 'red',add = TRUE)
#Autre façon
#library(ggplot2)
#ggplot(training_set, aes(x=Age, y=Purchased)) +
#  geom_point() +
#  stat_smooth(method="glm", method.args=list(family="binomial"), se=FALSE)

## Question 11 :
model2<-glm(Purchased ~ Age + EstimatedSalary ,family = "binomial", data=training_set)
summary(model2)

## Question 12 :
#Les predicateurs sont significatitifs car les Pr sont proches de 0

## Question 13 :
# Le AIC est de 205.78, il est inferieur au modele precedant. Ainsi ce modele est meilleur. Donc ajouter le salaire est interresant

## Question 14 :
y=test_set
prediction1<- predict(model2,data.frame(test_set))
prediction1

## Question 15 :
plot(prediction1)
prediction_estime1<-ifelse(prediction1<0.5,0,1)
prediction_estime1

compare<-ifelse(prediction_estime1 == test_set$Purchased,1,0)
compare
sum(compare)

## Question 16 :
M<-table(test_set$Purchased,prediction_estime1)
M

## Question 17 :
accuracy<-(M[1,1]+M[2,2])/(M[1,2]+M[2,1]+M[1,1]+M[2,2])
accuracy
specificity<-M[2,2]/(M[2,2]+M[1,2])
specificity
sensitivity<-M[1,1]/(M[1,1]+M[2,1])
sensitivity
precision<-M[1,1]/(M[1,1]+M[1,2])
precision

## Question 18 :
library(ROCR)
result<-prediction(test_set$Purchased,prediction_estime1)
AUC<-performance(result,"tpr","fpr")
#AUC du model 2
AUC
plot(AUC,col="red",main="ROC",xlab="Ratio de faux positif",ylab="Ratio de vrai positif")

## Question 19 :

prediction2<- predict(model1,data.frame(test_set))
prediction_estime2<-ifelse(prediction2<0.5,0,1)
result2<-prediction(test_set$Purchased,prediction_estime2)
#AUC du model 1
AUC2<-performance(result2,"tpr","fpr")
plot(AUC2,col="blue",add=TRUE)
