#Question 1

data1=read.csv('https://www.mghassany.com/MLcourse/datasets/data1.csv')
data2=read.csv('https://www.mghassany.com/MLcourse/datasets/data2.csv')


#Question 2

km1<-kmeans(data1[,1:2],4)
km2<-kmeans(data2[,1:2],4)
#par(mfrow=c(1,2))

plot(data1[,1:2],pch=21,bg=km1$cluster)
plot(data2[,1:2],pch=21,bg=km2$cluster)


#Question 3

library(mclust)

Gmm2=Mclust(data2[,1:2])

summary(Gmm2)

plot(Gmm2, what="classification")
plot(Gmm2, what="uncertainty")


plot(Gmm2, what = "BIC")







library(EMCluster)
ret <- init.EM(data2[,1:2],nclass = 4,min.n.iter = 100,method = "em.EM")
ret.new <- assign.class(data2[,1:2],ret,return.all = TRUE)
plot(data2[,1:2],col=ret.new$class)

































