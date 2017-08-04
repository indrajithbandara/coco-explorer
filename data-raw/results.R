library(CorporaCoCo)
library(here)
library(janeaustenr)
library(stringi)

#devtools::install_github("mhenderson/thomashardyr")
library(thomashardyr)
#devtools::install_github("mhenderson/dhlawrencer")
library(dhlawrencer)

nodes <- c('back', 'eye', 'eyes', 'forehead', 'hand', 'hands', 'head', 'shoulder')

hb <- hardy_books()
lb <- lawrence_books()
ja <- austen_books()

hardy_words <- unlist(stri_extract_all_words(stri_trans_tolower(hb$text)))
lawrence_words <- unlist(stri_extract_all_words(stri_trans_tolower(lb$text)))
austen_words <- unlist(stri_extract_all_words(stri_trans_tolower(ja$text)))

library(tidyverse)

corpora <- tibble(words = list(hardy_words, lawrence_words, austen_words))

f <- compose(as.tibble, partial(surface_coco, span = '5LR', nodes = nodes, fdr = 0.01))

results_hardy <- purrr::map(corpora$words, partial(f, b = hardy_words))
names(results_hardy) <- c("hardy", "lawrence", "austen")

results_lawrence <- purrr::map(corpora$words, partial(f, b = lawrence_words))
names(results_lawrence) <- c("hardy", "lawrence", "austen")

results_austen <- purrr::map(corpora$words, partial(f, b = austen_words))
names(results_austen) <- c("hardy", "lawrence", "austen")

results <- tibble(hardy = results_hardy, lawrence = results_lawrence, austen = results_austen)

save(results, file = here("data", "results.rda"))
