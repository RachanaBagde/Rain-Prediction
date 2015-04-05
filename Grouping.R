library(dplyr)
dtf %>% group_by(Id, RadarSeries, Mean) %>%
    summarize_each(funs(max))
