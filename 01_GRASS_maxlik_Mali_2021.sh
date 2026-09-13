#!/bin/sh
# 1. Import data
# listing the files
g.list rast
# importing the image subset with 7 Landsat bands and display the raster map
r.import input=/Users/polinalemenkova/grassdata/Mali/LC08_L2SP_197050_20211116_20211125_02_T1_SR_B1.TIF output=L8_2021_01 resample=bilinear extent=region resolution=region --overwrite
r.import input=/Users/polinalemenkova/grassdata/Mali/LC08_L2SP_197050_20211116_20211125_02_T1_SR_B2.TIF output=L8_2021_02 extent=region resolution=region --overwrite
r.import input=/Users/polinalemenkova/grassdata/Mali/LC08_L2SP_197050_20211116_20211125_02_T1_SR_B3.TIF output=L8_2021_03 extent=region resolution=region --overwrite
r.import input=/Users/polinalemenkova/grassdata/Mali/LC08_L2SP_197050_20211116_20211125_02_T1_SR_B4.TIF output=L8_2021_04 extent=region resolution=region --overwrite
r.import input=/Users/polinalemenkova/grassdata/Mali/LC08_L2SP_197050_20211116_20211125_02_T1_SR_B5.TIF output=L8_2021_05 extent=region resolution=region --overwrite
r.import input=/Users/polinalemenkova/grassdata/Mali/LC08_L2SP_197050_20211116_20211125_02_T1_SR_B6.TIF output=L8_2021_06 extent=region resolution=region --overwrite
r.import input=/Users/polinalemenkova/grassdata/Mali/LC08_L2SP_197050_20211116_20211125_02_T1_SR_B7.TIF output=L8_2021_07 extent=region resolution=region --overwrite
#
g.list rast
#
# g.remove -f type=raster pattern="L8_2015_*"
# grouping data by i.group
# Set computational region to match the scene
g.region raster=L8_2021_01 -p
# store VIZ, NIR, MIR into group/subgroup (leaving out TIR)
i.group group=L8_2021 subgroup=res_30m \
  input=L8_2021_01,L8_2021_02,L8_2021_03,L8_2021_04,L8_2021_05,L8_2021_06,L8_2021_07
#
# 4. Clustering: generating signature file and report using k-means clustering algorithm
i.cluster group=L8_2021 subgroup=res_30m \
  signaturefile=cluster_L8_2021 \
  classes=20 reportfile=rep_clust_L8_2021.txt --overwrite
# 5. Classification by i.maxlik module
#
i.maxlik group=L8_2021 subgroup=res_30m \
  signaturefile=cluster_L8_2021 \
  output=L8_2021_cluster_classes reject=L8_2021_cluster_reject
#
# 6. Mapping r.colors --help
d.mon wx0
g.region raster=L8_2021_cluster_classes -p
r.colors L8_2021_cluster_classes color=roygbiv -e
d.rast L8_2021_cluster_classes
d.legend raster=L8_2021_cluster_classes title="2021" title_fontsize=12 font="Helvetica" fontsize=10 bgcolor=white border_color=white
d.out.file output=Mali_2021 format=jpg --overwrite
#
