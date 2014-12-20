# Practical Machine Learning

## Background  
Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. The data are collected from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. More information is available from the website here: http://groupware.les.inf.puc-rio.br/har (see the section on the Weight Lifting Exercise Dataset). 

In this project, machine learning techniques are employed to predict the the manners by the fitted model and data from accelerometers.

## Getting and Cleanning The Data
The training data for this project are available here:  
https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv

The test data are available here:  
https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv

Since (1) there are missing data in the raw data set; (2) the data in the type of character is not proper for fitting the model; (3) not all the information in the raw data is useful for fitting the model, the raw data need to be cleaned by the following steps before further analysis:  
  1. Only the variables that are available for all the observations are chosed for model fitting.
  2. Remove the identity, time and window information from the raw data set.
  3. Change all the data into **numetric** data type.

```r
library(caret)
```

```
## Loading required package: lattice
## Loading required package: ggplot2
```

```r
# Getting the data
data.set.train <- read.csv("pml-training.csv")
data.set.test <- read.csv("pml-testing.csv")

# Cleaning the data
## Only choose the variables that are available for all the observations.
# data.set.train
No.na.train <- apply(data.set.train,2,function(x) length(which(is.na(x)))) 
valid.var.train <- names(No.na.train)[which(No.na.train == 0)]
# data.set.test
No.na.test <- apply(data.set.test,2,function(x) length(which(is.na(x)))) 
valid.var.test <- names(No.na.test)[which(No.na.test == 0)]
valid.var <- c(intersect(valid.var.train,valid.var.test),"classe")

## Remove the identity, time and window information from the dataset.
data.set.train <- data.set.train[valid.var][-(1:7)]
data.set.test <- data.set.test[head(valid.var,-1)][-(1:7)]
## Change all the data into numetric type
for(i in 1:(ncol(data.set.train)-1)) data.set.train[,i] <- as.numeric(data.set.train[,i])
for(i in 1:(ncol(data.set.test)-1)) data.set.test[,i] <- as.numeric(data.set.test[,i])
```
The final data set includes 19622 observations of 53 variables. 

## Model Fitting

### Data Partition for Training and Testing
I order to check the prediction ability, the data is splited to two subset.
  1. A subset with 75% of observations is used for model fitting.
  2. A subset with 25% of observations is used for validation.


```r
# Model Fitting
set.seed(12345)
## Create the data partition for cross validation
inTraining <- createDataPartition(data.set.train$classe,p=0.75,list = FALSE)
training <- data.set.train[inTraining,]
testing <- data.set.train[-inTraining,]
data.frame(Train=nrow(training),Test=nrow(testing),row.names="Number of Observation")
```

```
##                       Train Test
## Number of Observation 14718 4904
```

### Pre-settings for the Model Fitting
In order to avoid over-fitting and achieve a better prediction ability, we use the cross-validation technique for fitting. In the following analysis, 4-fold cross-validation is employed.


```r
## Fit control: 4-fold cross validation
fitControl <- trainControl(method = "cv", 
                           number = 4,
                           repeats = 1,
                           horizon = 1,
                           verboseIter = FALSE,
                           returnData = FALSE,
                           returnResamp = "none",
                           savePredictions = TRUE,
                           classProbs = TRUE,
                           summaryFunction = defaultSummary,
                           selectionFunction = "best",
                           predictionBounds = rep(FALSE, FALSE),
                           seeds = NA,
                           allowParallel = TRUE)
```

### Fit the Random Forest Model

```r
# Fit the random forest model
fit.RF <- train(classe ~ ., data=training, method="rf", trControl = fitControl,ntree=300, 
                tuneGrid =data.frame(mtry=27) ,preProcess = NULL)
```

```
## Loading required package: randomForest
## randomForest 4.6-10
## Type rfNews() to see new features/changes/bug fixes.
```

```r
fit.RF
```

```
## Random Forest 
## 
## No pre-processing
## Resampling: Cross-Validated (4 fold) 
## 
## Summary of sample sizes: 11038, 11039, 11038, 11039 
## 
## Resampling results
## 
##   Accuracy   Kappa      Accuracy SD  Kappa SD   
##   0.9913712  0.9890838  0.001938424  0.002452631
## 
## Tuning parameter 'mtry' was held constant at a value of 27
## 
```

#### Fit Quality
We can check the model fitting quality by confution matrix, the fit quality is really good in this case, with an accuracy of 100%.


```r
# Confusion Matrix
cM.train.RF <- confusionMatrix(predict(fit.RF,training),training$classe)
cM.train.RF
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction    A    B    C    D    E
##          A 4185    0    0    0    0
##          B    0 2848    0    0    0
##          C    0    0 2567    0    0
##          D    0    0    0 2412    0
##          E    0    0    0    0 2706
## 
## Overall Statistics
##                                      
##                Accuracy : 1          
##                  95% CI : (0.9997, 1)
##     No Information Rate : 0.2843     
##     P-Value [Acc > NIR] : < 2.2e-16  
##                                      
##                   Kappa : 1          
##  Mcnemar's Test P-Value : NA         
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity            1.0000   1.0000   1.0000   1.0000   1.0000
## Specificity            1.0000   1.0000   1.0000   1.0000   1.0000
## Pos Pred Value         1.0000   1.0000   1.0000   1.0000   1.0000
## Neg Pred Value         1.0000   1.0000   1.0000   1.0000   1.0000
## Prevalence             0.2843   0.1935   0.1744   0.1639   0.1839
## Detection Rate         0.2843   0.1935   0.1744   0.1639   0.1839
## Detection Prevalence   0.2843   0.1935   0.1744   0.1639   0.1839
## Balanced Accuracy      1.0000   1.0000   1.0000   1.0000   1.0000
```

