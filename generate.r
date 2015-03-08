setwd(".")

# The number of samples
sample_size = 1500

# The waveform functions
h1 = function(i) max(6 - abs(i - 11), 0)
h2 = function(i) h1(i) * (i - 4)
h3 = function(i) h1(i) * (i + 4)

# Class propabilities are equal so we generate equal amout of samples
# for each of the classes
class_size = floor(sample_size / 3)

# Division of data into three sets
learning_set_size = floor(class_size * 0.6)
validation_set_size = floor(class_size * 0.2)
test_set_size = floor(class_size * 0.2)

