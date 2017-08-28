#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(here)
library(plotly)
library(shiny)
library(tidyverse)

load(here("data/results.rda"))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  results_ <- reactive({
    results %>%
      filter(left == input$left_corpus) %>%
      filter(right == input$right_corpus) %>%
      filter(x %in% unlist(strsplit(input$nodes, split = " "))) %>%
      arrange(x, effect_size) %>%
      mutate(n = row_number())
  })
  
  output$coco_plot <- renderPlotly({
    results_() %>%
      ggplot(aes(reorder(paste(x, y), n), effect_size)) +
      geom_point(colour = "skyblue4") +
      geom_errorbar(aes(ymin = CI_lower, ymax = CI_upper), colour = "seashell4") +
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
