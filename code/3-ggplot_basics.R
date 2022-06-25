## Session 3: basics of {ggplot2}
## June 24, 2022
## KFP

# -------------------------------- #

## load packages
library(ggplot2)
library(palmerpenguins) # using `penguins` dataset for this exercise

View(penguins)
names(penguins)

## more info here: https://github.com/kaizadp/introductoryR/wiki/ggplot2%3A-the-Grammar-of-Graphics

# basic scatterplot ----

ggplot(
  data = penguins, # set the source dataset
  aes(x = body_mass_g, y = bill_length_mm))+ # set x and y axes within the aesthetic
  geom_point() # add a geometry. in this case, geom_point --> scatterplot

ggplot(
  data = penguins,
  aes(x = island, y = bill_length_mm))+
  geom_point()

## using geom_jitter instead of geom_point
## jitter adds a small random noise along the x axis (in this case), so you can see all the points clearly
ggplot(data = penguins, 
       aes(x = island, y = bill_length_mm)) + 
  geom_jitter(width = 0.2)


#### formatting your graphs #### ---- 

# COLOR ----
## add a `color = ...` argument to your geometry
## you can add the actual name of the color, or a hex code 

ggplot(data = penguins, aes(x = island, y = bill_length_mm)) + 
  geom_jitter(width = 0.2, color = "firebrick1")

ggplot(data = penguins, aes(x = island, y = bill_length_mm)) + 
  geom_jitter(width = 0.2, color = "#fb8500")


# COLOR VS. FILL ----
## for solid geometries (boxplots, bars, violin plots, or even colored points)
## `color` will set the outline color
## `fill` will set the fill color

ggplot(data = penguins, aes(x = island, y = bill_length_mm)) + 
  geom_boxplot(color = "#fb8500")

ggplot(data = penguins, aes(x = island, y = bill_length_mm)) + 
  geom_boxplot(color = "black", fill = "#fb8500")


# SHAPE ----
## add a `shape = ...` argument to your geometry
## shapes are coded as specific numbers
## the list of shapes is here: https://ggplot2.tidyverse.org/articles/ggplot2-specs.html

ggplot(data = penguins, aes(x = island, y = bill_length_mm)) + 
  geom_jitter(width = 0.2, shape = 1)


# ALPHA ----
## alpha sets the transparency of the geometries
## alpha can range from 0 (clear/invisible) to 1 (opaque)

ggplot(data = penguins, aes(x = island, y = bill_length_mm)) + 
  geom_point(alpha = 0.2)

ggplot(data = penguins, aes(x = island, y = bill_length_mm)) + 
  geom_violin(fill = "yellow", alpha = 0.2)

ggplot(data = penguins, aes(x = island, y = bill_length_mm)) + 
  geom_violin(fill = "yellow", alpha = 0.8)


# STROKE ----
## `stroke` sets the border thickness for geom_point and geom_jitter
ggplot(data = penguins, aes(x = body_mass_g, y = bill_length_mm)) + 
  geom_point(shape = 1, stroke = 0.3)

ggplot(data = penguins, aes(x = body_mass_g, y = bill_length_mm)) + 
  geom_point(shape = 1, stroke = 1)

# SETTING COLOR, SHAPE, ETC. BY GROUP ----
## when assigning color/shape/size, etc. by groups in your dataset, use `aes()`

ggplot(data = penguins, aes(x = body_mass_g, y = bill_length_mm))+ 
  geom_point(aes(color = sex))

ggplot(data = penguins, aes(x = body_mass_g, y = bill_length_mm))+ 
  geom_point(aes(color = sex,
                 shape = island))

ggplot(data = penguins, aes(x = island, y = bill_length_mm)) + 
  geom_boxplot(color = "black",
               aes(fill = island))

## when adding multiple geoms instead of setting `aes(color = ...)` for each geom,
## you can combine them in the main `aes`

## instead of: 
ggplot(data = penguins, aes(x = island, y = bill_length_mm)) + 
  geom_boxplot(aes(color = island))+
  geom_jitter(aes(color = island), width = 0.1)
  
## use:
ggplot(data = penguins, 
       aes(x = island, y = bill_length_mm,
           color = island)) + 
  geom_boxplot()+
  geom_jitter(width = 0.1)

## ggplot will set the colors, shapes, etc. to the default values
## you can change these using `scale`


# SCALES FOR COLOR/SHAPE ----

ggplot(
  data = penguins, 
  aes(x = body_mass_g, y = bill_length_mm))+ 
  geom_point(aes(color = sex,
                 shape = island))+
  scale_color_manual(values = c("blue", "red"))+
  scale_shape_manual(values = c(1, 12, 19))

## you can manually set each color value
## you can also use pre-defined color palettes

