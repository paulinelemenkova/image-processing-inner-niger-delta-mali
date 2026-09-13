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
setwd("/Users/polinalemenkova/Documents/R/52_Image_Processing/NDVI")
# 1. Normalized Difference Vegetation Index (NDVI) = (NIR - R) / (NIR + R), i.e., NDVI = (Band 5 – Band 4) / (Band 5 + Band 4).
vi <- function(img, k, i) {
  bk <- img[[k]]
  bi <- img[[i]]
  vi <- (bk - bi) / (bk + bi)
  return(vi)
}
# For Landsat NIR = 5, red = 4.
filenames <- paste0('LC08_L2SP_197050_20211116_20211125_02_T1_SR_B', 1:7, ".tif")
filenames
landsat <- rast(filenames)
landsat
ndvi <- vi(landsat, 5, 4)
options(scipen=10000)
plot(ndvi, col=brewer.pal(11, "RdYlGn"), font.main = 1, main = "NDVI for Landsat-8 OLI/TIRS C1 image LC08_L2SP_197050_20211116_20211125_02_T1_SR: Inner Niger Delta, Mali (2021)", cex.main=0.9)
minor.tick(nx = 10, ny = 10, tick.ratio = 0.3)

# Plotting the histogram of the NDVI
hist(ndvi, font.main = 1, main = "NDVI values for Landsat-8 OLI/TIRS C1 image \nLC08_L2SP_197050_20211116_20211125_02_T1_SR: Inner Niger Delta, Mali (2021)", xlab = "NDVI", ylab= "Frequency",
    col = "darkolivegreen1", xlim = c(-0.5, 1),  breaks = 30, xaxt = "n")
axis(side=1, at = seq(-0.6, 1, 0.1), labels = seq(-0.6, 1, 0.1))
minor.tick(nx = 10, ny = 10, tick.ratio = 0.3)