#### Model Validation
The out-of-sample accuracy for the model is very important. It stands for the predictability for a model. We can check the out-of-sample quality by confusion matrix of the testing data.


```r
cM.test.RF  <- confusionMatrix(predict(fit.RF,testing),testing$classe)
cM.test.RF
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction    A    B    C    D    E
##          A 1394    6    0    0    0
##          B    1  938    3    0    0
##          C    0    5  848   11    2
##          D    0    0    4  793    5
##          E    0    0    0    0  894
## 
## Overall Statistics
##                                           
##                Accuracy : 0.9925          
##                  95% CI : (0.9896, 0.9947)
##     No Information Rate : 0.2845          
##     P-Value [Acc > NIR] : < 2.2e-16       
##                                           
##                   Kappa : 0.9905          
##  Mcnemar's Test P-Value : NA              
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity            0.9993   0.9884   0.9918   0.9863   0.9922
## Specificity            0.9983   0.9990   0.9956   0.9978   1.0000
## Pos Pred Value         0.9957   0.9958   0.9792   0.9888   1.0000
## Neg Pred Value         0.9997   0.9972   0.9983   0.9973   0.9983
## Prevalence             0.2845   0.1935   0.1743   0.1639   0.1837
## Detection Rate         0.2843   0.1913   0.1729   0.1617   0.1823
## Detection Prevalence   0.2855   0.1921   0.1766   0.1635   0.1823
## Balanced Accuracy      0.9988   0.9937   0.9937   0.9921   0.9961
```

### Fit the C5.0Tree Model

```r
# Fit the C5.0Tree model
fit.C5T <- train(classe ~ ., data=training, method="C5.0Tree", trControl = fitControl,preProcess = NULL)
```

```
## Loading required package: C50
```

```r
fit.C5T
```

```
## Single C5.0 Tree 
## 
## No pre-processing
## Resampling: Cross-Validated (4 fold) 
## 
## Summary of sample sizes: 11039, 11039, 11038, 11038 
## 
## Resampling results
## 
##   Accuracy  Kappa      Accuracy SD  Kappa SD   
##   0.949042  0.9355656  0.005728361  0.007254393
## 
## 
```

#### Fit Quality
We can check the model fitting quality by confution matrix, the fit quality is really good in this case, with an accuracy of 99%.


```r
# Confusion Matrix
cM.train.C5T <- confusionMatrix(predict(fit.C5T,training),training$classe)
cM.train.C5T
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction    A    B    C    D    E
##          A 4161   12    4    6    3
##          B    8 2812   10    7    3
##          C    7   18 2548   16    8
##          D    5    2    3 2373    6
##          E    4    4    2   10 2686
## 
## Overall Statistics
##                                           
##                Accuracy : 0.9906          
##                  95% CI : (0.9889, 0.9921)
##     No Information Rate : 0.2843          
##     P-Value [Acc > NIR] : < 2e-16         
##                                           
##                   Kappa : 0.9881          
##  Mcnemar's Test P-Value : 0.02444         
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity            0.9943   0.9874   0.9926   0.9838   0.9926
## Specificity            0.9976   0.9976   0.9960   0.9987   0.9983
## Pos Pred Value         0.9940   0.9901   0.9811   0.9933   0.9926
## Neg Pred Value         0.9977   0.9970   0.9984   0.9968   0.9983
## Prevalence             0.2843   0.1935   0.1744   0.1639   0.1839
## Detection Rate         0.2827   0.1911   0.1731   0.1612   0.1825
## Detection Prevalence   0.2844   0.1930   0.1765   0.1623   0.1839
## Balanced Accuracy      0.9959   0.9925   0.9943   0.9913   0.9955
```

#### Model Validation
The out-of-sample accuracy for the model is very important. It stands for the predictability for a model. We can check the out-of-sample quality by confusion matrix of the testing data.


```r
cM.test.C5T <- confusionMatrix(predict(fit.C5T,testing),testing$classe)
cM.test.C5T
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction    A    B    C    D    E
##          A 1371   19    4    6    6
##          B   12  889   21    6    7
##          C    2   28  810   31   10
##          D    9   10   17  753    9
##          E    1    3    3    8  869
## 
## Overall Statistics
##                                           
##                Accuracy : 0.9568          
##                  95% CI : (0.9507, 0.9623)
##     No Information Rate : 0.2845          
##     P-Value [Acc > NIR] : < 2e-16         
##                                           
##                   Kappa : 0.9453          
##  Mcnemar's Test P-Value : 0.05615         
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity            0.9828   0.9368   0.9474   0.9366   0.9645
## Specificity            0.9900   0.9884   0.9825   0.9890   0.9963
## Pos Pred Value         0.9751   0.9508   0.9194   0.9436   0.9830
## Neg Pred Value         0.9931   0.9849   0.9888   0.9876   0.9920
## Prevalence             0.2845   0.1935   0.1743   0.1639   0.1837
## Detection Rate         0.2796   0.1813   0.1652   0.1535   0.1772
## Detection Prevalence   0.2867   0.1907   0.1796   0.1627   0.1803
## Balanced Accuracy      0.9864   0.9626   0.9649   0.9628   0.9804
```

### Conclusion
**The random forest model over-perform the C5.0Tree Model.** We choose Random Forest model for the prediction on the testing data set for assignment 2.

## Predict the Testing Data for Assignment 2 by Chosen Model

```r
model <- fit.RF
answer <- predict(model,newdata=data.set.test)
answer <- as.character(answer)
answer
```

```
##  [1] "B" "A" "B" "A" "A" "E" "D" "B" "A" "A" "B" "C" "B" "A" "E" "E" "A"
## [18] "B" "B" "B"
```


```r
pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}

pml_write_files(answer)
```


