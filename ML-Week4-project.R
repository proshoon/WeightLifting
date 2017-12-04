


#load training data
#training <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv")
#look at training data
#str(training)  #lots of columns with NA and DIV-by-0 and empty value


#read table again (cleanly) 
training <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv", na.strings = c("NA", "#DIV/0!", ""))


#160 variables. may of them can be removed because they're empty
training <- training[, colSums(is.na(training)) == 0]  #removed lots of columns ; 160->60


#some variables are not important -- x, user name, 3 timestamps, 2 windows; remove them; basically first 7 columns
training <- training[, -c(1:7)]  #first 7 columns removed


#break training data into training and validation
set.seed(9999)  #for re-creating the data
inTrain <- createDataPartition(training$classe, p = 3/4, list = FALSE)
mytrain <- training[inTrain,] #for model building
myvalid <- training[-inTrain,] #for validation




CVcontrol <- trainControl(method = "cv", number = 2) #2-fold cross-validation, 10 was proved too computationally heavy for RF
myrpart <- train(classe ~ ., data = mytrain, method = "rpart", trControl = CVcontrol) #rpart applied
predrpart <- predict(myrpart,myvalid)
confrpart <- confusionMatrix(myvalid$classe, predrpart)
#               Accuracy : 0.4955    quite low   

#Since RPART had very low accuracy, Random Forest was attempted
# THE 3/4 SPLIT (as mentioned above) didn't work because it was computationally very heavy. 
#Was taking too much time. Hence, training was done on 1/10th of the data
#inTrain1 <- createDataPartition(training$classe, p = 1/10, list = FALSE)
#inTrain2 <- createDataPartition(training$classe, p = 1/10, list = FALSE)
#mytrain <- training[inTrain1,] #for model building
#myvalid <- training[inTrain2,] #for validation

myrf <- train(classe ~ ., data = mytrain, method = "rf", trControl = CVcontrol) #rf applied
predrf <- predict (myrf, myvalid)
confrf <- confusionMatrix (myvalid$classe, predrf)
#confrf showed 94% accuracy on validation set
# now we are fairly confident that we have a good model


#process testing data like we processed training+validation data
testing <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv", na.strings = c("NA", "#DIV/0!", ""))
#160 variables. may of them can be removed because they're empty
testing <- testing[, colSums(is.na(testing)) == 0]  #removed lots of columns ; 160->60
#some variables are not important -- x, user name, 3 timestamps, 2 windows; remove them; basically first 7 columns
testing <- testing[, -c(1:7)]  #first 7 columns removed

testresult <-predict(myrf, testing)


# testresult
# [1] B A A A C B D D A A A C B A E E A B B B
#Levels: A B C D E
