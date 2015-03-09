# Load the generated waveforms
setwd(".")

# Mixtools will be used to compute parameters for Gaussian
library(mixtools)

# Fit to a mixture of Gaussians
w1_gaussian = mvnormalmixEM(as.matrix(w1_train), k = 3, epsilon = 0.1, maxit = 100, verb = TRUE)
# w2_gaussian = mvnormalmixEM(as.matrix(w2_train), k = 3, epsilon = 0.1, maxit = 100, verb = TRUE)
# w3_gaussian = mvnormalmixEM(as.matrix(w2_train), k = 3, epsilon = 0.1, maxit = 100, verb = TRUE)