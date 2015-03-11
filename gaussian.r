# Load the generated waveforms
setwd(".")

# Mixtools will be used to compute parameters for Gaussian
library(mixtools)

# We fit a mixture of three gaussians to each of the classes w1, w2, w3 using EM method
# w1_gaussian = mvnormalmixEM(as.matrix(w1_train), k = 3, epsilon = 0.1, maxit = 100, verb = TRUE)
# w2_gaussian = mvnormalmixEM(as.matrix(w2_train), k = 3, epsilon = 0.1, maxit = 100, verb = TRUE)
# w3_gaussian = mvnormalmixEM(as.matrix(w3_train), k = 3, epsilon = 0.1, maxit = 100, verb = TRUE)

## Here we fit a gaussian to each of the classes w1, w2, w3 using a systematic approach
sigma = var(training_set)
mu = apply(training_set, 2, mean)
variance = apply(training_set, 2, var)

# Initially all the means are the same
w1_mu = w2_mu = w3_mu = mu

for (c1 in seq(from = 0, to = 1, by = 0.1)) {
	for (c2 in seq(from = 0, to = 1, by = 0.1)) {
		for (c3 in seq(from = 0, to = 1, by = 0.1)) {
		}
	}
}

