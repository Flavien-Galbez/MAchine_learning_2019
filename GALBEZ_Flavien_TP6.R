
#' TD6 Machine Learning Flavien GALBEZ IBO 4


#' Q1
iris <- read.csv("iris.data")

#' Q2
par(mfrow=c(2,2))

boxplot(iris$sepal_length~iris$class,data=iris,xlab="class",ylab="sepal_length")
boxplot(iris$sepal_width~iris$class,data=iris,xlab="class",ylab="sepal_width")
boxplot(iris$petal_length~iris$class,data=iris,xlab="class",ylab="petal_length")
boxplot(iris$petal_width~iris$class,data=iris,xlab="class",ylab="petal_width")

#' Q3
# Let's use the ggplot2 library
# ggplot2 is the most advanced package for data visualization
# gg corresponds to The Grammar of Graphics.
library(ggplot2) #of course you must install it first if you don't have it already

# histogram of sepal_length
ggplot(iris, aes(x=sepal_length, fill=class)) +
  geom_histogram(binwidth=.2, alpha=.5)
# histogram of sepal_width
ggplot(iris, aes(x=sepal_width, fill=class)) +
  geom_histogram(binwidth=.2, alpha=.5)
# histogram of petal_length
ggplot(iris, aes(x=petal_length, fill=class)) +
  geom_histogram(binwidth=.2, alpha=.5)
# histogram of petal_width
ggplot(iris, aes(x=petal_width, fill=class)) +
  geom_histogram(binwidth=.2, alpha=.5)


#'Q1-5 factominr

library(factoextra)
library(FactoMineR)

pcairis2<-PCA(iris,quali.sup=5, graph=FALSE)
summary(pcairis2)


fviz_pca_var(pcairis2, col.var = "cos2", gradient.cols=c("#00AFBB","#E7BB00","#FC4E07"),repel=TRUE)

# We can see that every variable are well represented with cos near to 1 or -1

#Version 1
fviz_pca_ind(pcairis2, habillage="class")
#Version 2 with ellipses
fviz_pca_ind(pcairis2,habillage="class", addEllipses =TRUE)

#'We can see that the differet class are well represented by these parameters, however the ellipse of versicolor cross the ellipse of virginica

#Version 1
fviz_pca_biplot(pcairis2,habillage="class")
#Version 2 with ellipses
fviz_pca_biplot(pcairis2,habillage="class", addEllipses =TRUE)

#'We can observ that setosa has a sepal length, petal lenght and petal width lowless than the average.
#'We can observ that virginica has a sepal length, petal lenght and petal width hightless than the average.
#'We can observ that versicolor got a sepal width lowless than the average.

fviz_contrib(pcairis2, choice="var", axes = 1, top = 10)

#'Sepal length, petal lenght and petal width lowless are variable which influence more the axe 1

fviz_contrib(pcairis2, choice="var", axes = 2, top = 10)

#' Sepal width lowless are variable which influence more the axe 2