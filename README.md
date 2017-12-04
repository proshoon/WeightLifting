# WeightLifting



# Overall approach

# 1> load training data from CSV file
# 2> Noticed lots of columns with NA and Div-by-zero
# 3> Loaded table with NA and div-by-zero cleaning
# 4> Removed empty columns
# 5> Removed first 7 columns as they didn't seem important

# 6> break training data into training and validation 
# 7> 75% training, 25% validation

# 8> First used RPART with 2-fold cross-validation
# 9> RPART yielded 0.50 accuracy; quite low
# 10> Since RPART had very low accuracy, Random Forest was attempted
# 11> THE 3/4 SPLIT (as mentioned above) didn't work for random forest because it was computationally very heavy. 
# 12> Was taking too much time. Hence, training was done on 1/10th of the data
#inTrain1 <- createDataPartition(training$classe, p = 1/10, list = FALSE)
#inTrain2 <- createDataPartition(training$classe, p = 1/10, list = FALSE)
#mytrain <- training[inTrain1,] #for model building
#myvalid <- training[inTrain2,] #for validation

# 13> created RF model; showed 94% accuracy on validation set
# now we are fairly confident that we have a good model

# 14> did prediction on testing data


# testresult
# [1] B A A A C B D D A A A C B A E E A B B B
#Levels: A B C D E
