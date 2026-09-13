# ============================================================================
# Landsat time-series image processing, Inner Niger Delta, Mali.
# Code from the peer-reviewed article:
#   Lemenkova, P.; Debeir, O. (2023). Time Series Analysis of Landsat Images for
#   Monitoring Flooded Areas in the Inner Niger Delta, Mali.
#   Artificial Satellites, 58(4), 278-313.
#   DOI:    https://doi.org/10.2478/arsa-2023-0011
#   Zenodo: https://zenodo.org/records/10535135
#   HAL:    https://hal.science/hal-04406525v1
#
# Authors: Polina Lemenkova, Olivier Debeir  |  ORCID: 0000-0002-5759-1089
# ============================================================================

# Computing vegetation indices
library(terra)
library(RColorBrewer)
library(Hmisc)
setwd("/Users/polinalemenkova/Documents/R/52_Image_Processing/SAVI")
#
# For Landsat NIR = 5, red = 4.
filenames <- paste0('LC09_L2SP_197050_20221111_20221113_02_T1_SR_B', 1:7, ".tif")
filenames
landsat <- rast(filenames)
landsat

# Soil Adjusted Vegetation Index (SAVI) corrects NDVI for the influence of soil brightness in areas where vegetative cover is low
# SAVI = ((Band 5 – Band 4) / (Band 5 + Band 4 + 0.5)) * (1.5).
savi_fun = function(nir, red){
  ((nir - red) / (nir + red + 0.5)) * 1.5
}
savi = lapp(landsat[[c(4, 3)]],
            fun = savi_fun)
options(scipen=10000)
plot(savi, col = rev(brewer.pal(11, "Spectral")), font.main = 1, main = "SAVI for Landsat-8 OLI/TIRS C1 image LC09_L2SP_197050_20221111_20221113_02_T1_SR: Inner Niger Delta, Mali (2022)", cex.main=0.9)
minor.tick(nx = 10, ny = 10, tick.ratio = 0.3)
# Plotting histogram of the NDVI
hist(savi, font.main = 1, main = "SAVI values for Landsat-8 OLI/TIRS C1 image \nLC09_L2SP_197050_20221111_20221113_02_T1_SR: Inner Niger Delta, Mali (2022)", xlab = "NDVI", ylab= "Frequency",
    col = "chocolate1", xlim = c(-0.5, 1),  breaks = 30, xaxt = "n")
axis(side=1, at = seq(-0.6, 1, 0.1), labels = seq(-0.6, 1, 0.1))
minor.tick(nx = 10, ny = 10, tick.ratio = 0.3)
#
