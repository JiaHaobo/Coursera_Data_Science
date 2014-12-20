library(caret)
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
## Change all the data into numetric type
for(i in 1:(ncol(data.set.train)-1)) data.set.train[,i] <- as.numeric(data.set.train[,i])


data.set.test <- data.set.test[head(valid.var,-1)][-(1:7)]
## Change all the data into numetric type
for(i in 1:(ncol(data.set.test)-1)) data.set.test[,i] <- as.numeric(data.set.test[,i])



# Model Fitting
set.seed(12345)
## Create the data partition for cross validation
inTraining <- createDataPartition(data.set.train$classe,p=0.75,list = FALSE)
training <- data.set.train[inTraining,]
testing <- data.set.train[-inTraining,]

## Fit control: 4-fold cross validation
fitControl <- trainControl(method = "cv", 
                           number = 4,
                           repeats = 1,
                           horizon = 1,
                           verboseIter = TRUE,
                           returnData = FALSE,
                           returnResamp = "none",
                           savePredictions = TRUE,
                           classProbs = TRUE,
                           summaryFunction = defaultSummary,
                           selectionFunction = "best",
                           predictionBounds = rep(FALSE, FALSE),
                           seeds = NA,
                           allowParallel = TRUE)

# Fit the random forest model
fit.RF <- train(classe ~ ., data=training, method="rf", trControl = fitControl,ntree=300, 
                tuneGrid =data.frame(mtry=27) ,preProcess = NULL)
cM.train.RF <- confusionMatrix(predict(fit.RF,training),training$classe)
cM.test.RF  <- confusionMatrix(predict(fit.RF,testing),testing$classe)

# Fit the C5.0Tree model
fit.C5T <- train(classe ~ ., data=training, method="C5.0Tree", trControl = fitControl,preProcess = NULL)
cM.train.C5T <- confusionMatrix(predict(fit.C5T,training),training$classe)
cM.test.C5T  <- confusionMatrix(predict(fit.C5T,testing),testing$classe)




