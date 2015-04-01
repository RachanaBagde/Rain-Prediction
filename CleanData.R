
library(reshape2)
library(splitstackshape)
library(data.table)

train <- fread("train.csv")
test <- fread("test.csv")

# Split all the composite columns.

colsToSplit = colnames(train)[2:19]
split = cSplit(train,splitCols=colsToSplit,sep=" ",direction="long", fixed=FALSE, makeEqual = FALSE)

colsToSplit = colnames(test)[2:19]
split_test = cSplit(test,splitCols=colsToSplit,sep=" ",direction="long", fixed=FALSE, makeEqual = FALSE)

train <- split
test <- split_test
