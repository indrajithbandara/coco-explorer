library(here)
library(tidyverse)

library(janeaustenr)
#devtools::install_github("mhenderson/thomashardyr")
library(thomashardyr)
#devtools::install_github("mhenderson/dhlawrencer")
library(dhlawrencer)

library(stringi)

library(CorporaCorpus)

raw_texts <- list(
  "hardy" = hardy_books()$text,
  "lawrence" = lawrence_books()$text,
  "austen" = austen_books()$text,
  "DNov" = unlist(lapply(corpus_filepaths('DNov'), readLines)),
  "19C" = unlist(lapply(corpus_filepaths('19C'), readLines))
) 

works <- raw_texts %>%
  map(~unlist(stri_extract_all_words(stri_trans_tolower(.))))

library(CorporaCoCo)

nodes <- c('back', 'eye', 'eyes', 'forehead', 'hand', 'hands', 'head', 'shoulder')

f <- compose(as.tibble, partial(surface_coco, span = '5LR', nodes = nodes, fdr = 0.01))

as.tibble(expand.grid(left = names(works), right = names(works))) %>%
  mutate(results = map2(left, right, ~ f(works[[.x]], works[[.y]]))) %>%
  unnest()  %>%
  mutate(
    label = map2_chr(
      x,
      y,
      ~ paste(format(.x, justify = "right", width = 10), format(.y, justify = "left", width = 10))
    )
  ) ->
  results

save(results, file = here("data/results.rda"))
