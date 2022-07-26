### Creating TCTN Graphs of CB and WLE7.25.22

#load packages
library(tidyverse)
library(ggplot2)

#load files (name you want = read.csv(pathway))
tctn_data = read.csv("data/cmps_data/total_CNS_partial_2022-07-24.csv")
tctn_key = read.csv("data/cmps_data/sample_key.csv")

#starting with making datasheet for analysis by transect and horizon
#copied from Kaizad and adjusted for these data
#took out outlier
#took out wte
tctn_data_full = 
  tctn_data %>% 
  left_join( tctn_key, by = "sample_label") %>% 
  filter(TN_perc < 6) %>% 
  filter(transect != "wte") %>% 
  mutate(transect = recode(transect, "wc" = 'wetland'), 
         horizon = factor(horizon, levels = c("O","A","B")),
         transect = factor(transect, levels = c("upland","transition","wetland"))) 

#boxplot bc why not
ggplot(data = tctn_data_full,
       aes(x = transect, y = TC_perc))+
  geom_boxplot()+
  geom_jitter(width = 0.2)

ggplot(data = tctn_data_full,
       aes(x = horizon, y = TC_perc))+
  labs(x = "Horizon",
       y = "Total Carbon (%)",
       title = "Total Carbon by Horizon",
       subtitle = "WLE, 2022")+
  facet_wrap(~region, scales = "free_x")+
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5, vjust = 0.5),
        legend.position = "right",
  )+
  geom_boxplot()+
  geom_jitter(width = 0.2)

###combining graphs
#piping to simplify
tc_hz_graph = 
  tctn_data_full %>% 
  ggplot(aes(x = horizon, y = TC_perc))+
  labs(x = "Horizon",
       y = "Total Carbon (%)",
       title = "Total Carbon by Horizon")+
  facet_wrap(~region, scales = "free_x")+
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5, vjust = 0.5),
        legend.position = "right")+
  geom_boxplot()+
  geom_jitter(width = 0.2)


tc_transect_graph = 
  tctn_data_full %>% 
  ggplot(aes(x = transect, y = TC_perc))+
  labs(x = "",
       y = "Total Carbon (%)",
       title = "Total Carbon by Transect")+
  facet_wrap(~region, scales = "free_x")+
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5),
        legend.position = "right")+
  geom_boxplot()+
  geom_jitter(width = 0.2)

#have to install patchwork for combining graphs
install.packages("patchwork")
library(patchwork)

#following syntax for patchwork
tc_transect_graph + tc_hz_graph
#use plot_layout(guides = "collect) to combine legends and add on to place it like...
#(tc_transect_graph + tc_hz_graph & theme (legnend.position = "top"))

#smoothed point plots
ggplot(data = tctn_data_full,
       aes(x = TC_perc, y = TN_perc,
           color = transect))+
  geom_point()+
  geom_smooth(method = "lm")

##we're going hard on boxplots
#TCC by Hz, WLE 2022
ggplot(data = tctn_data_full,
       aes(x = horizon, y = TC_perc))+
  geom_boxplot()+
  geom_jitter(width = 0.2)

#TCC of A Hz by Transect, WLE 2022
#####how do reorder the transect groups so it goes upland->transition->wetland??
ggplot(data = tctn_data_full,
       aes((x = reorder(upland, transition, wetland)), y = TC_perc))+
  geom_boxplot()+
  geom_jitter(width = 0.2)

#####will make duplicates of each of these with CB data when available
#####will also make a boxplot comparing range of TCC between WLE and CB

##C:N Line Graph
cn_line_graph =
  tctn_data_full %>% 
ggplot(aes(x = TC_perc, y = TN_perc))+
  labs(x = "Total Carbon (%)",
       y = "Total Nitrogen (%)",
       title = "C:N Across the TAIs")+
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5),
        legend.position = "right")+
  geom_point()+
  geom_smooth(method = "lm")

###to save at the end use ggsave
# ggsave()

ggsave("graphs/Total CN Line Graph.png",
       cn_line_graph,
       dpi = 300,
       width = 6,
       height = 4)

ggsave("graphs/Total Carbon by Transect.png",
       tc_transect_graph,
       dpi = 300,
       width = 6,
       height = 4)

ggsave("graphs/Total Carbon by Horizon.png",
       tc_hz_graph,
       dpi = 300,
       width = 6,
       height = 4)
