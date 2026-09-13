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

library(rgdal)
library(raster)
library(terra)
library(RColorBrewer)
library(pals)
library(colorspace)
library(RStoolbox)
library(graphics)

# Set up working directory
setwd("/Users/polinalemenkova/Documents/R/52_Image_Processing/K-means")
# Importing data
Landsat_2021 <- list.files("/Users/polinalemenkova/Documents/R/52_Image_Processing/K-means")
# Printing the list
list.files()
#
# Stacking the data to create a RasterStack. 
Landsat_2021_stack <- stack(Landsat_2021)
# Turning a stack into a brick. 
Landsat_2021_brick <- brick(Landsat_2021_stack)
# Viewing brick attributes
Landsat_2021_brick
#
# Running the classification
set.seed(25)
unC <- unsuperClass(Landsat_2021_brick, nSamples = 100, nClasses = 20, nStarts = 5)
unC
#
# Creating color palette
colors <- jet(20)
colors <- rainbow(20)
colors <- kovesi.rainbow_bgyr_35_85_c73(20)
colors <- brewer.spectral(20)

# plotting a map
plot(unC$map, main = "K-means Clustering for Landsat-8 OLI/TIRS C1 image of Mali, Inner Niger Delta  \nLC08_L2SP_197050_20211116_20211125_02_T1_SR (2021)", font.main=1, cex.main = 0.85, col = colors, axes = FALSE, box = FALSE, legend = FALSE)
# adding legend
legend(x = "topright", legend=c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"), fill = colors, title = "LULC ID Classes", horiz = FALSE,  bty = "n", text.font=1, ncol=1, y.intersp = 0.7)





legend(x = "right", legend=c("Woodland", "Floodplain with aquatic grassland", "Savannah", "Thicket", "Wild rice", "Grassland", "Irrigated rice fields", "Savannah in shallow floodplain", "Bare soil (loams and clays)", "Bare soil (sands)", "Vegetation mosaics, main channel banks", "Lacustrine woodland", "Shallow lacustrine woodland", "Shrubby savannah in uplands", "Anthropic woody savannah", "Thicket in uplands", "Woody savannah in uplands", "Shrubby savannah in uplands", "Island palm grove", "Margins palm grove"), fill = colors, title = "LULC ID Classes", horiz = FALSE,  bty = "n", text.font=1, ncol=1, inset = -0.60)

#-------------------- BF-2021: END-----------------#

