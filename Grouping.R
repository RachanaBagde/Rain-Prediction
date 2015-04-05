library(dplyr)
dtt %>% group_by(Id, RadarSeries, Mean) %>%
    summarize_each(funs(max))
