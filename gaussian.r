# Always generate the same data
set.seed(111)

# Number of samples
sample_size = 3000
iteration_count = 200
training_size = 0.8 * sample_size
validation_size = 0.1 * sample_size
test_size = 0.1 * sample_size

###################################################################
# To generate the waveform data we use mlbench
# mlbench uses Breiman's original waveform source modified for R
library(mlbench)
waves = mlbench.waveform(sample_size)
data = data.frame(cbind(waves$x, waves$class))

# Create train, test and validation sets for the entire data
training_set = data[1:training_size, ]
validation_set = data[(training_size + 1):(training_size + validation_size), ]
test_set = data[(training_size + validation_size + 1):(training_size + validation_size + test_size), ]
###################################################################

###################################################################
# Compute parameters for w1
w1_covar = var(training_set[training_set$X22 == 1, 1:21])
w1_mean = apply(training_set[training_set$X22 == 1, 1:21], 2, mean)
w1_variance = apply(training_set[training_set$X22 == 1, 1:21], 2, var)
###################################################################

###################################################################
# Compute parameters for w2
w2_covar = var(training_set[training_set$X22 == 2, 1:21])
w2_mean = apply(training_set[training_set$X22 == 2, 1:21], 2, mean)
w2_variance = apply(training_set[training_set$X22 == 2, 1:21], 2, var)
###################################################################

###################################################################
# Compute parameters for w3
w3_covar = var(training_set[training_set$X22 == 3, 1:21])
w3_mean = apply(training_set[training_set$X22 == 3, 1:21], 2, mean)
w3_variance = apply(training_set[training_set$X22 == 3, 1:21], 2, var)
###################################################################

###################################################################
# Mixtools will be used to compute parameters for Gaussian
library(mixtools)

# The maximum posssible error is equal to number of elements in validation
min_error = nrow(validation_set)

# We will sample 9 numbers with replacement from the following list
c_values = seq(from = 0, to = 2, by = 0.1)

# The best means
w11_mean_p = w12_mean_p = w13_mean_p = w21_mean_p = w22_mean_p = w23_mean_p = w31_mean_p = w32_mean_p = w33_mean_p = rep(0, 3)

# Now we randomly sample the
for (i in 1:iteration_count) {
	print (i)

	# Sample 9 random values from the set with replacement
	c_sample = c_values[sample(1:length(c_values), 9, replace = TRUE)]

	# Compute the classification error
	error = 0
	for (i in 1:nrow(validation_set)) {
		# Consider the ith vector in the validation_set
		vec = as.matrix(validation_set[i, ])

		# Compute density for w1
		w11_density = dmvnorm(vec[1:21], mu = w1_mean + c_sample[1] * w1_var, sigma = w1_covar)
		w12_density = dmvnorm(vec[1:21], mu = w1_mean + c_sample[2] * w1_var, sigma = w1_covar)
		w13_density = dmvnorm(vec[1:21], mu = w1_mean + c_sample[3] * w1_var, sigma = w1_covar)
		# We assume that each of the gaussians has equal probability
		w1_density = w11_density + w12_density + w13_density

		# Compute density for w2
		w21_density = dmvnorm(vec[1:21], mu = w2_mean + c_sample[4] * w2_var, sigma = w2_covar)
		w22_density = dmvnorm(vec[1:21], mu = w2_mean + c_sample[5] * w2_var, sigma = w2_covar)
		w23_density = dmvnorm(vec[1:21], mu = w2_mean + c_sample[6] * w2_var, sigma = w2_covar)
		# We assume that each of the gaussians has equal probability
		w2_density = w21_density + w22_density + w23_density

		# Compute density for w3
		w31_density = dmvnorm(vec[1:21], mu = w3_mean + c_sample[7] * w3_var, sigma = w3_covar)
		w32_density = dmvnorm(vec[1:21], mu = w3_mean + c_sample[8] * w3_var, sigma = w3_covar)
		w33_density = dmvnorm(vec[1:21], mu = w3_mean + c_sample[9] * w3_var, sigma = w3_covar)
		# We assume that each of the gaussians has equal probability
		w3_density = w31_density + w32_density + w33_density

		# If wrongly labelled then we count it as an error
		category = which.max(c(w1_density, w2_density, w3_density))
		if (category != vec[22]) {
			error = error + 1
		}
	}

	# If the error is smaller than the current error
	if (error < min_error) {
		min_error = error
		w11_mean_p = w1_mean + c_sample[1] * w1_var
		w12_mean_p = w1_mean + c_sample[2] * w1_var
		w13_mean_p = w1_mean + c_sample[3] * w1_var
		w21_mean_p = w2_mean + c_sample[4] * w2_var
		w22_mean_p = w2_mean + c_sample[5] * w2_var
		w23_mean_p = w2_mean + c_sample[6] * w2_var
		w31_mean_p = w3_mean + c_sample[7] * w3_var
		w32_mean_p = w3_mean + c_sample[8] * w3_var
		w33_mean_p = w3_mean + c_sample[9] * w3_var
	}
}
###################################################################

# Compute the classification error
error = 0
for (i in 1:nrow(test_set)) {
	# Consider the ith vector in the validation_set
	vec = as.matrix(test_set[i, ])

	# Compute density for w1
	w11_density = dmvnorm(vec[1:21], mu = w11_mean_p, sigma = w1_covar)
	w12_density = dmvnorm(vec[1:21], mu = w12_mean_p, sigma = w1_covar)
	w13_density = dmvnorm(vec[1:21], mu = w13_mean_p, sigma = w1_covar)
	# We assume that each of the gaussians has equal probability
	w1_density = w11_density + w12_density + w13_density

	# Compute density for w2
	w21_density = dmvnorm(vec[1:21], mu = w21_mean_p, sigma = w2_covar)
	w22_density = dmvnorm(vec[1:21], mu = w22_mean_p, sigma = w2_covar)
	w23_density = dmvnorm(vec[1:21], mu = w23_mean_p, sigma = w2_covar)
	# We assume that each of the gaussians has equal probability
	w2_density = w21_density + w22_density + w23_density

	# Compute density for w3
	w31_density = dmvnorm(vec[1:21], mu = w31_mean_p, sigma = w3_covar)
	w32_density = dmvnorm(vec[1:21], mu = w32_mean_p, sigma = w3_covar)
	w33_density = dmvnorm(vec[1:21], mu = w33_mean_p, sigma = w3_covar)
	# We assume that each of the gaussians has equal probability
	w3_density = w31_density + w32_density + w33_density

	# If wrongly labelled then we count it as an error
	category = which.max(c(w1_density, w2_density, w3_density))
	if (category != vec[22]) {
		error = error + 1
	}
}

# If the error is smaller than the current error
if (error < min_error) {
	min_error = error
	w11_mean_p = w1_mean + c_sample[1] * w1_var
	w12_mean_p = w1_mean + c_sample[2] * w1_var
	w13_mean_p = w1_mean + c_sample[3] * w1_var
	w21_mean_p = w2_mean + c_sample[4] * w2_var
	w22_mean_p = w2_mean + c_sample[5] * w2_var
	w23_mean_p = w2_mean + c_sample[6] * w2_var
	w31_mean_p = w3_mean + c_sample[7] * w3_var
	w32_mean_p = w3_mean + c_sample[8] * w3_var
	w33_mean_p = w3_mean + c_sample[9] * w3_var
}

rate = error / nrow(test_set)
