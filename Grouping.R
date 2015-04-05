library(dplyr)
dtf %>% group_by(Id, RadarSeries, Mean) %>%
    summarise_each(funs(max))

dtf %>% group_by(Id) %>%
       filter(Mean==max(Mean))
