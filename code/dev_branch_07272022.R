### Deliverables Graphs and Stuff

#load packages
library(tidyverse)
#library(ggplot2)

#load files (name you want = read.csv(pathway))
tctn_data = read.csv("data/cmps_data/total_CNS_partial_2022-07-24.csv")
tctn_key = read.csv("data/cmps_data/sample_key.csv")
wrc_data = read.csv("data/cmps_data/wrc_2022-07-18.csv")
pH_data = read.csv("data/cmps_data/soil_pH_toledo_chesapeake_data.csv")
sample_key = read.csv("data/cmps_data/sample_key.csv")

#making the data pretty
tctn_data_pretty = 
  tctn_data %>% 
  left_join(tctn_key, by = "sample_label") %>% 
  filter(TN_perc < 6) %>% 
  filter(transect != "wte") %>% 
  mutate(transect = recode(transect, "wc" = 'wetland'), 
         horizon = factor(horizon, levels = c("O","A","B")),
         transect = factor(transect, levels = c("upland","transition","wetland")),
         region = recode(region, "CB" = "Chesapeake Bay"),
         region = recode(region, "WLE" = "Western Lake Erie")) 

wrc_data_pretty = 
  wrc_data %>% 
  mutate(site = recode(site, "OWC" = 'Old Woman Creek'),
         site = recode(site, "PR" = "Portage River"),
         transect = recode(transect, "transition" = "Transition"),
         transect = recode(transect, "upland" = "Upland"),
         transect = recode(transect, "wetland" = "Wetland"),
         transect = factor(transect, levels = c("Upland","Transition","Wetland")))

pH_data_pretty = 
  pH_data %>% 
  left_join(sample_key, by = "sample_label") %>% 
  mutate(transect = recode(transect, "transition" = "Transition"),
         transect = recode(transect, "upland" = "Upland"),
         transect = recode(transect, "wc" = "Wetland"),
         transect = factor(transect, levels = c("Upland","Transition","Wetland")),
         region = recode(region, "CB" = "Chesapeake Bay"),
         region = recode(region, "WLE" = "Western Lake Erie"),
         horizon = factor(horizon, levels = c("O","A","B"))) %>% 
  filter(!is.na(transect))

###Graph: pH by region
set.seed(12345)
pH_region_graph =
  pH_data_pretty %>% 
  ggplot(aes(x = transect, y = pH))+
  labs(title = "pH by Region",
       x = "")+
  facet_wrap(~region)+
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5, color = '#402d10', face = 'bold', size = 20),
        text = element_text(color = "#402d10"),
        strip.text = element_text(color = "#402d10", size = 14, face = "italic"),
        strip.background = element_rect(fill = "#dbcebd"),
        axis.title = element_text(color = "#402d10", size = 16),
        axis.text = element_text(color = "#402d10"),
        legend.position = "top",
        legend.title = element_blank(),
        panel.background = element_rect(fill = "#faf8f5", color = "#402d10"),
        plot.background = element_rect(fill = "#ede8e1"))+
  geom_jitter(aes(color = horizon), 
              width = 0.2)+
  scale_color_manual(values = c("#DC267F","#FE6100","#FFC900"))


###Graph: Total Carbon by Horizon
tc_hz_graph = 
  tctn_data_pretty %>% 
  ggplot(aes(x = horizon, y = TC_perc))+
  labs(x = "Horizon",
       y = "Total Carbon (%)",
       title = "Total Carbon by Horizon",
       color = "")+
  facet_wrap(~region, scales = "free_x")+
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5, color = '#402d10', face = 'bold', size = 20),
        text = element_text(color = "#402d10"),
        strip.text = element_text(color = "#402d10", size = 14, face = "italic"),
        strip.background = element_rect(fill = "#dbcebd"),
        axis.title = element_text(color = "#402d10", size = 16),
        axis.text = element_text(color = "#402d10"),
        legend.position = "none",
        panel.background = element_rect(fill = "#faf8f5", color = "#402d10"),
        plot.background = element_rect(fill = "#ede8e1"))+
  geom_boxplot()+
  geom_jitter(aes(color = horizon),width = 0.3)+
  scale_color_manual(values = c("#DC267F","#FE6100","#FFC900"))

###Graph: Total Carbon by Transect
tc_transect_graph = 
  tctn_data_pretty %>% 
  ggplot(aes(x = transect, y = TC_perc))+
  labs(x = "",
       y = "Total Carbon (%)",
       title = "Total Carbon by Transect")+
  facet_wrap(~region, scales = "free_x")+
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5, color = '#402d10', face = 'bold', size = 20),
        text = element_text(color = "#402d10"),
        strip.text = element_text(color = "#402d10", size = 14, face = "italic"),
        strip.background = element_rect(fill = "#dbcebd"),
        axis.title = element_text(color = "#402d10", size = 16),
        axis.text = element_text(color = "#402d10"),
        legend.position = "top",
        panel.background = element_rect(fill = "#faf8f5", color = "#402d10"),
        plot.background = element_rect(fill = "#ede8e1"))+
  geom_boxplot()+
  geom_jitter(width = 0.2,aes(color = horizon))+
  scale_color_manual(values = c("#DC267F","#FE6100","#FFC900"))

