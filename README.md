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
# OUT OF SAMPLE ERROR IS 6%. NOT SO BAD

# 14> did prediction on testing data

#> confrf
#Confusion Matrix and Statistics

          Reference
Prediction   A   B   C   D   E
         A 546   4   5   2   1
         B  13 343  17   1   6
         C   0   7 329   3   4
         D   2   1  30 287   2
         E   0   4   4   3 350

Overall Statistics
                                          
               Accuracy : 0.9445          
                 95% CI : (0.9334, 0.9542)
    No Information Rate : 0.2856          
    P-Value [Acc > NIR] : < 2.2e-16       
                                          
                  Kappa : 0.9298          
 Mcnemar's Test P-Value : 4.415e-05       

Statistics by Class:

                     Class: A Class: B Class: C Class: D Class: E
Sensitivity            0.9733   0.9554   0.8545   0.9696   0.9642
Specificity            0.9914   0.9769   0.9911   0.9790   0.9931
Pos Pred Value         0.9785   0.9026   0.9592   0.8913   0.9695
Neg Pred Value         0.9893   0.9899   0.9655   0.9945   0.9919
Prevalence             0.2856   0.1828   0.1960   0.1507   0.1848
Detection Rate         0.2780   0.1746   0.1675   0.1461   0.1782
Detection Prevalence   0.2841   0.1935   0.1746   0.1640   0.1838
Balanced Accuracy      0.9824   0.9662   0.9228   0.9743   0.9787
> testresult <-predict(myrf, testing)
> testresult
 [1] B A B A A E D B A A B C B A E E A B B B
Levels: A B C D E
# testresult
# [1] B A A A C B D D A A A C B A E E A B B B
#Levels: A B C D E
