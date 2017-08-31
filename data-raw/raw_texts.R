library(janeaustenr)
#devtools::install_github("mhenderson/thomashardyr")
library(thomashardyr)
#devtools::install_github("mhenderson/dhlawrencer")
library(dhlawrencer)

library(CorporaCorpus)

raw_texts <- list(
  "hardy" = hardy_books()$text,
  "lawrence" = lawrence_books()$text,
  "austen" = austen_books()$text,
  "DNov" = unlist(lapply(corpus_filepaths('DNov'), readLines)),
  "19C" = unlist(lapply(corpus_filepaths('19C'), readLines))
)

save(raw_texts, file = here("data", "raw_texts.rda"))
