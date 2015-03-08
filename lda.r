setwd(".")

# Number of samples
sample_size = 1500

# To generate the waveform data we use mlbench
# mlbench uses Breiman's original waveform source modified for R
library(mlbench)
waves = mlbench.waveform(1500)
data = data.frame(cbind(waves$x, waves$class))

# Divide the vectors according to the classes
w1 = data[data$X22 == 1, ]
w2 = data[data$X22 == 2, ]
w3 = data[data$X22 == 3, ]

# We use the MASS library for lda function
library(MASS)
