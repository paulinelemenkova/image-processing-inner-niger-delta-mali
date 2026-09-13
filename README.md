# Image Processing of Landsat Time Series — Inner Niger Delta, Mali

A multi-tool, multi-temporal image-processing workflow for monitoring flooded
areas of the Inner Niger Delta (IND) in Mali from Landsat 8 OLI/TIRS imagery.
For each year of the time series (2013, 2015, 2018, 2020, 2021, 2022) the
repository computes vegetation indices, runs unsupervised classification and
clustering, and derives correlation and land-cover-change statistics, combining
R, Python, GRASS GIS and GMT.

## Related publication

These scripts are the code of:

Lemenkova, P.; Debeir, O. Time Series Analysis of Landsat Images for Monitoring
Flooded Areas in the Inner Niger Delta, Mali. Artificial Satellites 2023, 58(4),
278-313.

- DOI:    https://doi.org/10.2478/arsa-2023-0011
- Zenodo: https://zenodo.org/records/10535135
- HAL:    https://hal.science/hal-04406525v1
- Sciendo: https://sciendo.com/de/article/10.2478/arsa-2023-0011 (ISSN 0208-841X, Scopus / Web of Science)

## Scripts

### R vegetation indices (terra)
For each year, R_NDVI_<YEAR>.r, R_EVI_<YEAR>.r and R_SAVI_<YEAR>.r load the
Landsat surface-reflectance bands into a SpatRaster (terra::rast) and compute an
index by band arithmetic, then map it and plot its histogram:

- NDVI (Normalized Difference Vegetation Index): (NIR - Red) / (NIR + Red).
- EVI (Enhanced Vegetation Index): a gain-scaled index with blue-band
  atmospheric correction, robust in high-biomass wetlands.
- SAVI (Soil-Adjusted Vegetation Index): (NIR - Red) / (NIR + Red + L) * (1 + L),
  correcting for soil brightness.

### R k-means / unsupervised classification
K_means_clustering_<YEAR>.r stacks the Landsat bands, builds an RGB composite
(plotRGB) and runs unsupervised classification with RStoolbox::unsuperClass
(k-means, up to 20 land-use/land-cover classes), mapping the classified result.

### GRASS GIS clustering listings
Clustering_<YEAR>_Mali.tex document the GRASS GIS unsupervised-classification
workflow (i.cluster / i.maxlik style module sequences) for each year.

### Python correlation matrices
Python_CorrMatr_Pearson.py and Python_CorrMatr_Kendall.py compute and plot
parametric (Pearson) and non-parametric rank (Kendall) correlation matrices of
the yearly indices / classes.

### Cartography and tables
GMT_topo_map_Mali.sh draws the topographic/location map of the study area with
the Generic Mapping Tools (GMT); TableLCC.tex is the land-cover-change summary
table.

## Methods

- Spectral vegetation indices (NDVI, EVI, SAVI) by band arithmetic (terra).
- Unsupervised k-means classification of multispectral imagery into land-cover
  classes (RStoolbox, GRASS GIS).
- Multi-temporal (time-series) comparison across six years to track flood extent
  and land-cover change.
- Parametric and rank correlation analysis (Pearson, Kendall) in Python.
- Cartographic mapping with GMT.

## Data

- Landsat 8 OLI/TIRS Collection 2 Level-2 surface-reflectance scenes
  (path/row 197050), Inner Niger Delta, Mali. The GeoTIFF bands are expected in
  the working directory and are not stored in this repository.

## Requirements

- R (>= 4.0): terra, raster, rgdal, RStoolbox, RColorBrewer, pals, colorspace
- Python (>= 3.8): numpy, pandas, matplotlib, seaborn (for the correlation
  matrices)
- GRASS GIS (unsupervised classification) and GMT (mapping)

## Usage

Place the Landsat bands for a given year in the working directory and run, e.g.:

    Rscript R_NDVI_2022.r
    Rscript K_means_clustering_2022.r
    python3 Python_CorrMatr_Pearson.py

## Authors and citation

Polina Lemenkova, Olivier Debeir
ORCID: https://orcid.org/0000-0002-5759-1089

If you use these scripts, please cite:

Lemenkova, P.; Debeir, O. Time Series Analysis of Landsat Images for Monitoring
Flooded Areas in the Inner Niger Delta, Mali. Artificial Satellites 2023, 58(4),
278-313. https://doi.org/10.2478/arsa-2023-0011

## License

See the LICENSE file in this repository (Copyright Polina Lemenkova).
