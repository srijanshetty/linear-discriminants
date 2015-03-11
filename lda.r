setwd(".")

# We use MASS for the lda function
library(MASS)

# Merge the training_set and validation_set
new_training_set = rbind(training_set, validation_set)

# Classify using a LDA with equal priors
fit = lda(X22 ~ ., data = new_training_set, prior = c(1, 1, 1)/3)
plot(fit)

# QDA with equal priors
# fit = qda(class ~ ., data = new_training_set, prior = c(1/3, 1/3, 1/3))

# Compute the accuracy on the test set
count = 0
for (i in 1:nrow(test_set)) {
	if (predict(fit, test_set[i, -22])$class == test_set[i, 22]) {
		count = count + 1
	}
}

rate = count / nrow(test_set)
