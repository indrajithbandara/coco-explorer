library(here)
library(tidyverse)

load(here("data", "arguments.rda"))
load(here("data", "works.rda"))

source(here("R", "coco_tibble.R"))

arguments %>%
#  slice(33:40) %>%
  mutate(results = pmap(., compose(as.tibble, partial(coco_tibble, works = works)))) %>%
  unnest() %>%
  mutate(
    label = map2_chr(
      x,
      y,
      ~ paste(format(.x, justify = "right", width = 10), format(.y, justify = "left", width = 10))
    )
  ) ->
  results

src_sqlite(here("data", "results.sqlite3"), create = TRUE) %>%
  copy_to(results, temporary = FALSE, overwrite = TRUE)
