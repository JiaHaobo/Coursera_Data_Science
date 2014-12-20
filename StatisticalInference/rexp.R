####
library(ggplot2)
# Setting parameters
lambda <- 0.2
n <- 40
N.sim <- 1000

set.seed(12345)
Sample.sim <- sapply(1:N.sim, function(x) mean(rexp(n,lambda)))
Med <- data.frame(Median=c(1/lambda, median(Sample.sim)), Type=c("Theoretical","Simulation"))

# 1. Show where the distribution is centered at and compare it to the theoretical center of the distribution.
qplot(x=Sample.sim,geom="histogram") + 
  geom_histogram(fill="skyblue3",colour="darkgrey") + 
  geom_vline(aes(xintercept=Median,colour=Type),data=Med,show_guide = T,size=0.8) +
  scale_colour_manual(values=c("red","black")) + 
  theme(legend.key.width=unit(0.5, "cm"),legend.key.size=unit(1, "cm"),
        legend.position=c(0.8,0.8),legend.background=NULL)


# 2. Show how variable it is and compare it to the theoretical variance of the distribution.
# Theoretical variance is 
sd(Sample.sim)

# 3. Show that the distribution is approximately normal.
qplot(sample=Sample.sim,stat="qq",distribution = qnorm) + 
  labs(title="Quantile-Quantile Plot: Sample v.s. Normal  Distribution",
       x= "Theoretical Normal Disribution",
       y= "Sample Distribution") + 
  geom_abline(slope=sd(Sample.sim),intercept=median(Sample.sim),size=0.8,colour="red")




