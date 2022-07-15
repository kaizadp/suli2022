## Session 4: processing data using {tidyverse} 
## June 29, 2022
## KFP

# more info here: https://github.com/kaizadp/introductoryR/wiki/tidyverse

# -------------------------------- #

# load package/s ----
library(tidyverse)

# load files ----
tctn_data = read.csv("data/TCTN_toledo_data.csv") # data file
tctn_sample_key = read.csv("data/Toledo_sample_key.csv") # sample key


# explore the data ----
names(tctn_data) # gives the column names
str(tctn_data) # gives the file structure (types of columns)
# plot(tctn_data)


# process and clean the data ----

## the column names are horrible, as R converts all spaces to .
## rename the columns and then keep only the relevant columns

tctn_data_cleaned = 
  tctn_data %>% # pipes shortcut: shift-control-m
  ## `rename` syntax: rename(NEW = OLD)
  rename(TN_perc = `N.....`, TC_perc = `C.....`) %>% 
  ## use `select` to keep only the columns you want
  select(Name, Method, TC_perc, TN_perc, Memo)

# what are the blank values?
## use `filter` to keep only rows that match a condition
tctn_blanks = 
  tctn_data_cleaned %>% 
  filter(Name %in% c("MT", "mt")) # within the Name column, look for any of these values

# extract only the sample rows
## because all samples were run using the "soil" method, we can use that as our condition
## also, remove any samples that were flagged as "skip"

tctn_samples = 
  tctn_data_cleaned %>% 
  filter(Method == "soil" & Memo != "skip") # keep rows where Memo was NOT equal to skip

# merge data with sample_key
## use `left_join` to add the sample key TO your data

tctn_samples_full = 
  tctn_samples %>% 
  left_join( tctn_sample_key, by = "Name") %>% 
  # you have upper and lower case values in transect. make all of them upper case
  # use mutate to modify the `transect` column
  mutate(transect = toupper(transect)) 


# plot ----

## histogram of the blanks
ggplot(tctn_blanks, aes(x = TC_perc))+
  geom_histogram()

## histogram of the samples
ggplot(tctn_samples, aes(x = TC_perc))+
  geom_histogram()

## scatter plot of sample TC %
ggplot(data = tctn_samples_full,
       aes(y = TC_perc, x = transect,
           shape = horizon, color = site))+
  geom_jitter(width = 0.2, size = 2)+
  scale_shape_manual(values = c(1, 16))

## facets (panels)
ggplot(data = tctn_samples_full,
       aes(y = TC_perc, x = transect,
           shape = horizon, color = site))+
  geom_jitter(width = 0.2, size = 2)+
  scale_shape_manual(values = c(1, 16))+
  facet_wrap(~site) #tilde




### adding more stuff here ...