###Graph: C:N Line
cn_line_graph =
  tctn_data_pretty %>% 
ggplot(aes(x = TC_perc, y = TN_perc))+
  labs(x = "Total Carbon (%)",
       y = "Total Nitrogen (%)",
       title = "C:N Across the TAIs",
       color = "")+
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5, color = '#402d10', face = 'bold', size = 20),
        text = element_text(color = "#402d10"),
        strip.text = element_text(color = "#402d10", size = 14, face = "italic"),
        strip.background = element_rect(fill = "#dbcebd"),
        axis.title = element_text(color = "#402d10", size = 16),
        axis.text = element_text(color = "#402d10"),
        legend.position = "top",
        panel.background = element_rect(fill = "#faf8f5", color = "#402d10"),
        plot.background = element_rect(fill = "#ede8e1"))+
  geom_point(aes(color = region))+
  geom_smooth(method = "lm")+
  scale_color_manual(values = c("#E66100", "#5D3A9B"))

###Graph: Water Retention Curves of Lake Erie
options(scipen = 9)

wrc_graph = 
  wrc_data_pretty %>% 
  filter(EC_kit != "K008") %>% 
  filter(EC_kit == c("K004", "K011")) %>% 
  ggplot(aes(x = kPa/1000, y = vol_water_perc, colour = transect))+
  geom_line(size = 1.5)+
  scale_x_log10()+
  facet_wrap(~site)+
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5, color = '#402d10', face = 'bold', size = 20),
        text = element_text(color = "#402d10"),
        strip.text = element_text(color = "#402d10", size = 14, face = "italic"),
        strip.background = element_rect(fill = "#dbcebd"),
        axis.title = element_text(color = "#402d10", size = 16),
        axis.text = element_text(color = "#402d10"),
        legend.position = "top",
        panel.background = element_rect(fill = "#faf8f5", color = "#402d10"),
        plot.background = element_rect(fill = "#ede8e1"))+
  labs(x = "Water Tension (MPa)",
       y = "Water Content (%)",
       title = "Water Retention Curves of Lake Erie Sites",
       color = "")+
  scale_color_manual(values = c("#004D40","#FFC107","#1E88E5"))
  

  #soil_palette("redox",3)
#scale_color_manual(values = soil_palette("redox2",3))
  #scale_color_manual(values = c("darkolivegreen","coral4","deepskyblue4"))

###to save at the end use ggsave
# ggsave()

ggsave("graphs/Total CN Line Graph Final.png",
       cn_line_graph,
       dpi = 300,
       width = 6,
       height = 4)

ggsave("graphs/Total Carbon by Transect Final.png",
       tc_transect_graph,
       dpi = 300,
       width = 6,
       height = 4)

ggsave("graphs/Total Carbon by Horizon Final.png",
       tc_hz_graph,
       dpi = 300,
       width = 6,
       height = 4)

ggsave("graphs/Water Retention Curves Final.png",
       wrc_graph,
       dpi = 300,
       width = 6,
       height = 4)

ggsave("graphs/pH by Region Final.png",
       pH_region_graph,
       dpi = 300,
       width = 6,
       height = 4)

####SCRATCHWORK

#boxplot bc why not
#this is now scratchwork
#ggplot(data = tctn_data_full,
#aes(x = transect, y = TC_perc))+
#geom_boxplot()+
#geom_jitter(width = 0.2)

#ggplot(data = tctn_data_full,
#aes(x = horizon, y = TC_perc))+
#labs(x = "Horizon",
#y = "Total Carbon (%)",
#title = "Total Carbon by Horizon",
#subtitle = "WLE, 2022")+
#facet_wrap(~region, scales = "free_x")+
#theme_classic()+
#theme(plot.title = element_text(hjust = 0.5, vjust = 0.5),
#plot.subtitle = element_text(hjust = 0.5, vjust = 0.5),
#legend.position = "right",)+
#geom_boxplot()+
#geom_jitter(width = 0.2)

#have to install patchwork for combining graphs
#install.packages("patchwork")
#library(patchwork)

#following syntax for patchwork
#tc_transect_graph + tc_hz_graph
#use plot_layout(guides = "collect) to combine legends and add on to place it like...
#(tc_transect_graph + tc_hz_graph & theme (legnend.position = "top"))

##we're going hard on boxplots
#TCC by Hz, WLE 2022
#ggplot(data = tctn_data_full,
#aes(x = horizon, y = TC_perc))+
#geom_boxplot()+
#geom_jitter(width = 0.2)

#TCC of A Hz by Transect, WLE 2022
#####how do reorder the transect groups so it goes upland->transition->wetland??
#ggplot(data = tctn_data_full,
#aes((x = reorder(upland, transition, wetland)), y = TC_perc))+
#geom_boxplot()+
#geom_jitter(width = 0.2)

#smoothed point plots
#ggplot(data = tctn_data_full,
#aes(x = TC_perc, y = TN_perc,
#color = transect))+
#geom_point()+
#geom_smooth(method = "lm")

#####will make duplicates of each of these with CB data when available
#####will also make a boxplot comparing range of TCC between WLE and CB

#bringing in color palettes
#!!!this is giving me some trouble
#install.packages("devtools")
#devtools::install_github("kaizadp/soilpalettes")
