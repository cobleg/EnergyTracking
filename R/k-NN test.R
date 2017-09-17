# Try the k-NN package for machine learning

library(ggvis)
iris %>% ggvis(~Sepal.Length, ~Sepal.Width, fill = ~Species) %>% layer_points()
iris %>% ggvis(~Petal.Length, ~Petal.Width, fill = ~Species) %>% layer_points()
library(class)

# create a function to normalise the data
normalise <- function(x) {
  num <- x - min(x)
  denom <- max(x) - min(x)
  return (num/denom)
}
view(iris)
View(iris)
str(iris)
iris <- as.data.frame(iris)
iris.normalised <- as.data.frame(lapply(iris[1:4], normalise))
summary(iris.normalised)

set.seed(1234)
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.67, 0.33))
iris.training <- iris[ind==1, 1:4]
iris.test <- iris[ind==2, 1:4]
iris.trainLabels <- iris[ind==1,5]
iris.testLabels <- iris[ind==2,5]

iris_pred <- knn(train = iris.training, test = iris.test, cl = iris.trainLabels, k=3)


# compare actuals against predicted
compare.results <- data.frame(actual=iris[ind==2,5], predicted=iris_pred)

library(gmodels)
CrossTable(x = iris.testLabels, y = iris_pred, prop.chisq=FALSE)
