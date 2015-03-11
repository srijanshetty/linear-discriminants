# Always generate the same data
set.seed(111)

# Number of samples
sample_size = 3000
training_size = 0.9 * sample_size
test_size = 0.1 * sample_size

###################################################################
# To generate the waveform data we use mlbench
# mlbench uses Breiman's original waveform source modified for R
library(mlbench)
waves = mlbench.waveform(sample_size)
data = data.frame(cbind(waves$x, waves$class))

# Create train, test and validation sets for the entire data
training_set = data[1:training_size, ]
test_set = data[-(1:training_size), ]
###################################################################

###################################################################
# Use LDA or QDA to classify
# We use MASS for the lda function
library(MASS)

# Classify using a LDA with equal priors
fit = lda(X22 ~ ., data = training_set, prior = c(1, 1, 1)/3)
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
###################################################################
