# Now in the second portion of the class, we're going to analyze the ToothGrowth data in the R datasets package. 
# Load the ToothGrowth data and perform some basic exploratory data analyses 
# Provide a basic summary of the data.
# Use confidence intervals and/or hypothesis tests to compare tooth growth by supp and dose. 
# (Only use the techniques from class, even if there's other approaches worth considering)
# State your conclusions and the assumptions needed for your conclusions. 

# Some criteria that you will be evaluated on
# Did you  perform an exploratory data analysis of at least a single plot or 
# table highlighting basic features of the data?
# Did the student perform some relevant confidence intervals and/or tests?
# Were the results of the tests and/or intervals interpreted in the context of the problem correctly? 
# Did the student describe the assumptions needed for their conclusions?

library(datasets)
data(ToothGrowth)
library(ggplot2)

# Summary of the data
# The Effect of Vitamin C on Tooth Growth in Guinea Pigs.
# The response is the length of odontoblasts (teeth) in each of 10 guinea pigs 
# at each of three dose levels of Vitamin C (0.5, 1, and 2 mg) 
# with each of two delivery methods (orange juice or ascorbic acid).

ggplot(data=ToothGrowth,mapping=aes(x=factor(dose),y=len,fill=factor(dose))) +
  geom_boxplot() + geom_jitter() + facet_wrap(~supp) +
  labs(title="ToothGrowth data: \n Length vs Dose, given type of supplement",
       x="Dose",y="Length",fill="Dose") +
  theme(title=element_text(face = "bold"),
        strip.text=element_text(face = "bold",colour = "blue"))

# According to the graph, we can see that probably:
# 1. The supplement type OJ (orange juice) is more efficiet than VC (Vitamin C), especially for small dose levels of supplement.
# 2. The tooth growth of pigs is positively affected by the dose levels of supplement for both supplement types.

# In order to verify our assumption, we try to do statistical hypothesis test. 
# First of all, we need to make some reasonal assumptions for our analysis:
# 1. The experimental targets (pigs) are independently trated.
# 2. We treat all the compared groups as independent groups with constant variance.

# Hypothesis 1: For dose level = 1, the mean of Length with supplement OJ is higher than that of VC.
df1 <- ToothGrowth[ToothGrowth$dose==1,]
t.test(len~supp,data=df1,alternative="greater",mu=0,
       paired = FALSE, var.equal = FALSE,
       conf.level = 0.95)

# Hypothesis 2: For group VC, the mean of Length with dose level 1 is higher than that with dose level 0.5.
df2 <- ToothGrowth[ToothGrowth$supp=="VC" & ToothGrowth$dose<2,]
t.test(len~dose,data=df2,alternative="less",mu=0,
       paired = FALSE, var.equal = FALSE,
       conf.level = 0.95)