## example 1: brewer color palette 
## https://r-graph-gallery.com/38-rcolorbrewers-palettes.html
ggplot(
  data = penguins, 
  aes(x = body_mass_g, y = bill_length_mm))+ 
  geom_point(aes(color = island))+
  scale_color_brewer(palette = "Dark2")

## example 2: viridis color palette
## https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
ggplot(
  data = penguins, 
  aes(x = body_mass_g, y = bill_length_mm))+ 
  geom_point(aes(color = island))+
  scale_color_viridis_d()

## example 3: viridis color palette
ggplot(
  data = penguins, 
  aes(x = body_mass_g, y = bill_length_mm))+ 
  geom_point(aes(color = island))+
  scale_color_viridis_d(option = "plasma")

## example 4: PNW color palette
## https://github.com/jakelawlor/PNWColors
ggplot(
  data = penguins, 
  aes(x = body_mass_g, y = bill_length_mm))+ 
  geom_point(aes(color = sex))+
  scale_color_manual(values = PNWColors::pnw_palette("Winter", 2))

## example 5: soilpalettes
## https://github.com/kaizadp/soilpalettes
ggplot(
  data = penguins, 
  aes(x = body_mass_g, y = bill_length_mm))+ 
  geom_point(aes(color = sex))+
  scale_color_manual(values = soilpalettes::soil_palette("podzol", 2))


# AXIS/LEGEND LABELS ----

## option 1: use `xlab()` and `ylab()` for x and y axis labels
ggplot(data = penguins, 
       aes(x = island, y = bill_length_mm)) + 
  geom_boxplot(color = "black",
               aes(fill = island))+
  xlab("Island")+
  ylab("Bill length, mm")

## option 2: use labs instead (preferred)
## this allows you to set both axis labels as well as plot title, caption, etc in the same command
## and also legend titles

ggplot(data = penguins, aes(x = island, y = bill_length_mm)) + 
  geom_boxplot(color = "black", aes(fill = island))+
  labs(x = "Island",
       y = "Bill length, mm",
       title = "Penguins dataset",
       subtitle = "boxplot",
       caption = "made on 2022-06-24",
       fill = "Islandsss")

ggplot(data = penguins, aes(x = body_mass_g, y = bill_length_mm))+ 
  geom_point(aes(color = sex, shape = island))+
  scale_color_manual(values = c("blue", "red"))+
  scale_shape_manual(values = c(1, 12, 19))+
  labs(color = "Sex",
       shape = "Island")


# SMOOTH AND LINE PLOTS ----
## `geom_smooth()` works when both x and y axes are numerical/continuous variables

ggplot(data = penguins, aes(x = body_mass_g, y = bill_length_mm))+ 
  geom_point()+
  geom_smooth()

## to make a linear regression plot:
ggplot(data = penguins, aes(x = body_mass_g, y = bill_length_mm))+ 
  geom_point()+
  geom_smooth(method = "lm")

## grouping to make separate regression lines
ggplot(data = penguins, aes(x = body_mass_g, y = bill_length_mm))+ 
  geom_point()+
  geom_smooth(method = "lm",
              aes(group = island))

ggplot(data = penguins, aes(x = body_mass_g, y = bill_length_mm))+ 
  geom_point()+
  geom_smooth(method = "lm",
              aes(color = island))



ggplot(
  data = penguins, 
  aes(x = body_mass_g, y = bill_length_mm,
      color = island))+ 
  geom_point()+
  geom_smooth(method = "lm")


# BAR GRAPHS ----
## `geom_bar(stat = "identity")` <-- do not forget the `stat` argument

ggplot(data = penguins, 
  aes(y = body_mass_g, x = island))+ 
    geom_bar(stat = "identity")

## ^ this output is clearly wrong, because it stacks all the data points to give a skewed graph
## bar graphs are supposed to represent summaries (mean, std deviation, etc.), 
## so we first need to compute the summaries.
## we do this using {dplyr}, which is part of the {tidyverse} group

## we use pipes (%>%) to chain functions in sequence
## so you can run all your functions in one long chain

## more info here: https://github.com/kaizadp/introductoryR/wiki/tidyverse

library(tidyverse)

## create a summary dataframe
penguins_summary = 
  penguins %>% 
  group_by(island) %>% # we want to summarize for each island 
  dplyr::summarise(mean_mass = mean(body_mass_g, na.rm = TRUE), # na.rm excludes the NA cells from the calculation
                   sd_mass = sd(body_mass_g, na.rm = TRUE))

ggplot(data = penguins_summary, aes(y = mean_mass, x = island))+ 
  geom_bar(stat='identity')

## compare this ^ with the first bar plot we created. the values here make more sense

## adding error bars

ggplot(data = penguins_summary, aes(y = mean_mass, x = island))+ 
  geom_bar(stat='identity', fill = "yellow")+
  geom_errorbar(aes(ymin = mean_mass - sd_mass,
                    ymax = mean_mass + sd_mass),
                width = 0.3)

  
