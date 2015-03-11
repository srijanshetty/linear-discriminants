setwd(".")

# Always generate the same data
set.seed(111)

# Number of samples
sample_size = 1500
train_size = 0.8
validation_size = 0.1
test_size = 0.1

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
