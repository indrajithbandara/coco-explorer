library(here)
library(stringi)
library(tidyverse)

load(here("data", "raw_texts.rda"))

works <- raw_texts %>%
  map(compose(unlist, compose(stri_extract_all_words, stri_trans_tolower)))

save(works, file = here("data", "works.rda"))
