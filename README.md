# Discriminant Analysis

## Generation of Waveforms
- *Package*: **[mlbench]**(http://artax.karlin.mff.cuni.cz/r-help/library/mlbench/html/mlbench.waveform.html) as *mlbench.waveform*
- *mlbench.waveform* use's Breiman's original waveform generation function which is available at UCI's [Machine Learning repositiory](https://archive.ics.uci.edu/ml/datasets/Waveform+Database+Generator+(Version+2)).

## LDA and QDA
- *Package*: **[MASS]**(http://cran.r-project.org/web/packages/MASS/MASS.pdf) for lda and qda.

## Gaussian Fitting
- *Package*: **[mixtools]**(http://cran.r-project.org/web/packages/mixtools/mixtools.pdf)
- The gaussians are fit using random sampling.
    - We run the algorithm for a fixed number of iterations and sample *nine* points every iteration, *three* for each class.
    - Using the *three* offsets, we compute a mixture of gaussians distribution for each class and compute the classification error on the validation set.
    - Finally we use the mixture of gaussians with the lowest classification error overall.

## Accuracies of the models

- *Mixture of Gaussians*:                       0.83
- *Linear Discriminant Analysis*:               0.87
- *Quadratic Discriminant Analysis*:            0.8666667

