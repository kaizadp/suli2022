### Preliminary WSOC Analysis (NPOC/DOC)
## 7/19/22
## JIM

##LOAD PACKAGES
library(tidyverse)

#--------------------------------------------------#

##LOAD FILES - processed at PNNL

# data file
wsoc = read.csv("data/cmps_data/weoc.csv")
# sample key
sample_key = read.csv("data/cmps_data/sample_key.csv") 
# check loaded files 
View(wsoc)
View(sample_key)

##REMOVE VACUUM FILTERED SAMPLES

wsoc = 
  wsoc %>% 
  filter(notes != "vacuum-filtered") %>%
  arrange(sample_label)
# check filtered files 
View(wsoc)

##MERGE DATA AND SAMPLE KEY

wsoc = 
  wsoc %>% 
  left_join(sample_key, by = "sample_label")
#check merged file
View(wsoc)

##FILTER ANY OUTLIERS



## GRAPHS
transect_order = factor(wsoc$transect, level = c('upland','transition','wte','wc'))
#screwing around w/ visualizations 
ggplot(wsoc, aes(npoc_ug_g,npoc_mgL)) +
  geom_point()

ggplot(wsoc, aes(transect,npoc_mgL)) +
  geom_jitter(width = .2,aes(color = site))

ggplot(wsoc, aes(transect_order,npoc_mgL)) +
  geom_boxplot()

ggplot(wsoc, aes(transect_order,npoc_mgL)) +
  geom_boxplot(outlier.alpha = 0)+ 
  geom_jitter(width = .2,aes(color = site))

ggplot(wsoc, aes(horizon,npoc_mgL)) +
  geom_jitter(width = 0.2)

ggplot(wsoc, aes(site,npoc_mgL)) +
  geom_jitter(width = 0.2)


