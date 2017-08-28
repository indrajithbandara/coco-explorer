#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

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
right_default <- "19C"

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Corpus Co-occurrence Explorer"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
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
      radioButtons(
        inputId = "nodes",
        label = h3("Nodes"),
        choices = list(
          "Body parts (back, eye, eyes, forehead, hand, hands, head, shoulder)" = c('back', 'eye', 'eyes', 'forehead', 'hand', 'hands', 'head', 'shoulder')
        )
      ),
      sliderInput(
        inputId = "span",
        label = h3("Span"),
        min = -10, 
        max = 10,
        value = c(-5, 5)
      ),
      numericInput(
        inputId = "fdr",
        label = h3("False Discovery Rate"),
        min = 0.01,
        max = 1,
        step = 0.01,
        value = 0.01
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotlyOutput("coco_plot")
    )
  )
))
