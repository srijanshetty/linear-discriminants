setwd(".")

# We use MASS for the lda function
library(MASS)

# Merege the training and validation sets together
w1_train = rbind(w1_train, w1_validation)
w2_train = rbind(w2_train, w2_validation)
w3_train = rbind(w3_train, w3_validation)

# Create a new training set for LDA and QDA
W1 = cbind(w1_train, class = rep(1, nrow(w1_train)))
W2 = cbind(w2_train, class = rep(2, nrow(w2_train)))
W3 = cbind(w3_train, class = rep(3, nrow(w3_train)))
training_set = rbind(W1, W2, W3)

# Classify using a LDA with equal priors
lfit = qda(class ~ ., data = training_set, prior = c(1/3, 1/3, 1/3))

# Compute the accuracy on the test set
count = 0
for (i in 1:nrow(w1_test)) {
	if (predict(lfit, w1_test[i, ])$class == 1) {
    count = count + 1
	}
}

for (i in 1:nrow(w2_test)) {
  if (predict(lfit, w2_test[i, ])$class == 2) {
    count = count + 1
  }
}

for (i in 1:nrow(w3_test)) {
  if (predict(lfit, w3_test[i, ])$class == 3) {
    count = count + 1
  }
}

qrate = count / (nrow(w1_test) + nrow(w2_test) + nrow(w3_test))
