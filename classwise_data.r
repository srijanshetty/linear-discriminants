setwd(".")

# Always generate the same data
set.seed(111)

# Number of samples
sample_size = 1500
training_size = 0.8
validation_size = 0.1
test_size = 0.1

###################################################################
# To generate the waveform data we use mlbench
# mlbench uses Breiman's original waveform source modified for R
library(mlbench)
waves = mlbench.waveform(sample_size)
data = data.frame(cbind(waves$x, waves$class))
###################################################################

###################################################################
# Divide the vectors according to the classes
w1 = data[data$X22 == 1, ]

# Create training, test and validation sets for w1
w1_validation_size = floor(nrow(w1) * validation_size)
w1_test_size = floor(nrow(w1) * test_size)
w1_training_size = nrow(w1) - w1_test_size - w1_validation_size

w1_training = w1[1:w1_training_size, ]
w1_validation = w1[(w1_training_size + 1):(w1_training_size + w1_validation_size), ]
w1_test = w1[(w1_training_size + w1_validation_size + 1):(w1_training_size + w1_validation_size + w1_test_size), ]

###################################################################
# Divide the vectors according to the classes
w2 = data[data$X22 == 2, ]

# Create training, test and validation sets for w2
w2_validation_size = floor(nrow(w2) * validation_size)
w2_test_size = floor(nrow(w2) * test_size)
w2_training_size = nrow(w2) - w2_test_size - w2_validation_size

w2_training = w2[1:w2_training_size, ]
w2_validation = w2[(w2_training_size + 1):(w2_training_size + w2_validation_size), ]
w2_test = w2[(w2_training_size + w2_validation_size + 1):(w2_training_size + w2_validation_size + w2_test_size), ]

###################################################################
# Divide the vectors according to the classes
w3 = data[data$X22 == 3, ]

# Create training, test and validation sets for w3
w3_validation_size = floor(nrow(w3) * validation_size)
w3_test_size = floor(nrow(w3) * test_size)
w3_training_size = nrow(w3) - w3_test_size - w3_validation_size

w3_training = w3[1:w3_training_size, ]
w3_validation = w3[(w3_training_size + 1):(w3_training_size + w3_validation_size), ]
w3_test = w3[(w3_training_size + w3_validation_size + 1):(w3_training_size + w3_validation_size + w3_test_size), ]
###################################################################
