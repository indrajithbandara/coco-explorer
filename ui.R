library(plotly)
library(shiny)

ggplot2::theme_set(hrbrthemes::theme_ipsum())

corpora <- list(
  "19th Century Novels" = "19C",
  "Jane Austen" = "austen",
  "Charles Dickens" = "DNov",
  "Thomas Hardy" = "hardy",
  "D. H. Lawrence" = "lawrence"
)

left_default <- "austen"
right_default <- "hardy"

shinyUI(fluidPage(
  
  titlePanel("Corpus Co-occurrence Explorer"),
  
  sidebarLayout(
    sidebarPanel(
      width = 3,
      selectInput(
        inputId = "left_corpus",
        label = h3("Left corpus"), 
        choices = corpora, 
        selected = left_default
      ),
      selectInput(
        inputId = "right_corpus",
        label = h3("Right corpus"), 
        choices = corpora, 
        selected = right_default
      ),
      textInput(
        inputId = "nodes",
        label = h3("Nodes"),
        value = "back eye eyes forehead hand hands head shoulder"
      ),
      sliderInput(
        inputId = "span",
        label = h3("Span"),
        min = -5, 
        max = 5,
        value = c(-5, 5)
      ),
      numericInput(
        inputId = "fdr",
        label = h3("False Discovery Rate"),
        min = 0.01,
        max = 1,
        step = 0.01,
        value = 0.02
      )
    ),
    
    mainPanel(
      width = 9,
       plotlyOutput(
         outputId = "coco_plot",
         height = "800px"
       )
    )
  )
))
