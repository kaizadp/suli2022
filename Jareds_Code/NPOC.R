### Preliminary WSOC Analysis (NPOC/DOC)
## 7/19/22
## JIM

##LOAD PACKAGES
library(tidyverse)

#--------------------------------------------------#

##LOAD AND MERGE FILES - processed at PNNL

# data file
wsoc_data = read.csv("data/cmps_data/weoc_2022-07-23.csv")
# sample key
sample_key = read.csv("data/cmps_data/sample_key.csv") 
# merge data and sample key
wsoc_merge = 
  wsoc_data %>% 
  left_join(sample_key, by = "sample_label")

## Processed Data

wsoc_processed = 
  wsoc_merge %>% 
# remove inconsistent filtration method 
  filter(notes != "vacuum-filtered") %>%
  ###right_join(sample_key, by = "sample_label")
# remove outliers 
  filter((region == "WLE" & npoc_ug_g < 200)|
  (region == "CB" & npoc_ug_g < 1250)) %>% 
# remove wte transects
  filter(transect != "wte") %>% 
# filter N/A
  ###filter(!is.na(tree_number)) %>% 
# arrange by sample label 
  arrange(sample_label) 
  

## Formatting
transect_order = factor(wsoc_processed$transect, level = c('upland','transition','wc'))

## Regional Data
  
wsoc_wle = 
  wsoc_processed %>% 
  filter(region == "WLE")

wsoc_cb =
  wsoc_processed %>% 
  filter(region == "CB")



## GRAPHS

ggplot(wsoc_processed, aes(npoc_ug_g,npoc_mgL)) +
  geom_point(aes(color = region, shape = transect))

## Transect Analysis 
ggplot(wsoc_cb, aes(transect, npoc_ug_g)) +
  geom_violin() + 
  geom_jitter(width = .2,aes(color = site))

ggplot(wsoc_wle, aes(transect, npoc_ug_g)) +
  geom_violin() + 
  geom_jitter(width = .2,aes(color = site))

ggplot(wsoc_processed, aes(transect_order,npoc_ug_g)) +
  geom_boxplot(outlier.alpha = 0)+ 
  geom_jitter(width = .2,aes(color = region))+
  facet_wrap(~region)

## Horizon Analysis
ggplot(wsoc_processed, aes(horizon,npoc_ug_g)) +
  geom_boxplot(outlier.alpha = 0) +
  geom_jitter(width = 0.2,aes(color = region))

ggplot(wsoc_cb, aes(horizon,npoc_ug_g)) +
  geom_boxplot(outlier.alpha = 0) +
  geom_jitter(width = 0.2,aes(color = horizon)) 

ggplot(wsoc_wle, aes(horizon,npoc_ug_g)) +
  geom_boxplot(outlier.alpha = 0) +
  geom_jitter(width = 0.2,aes(color = horizon)) 

## Site Analysis 
ggplot(wsoc_processed, aes(site,npoc_ug_g))+
  geom_boxplot(outlier.alpha = 0) +
  geom_jitter(aes(color = site), width = 0.2)



