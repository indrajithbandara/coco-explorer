library(tidyverse)

library(janeaustenr)
#devtools::install_github("mhenderson/thomashardyr")
library(thomashardyr)
#devtools::install_github("mhenderson/dhlawrencer")
library(dhlawrencer)

library(stringi)

hardy_words <- unlist(stri_extract_all_words(stri_trans_tolower(hardy_books()$text)))
lawrence_words <- unlist(stri_extract_all_words(stri_trans_tolower(lawrence_books()$text)))
austen_words <- unlist(stri_extract_all_words(stri_trans_tolower(austen_books()$text)))

library(CorporaCoCo)

nodes <- c('back', 'eye', 'eyes', 'forehead', 'hand', 'hands', 'head', 'shoulder')

f <- compose(as.tibble, partial(surface_coco, span = '5LR', nodes = nodes, fdr = 0.01))

left_corpora <- c("austen", "austen", "hardy", "hardy", "lawrence", "lawrence")
right_corpora <- c("hardy", "lawrence", "lawrence", "austen", "hardy", "austen")

tibble(
  left = left_corpora,
  right = right_corpora,
  results = list(
    f(austen_words, hardy_words),
    f(austen_words, lawrence_words),
    f(hardy_words, austen_words),
    f(hardy_words, lawrence_words),
    f(lawrence_words, austen_words),
    f(lawrence_words, hardy_words)
  )) %>%
  unnest() %>%
  mutate(
    label = map2_chr(
      x,
      y,
      ~ paste(format(.x, justify = "right", width = 10), format(.y, justify = "left", width = 10))
    )
  ) ->
  results

save(results, file = here("data/results.rda"))
