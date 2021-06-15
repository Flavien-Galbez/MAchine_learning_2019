############################################################
############################################################
######### TD7 Machine Learning : Flavien GALBEZ ############
############################################################
############################################################

# Q1
ligue1 <- read.csv("http://mghassany.com/MLcourse/datasets/ligue1_17_18.csv", row.names=1, sep=";")

# Q2
knitr::kable(ligue1[1:5,1:5])

# Q3

pointCards <-  ligue1[c(1,10)]
pointCards
# Q4

km<- kmeans(pointCards,centers=2, iter.max = 20)

# Q5

print(km)

# Q6
#'Cluster means:
#'  Points yellow.cards
#'1  82.00      71.2500
#'2  44.75      71.5625

# Q7
plot(x=pointCards$Points,y=pointCards$yellow.cards,col=km$cluster, pch=16,xlab="Points",ylab="yellow.cards")
points(km$center,col=1:2,pch=10,cex=5)
text(x=pointCards,labels=rownames(pointCards),col=km$cluster,pos=3,cex=0.7)

km3<- kmeans(pointCards,centers=3, iter.max = 20)

# Q5

print(km3)

# Q6
#'Cluster means:
#'  Points yellow.cards
#'1  82.00      71.2500
#'2  44.75      71.5625

# Q7
plot(x=pointCards$Points,y=pointCards$yellow.cards,col=km3$cluster, pch=16,xlab="Points",ylab="yellow.cards")
points(km3$center,col=1:3,pch=10,cex=5)
text(x=pointCards,labels=rownames(pointCards),col=km3$cluster,pos=3,cex=0.7)

km4<- kmeans(pointCards,centers=4, iter.max = 20)

# Q5

print(km)

# Q6
#'Cluster means:
#'  Points yellow.cards
#'1  82.00      71.2500
#'2  44.75      71.5625

# Q7
plot(x=pointCards$Points,y=pointCards$yellow.cards,col=km4$cluster, pch=16,xlab="Points",ylab="yellow.cards")
points(km4$center,col=1:4,pch=10,cex=5)
text(x=pointCards,labels=rownames(pointCards),col=km4$cluster,pos=3,cex=0.7)

# Question 8:

points(km$centers,col=1:3,pch=3,cex=3,lwd=3)
text (x=pointCards, labels=rownames(pointCards), col=km$cluster, pos=3, cex=0.75)

# Question 9:

set.seed(1234)
kmeans3 <- kmeans(pointCards,centers=3,iter.max = 20)
names(kmeans3)
kmeans3
kmeans3$cluster
plot(pointCards$Points,pointCards$yellow.cards,col=kmeans3$cluster,pch=19,cex=2)
points(kmeans3$centers,col=1:3,pch=3,cex=3,lwd=3)
text (x=pointCards, labels=rownames(pointCards), col=kmeans3$cluster, pos=3, cex=0.75)


set.seed(1234)
kmeans4 <- kmeans(pointCards,centers=4,iter.max = 20)
names(kmeans4)
kmeans4
kmeans4$cluster
plot(pointCards$Points,pointCards$yellow.cards,col=kmeans4$cluster,pch=19,cex=2)
points(kmeans4$centers,col=1:4,pch=3,cex=3,lwd=3)
text (x=pointCards, labels=rownames(pointCards), col=kmeans4$cluster, pos=3, cex=0.75)


# Question 10:

kmeans1
kmeans3
kmeans4

mydata <- pointCards
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15){
  wss[i] <- sum(kmeans(mydata,centers=i)$withinss)
}
plot(1:15, wss, type="b", xlab="Number of clusters", ylab="Withing")

mydata<- pointCards
wss<-(nrow(mydata)-1)*sum(apply(mydata,2,var))
wss

for (i in 2:15){
  wss[i]<-sum(apply(mydata,center=i)$withinss)
}

plot (1:15,wss,type="b", xlab="Number of clusters")


# Question 11:
for (i in 1:15){
  wss[i]<-kmeans(mydata,centers=i)$betweenss/kmeans(mydata,centers=1)$betweenss
}
plot()

# Question 12:
ligue1_scaled<-data.frame(scale(ligue1))

# Question 13:

km.ligue1 <- kmeans(ligue1,centers=3,nstart=20)
km.ligue1_scaled <- kmeans(ligue1_scaled,centers=3,nstart=20)

# Question 14:

table(km.ligue1$cluster)

table(km.ligue1_scaled$cluster)

# Question 15:

pcaligue1<-princomp(ligue1,cor=TRUE)

# Question 16:

require(factoextra)

fviz_pca(pcaligue1,repel=TRUE,col.var="#2E9FDF", col.ind="#696969")

fviz_cluster(km.ligue1,data=ligue1,palette=c("red","blue","green"),ggtheme =theme_minimal(),main="Clustering plot")


pcaligue1_scaled<-princomp(ligue1_scaled,cor=TRUE)

fviz_pca(pcaligue1_scaled,repel=TRUE,col.var="#2E9FDF", col.ind="#696969")

fviz_cluster(km.ligue1_scaled,data=ligue1_scaled,palette=c("red","blue","green"),ggtheme =theme_minimal(),main="Clustering plot")
