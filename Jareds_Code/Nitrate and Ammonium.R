### Preliminary Nitrate Analysis (NO3-)
## 7/19/22
## JIM

##LOAD PACKAGES
library(tidyverse)

#--------------------------------------------------#

##LOAD FILES - processed at Argonne National Lab

# data file
inorganic_nitrate = read.csv("data/cmps_data/inorganic_n_2022-07-18.csv")
# sample key
sample_key = read.csv("data/cmps_data/sample_key.csv") 
# check loaded files 
View(inorganic_nitrate)
View(sample_key)

##MERGE DATA AND SAMPLE KEY

inorg_n = 
  inorganic_nitrate %>% 
  left_join(sample_key, by = "sample_label")
#check merged file
View(inorg_n)

##FILTER ANY OUTLIERS

inorg_n = 
  inorg_n %>% 
  filter(no3_ug_g < 450)

## FORMAT DATA

transect_order = factor(inorg_n$transect, level = c('upland','transition','wte','wc'))

## GRAPHS
#screwing around w/ visualizations 
ggplot(inorganic_nitrate, aes(NO3_mgL, no3_ug_g)) +
  geom_point()

ggplot(inorg_n, aes(transect,no3_ug_g)) +
  geom_jitter(width = .2,aes(color = site))

ggplot(inorg_n, aes(transect_order,no3_ug_g)) +
  geom_boxplot()

ggplot(inorg_n, aes(transect_order,no3_ug_g)) +
  geom_boxplot(outlier.alpha = 0)+ 
  geom_jitter(width = .2,aes(color = site))

ggplot(inorg_n, aes(horizon,no3_ug_g)) +
  geom_jitter(width = 0.2)

ggplot(inorg_n, aes(site,no3_ug_g)) +
  geom_jitter(width = 0.2)
