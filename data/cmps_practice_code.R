library(tidyverse)

# load files
tctn_data = read.csv("data/cmps_data/total_CNS.csv")
sample_key = read.csv("data/cmps_data/sample_key.csv")

# merge files
data = 
  tctn_data %>% 
  left_join(sample_key)

# graphs
data %>% 
  ggplot(aes(x = horizon, y = TC_perc, color = horizon))+
  geom_jitter(width = 0.3)+
  labs(title = "Total Carbon By Horizon",
       subtitle = "WLE",
       y = "Total C, %",
       )+
  theme_bw()+
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title = element_text(size = 12, family = "sans"),
        panel.border = element_rect(color = "grey70", size = 2)
        )+
  facet_wrap(~site)


# combining graphs

tc_graph = 
  data %>% 
  ggplot(aes(x = horizon, y = TC_perc, color = horizon))+
  geom_jitter()


tn_graph = 
  data %>% 
  filter(TN_perc < 6) %>% 
  ggplot(aes(x = horizon, y = TN_perc, color = horizon))+
  geom_jitter()

install.packages("patchwork")
library(patchwork)

(tc_graph + tn_graph & theme(legend.position = "top")) + 
  plot_layout(guides = "collect",
              )

tc_graph / tn_graph


gridExtra::grid.arrange(tc_graph, tn_graph, 
                        left = "Disp", bottom = "Hp // Cyl")


data %>% 
  filter()

ggsave("test_plot.png", width = 6, height = 3)
