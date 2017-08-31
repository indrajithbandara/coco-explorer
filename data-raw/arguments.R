library(here)
library(tidyverse)

load(here("data", "works.rda"))

arguments <- data_frame(
  left = names(works),
  right = names(works)
  ) %>%
  expand(
    left,
    right,
    fdr = c(0.01, 0.02),
    span = cross2(1:5, 1:5) %>% map(unlist) %>% map_chr(to_span_string)
  )

save(arguments, file = here("data", "arguments.rda"))
