# Load the generated waveforms
setwd(".")

# Mixtools will be used to compute parameters for Gaussian
library(mixtools)

# We fit a mixture of three gaussians to each of the classes w1, w2, w3 using EM method
# w1_gaussian = mvnormalmixEM(as.matrix(w1_train), k = 3, epsilon = 0.1, maxit = 100, verb = TRUE)
# w2_gaussian = mvnormalmixEM(as.matrix(w2_train), k = 3, epsilon = 0.1, maxit = 100, verb = TRUE)
# w3_gaussian = mvnormalmixEM(as.matrix(w3_train), k = 3, epsilon = 0.1, maxit = 100, verb = TRUE)

## Here we fit a gaussian to each of the classes w1, w2, w3 using a systematic approach
covar = var(training_set[, 1:21])
mu = apply(training_set[, 1:21], 2, mean)
variance = apply(training_set[, 1:21], 2, var)

# The maximum posssible error is equal to number of elements in validation
min_count = nrow(validation_set)

# The optimum values of mus
w1_mu_prime = w2_mu_prime = w3_mu_prime = mu

# Iterate over all possible values
for (c1 in seq(from = 0, to = 1, by = 0.1)) {
	w1_mu = mu + c1 * variance
	for (c2 in seq(from = 0, to = 1, by = 0.1)) {
		w2_mu = mu + c2 * variance
		for (c3 in seq(from = 0, to = 1, by = 0.1)) {
			w3_mu = mu + c3 * variance

			# Compute the classification error
      count = 0
      for (i in 1:nrow(validation_set)) {
        # Consider the ith vector in the validation_set
        vec = as.matrix(validation_set[i, ])

        # Compute densities for each of the gaussians
        w1_density = dmvnorm(vec[1:21], mu = w1_mu, sigma = covar)
				w2_density = dmvnorm(vec[1:21], mu = w2_mu, sigma = covar)
				w3_density = dmvnorm(vec[1:21], mu = w3_mu, sigma = covar)

				# Compute the class using densities
        category = 0
				if (w1_density >= w2_density && w1_density >= w3_density) {
				  category = 1
				} else if (w2_density >= w1_density && w2_density >= w3_density) {
					category = 2
				} else {
					category = 3
				}

				# If wrongly labelled then we count it as an error
        if (category != vec[22]) {
          count = count + 1
				}
      }

      # If the error is smaller than the current error
      if (count < min_count) {
        min_count = count
        w1_mu_prime = w1_mu
        w2_mu_prime = w2_mu
        w3_mu_prime = w3_mu
      }
		}
	}
}

