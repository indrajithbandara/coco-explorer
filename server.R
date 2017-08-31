library(dplyr)
library(ggplot2)
library(here)
library(plotly)
library(shiny)

src_sqlite(here("data", "results.sqlite3")) %>%
  tbl("results") -> results

source(here("R", "to_span_string.R"))

shinyServer(function(input, output) {
   
  results_ <- reactive({
    results %>%
      filter(left == input$left_corpus) %>%
      filter(right == input$right_corpus) %>%
      filter(fdr %in% input$fdr) %>%
      collect() %>%
      filter(span == to_span_string(abs(input$span))) %>%
      filter(x %in% unlist(strsplit(input$nodes, split = " "))) %>%
      arrange(x, effect_size) %>%
      mutate(n = row_number())
  })
  
  output$coco_plot <- renderPlotly({
    results_() %>%
      ggplot(aes(reorder(paste(x, y), n), effect_size)) +
      geom_point(colour = "skyblue4") +
      geom_errorbar(aes(ymin = CI_lower, ymax = CI_upper), colour = "skyblue4") +
      coord_flip() +
      labs(
        x = "",
        y = "Effect size"
      ) +
      theme(
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.y  = element_text(family = "monospace")
      ) +
      geom_hline(yintercept = 0, colour = "grey", linetype = 2, size = 0.5) -> p
    ggplotly(p)
  })
  
})
