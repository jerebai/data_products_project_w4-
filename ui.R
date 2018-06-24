# Coursera project Data products week 4
# by holger speckter (jerebai)
# 15/06/2018
# Theme: Price vs Carat of Dimaonds Chart


library(shiny)
library(ggplot2)

# load data for diamonds

data("diamonds")

# Define UI dimaonds for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("Price vs Carat Relationship for Diamonds"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      h5("Filter:"),
      
      selectInput("color",
                  "Color",
                  (sort(
                    unique(diamonds$color)
                  ))),
      selectInput("clarity",
                  "Clarity",
                  (sort(
                    unique(diamonds$clarity), decreasing = T
                  ))),
      selectInput("cut",
                  "Cut",
                  (sort(
                    unique(diamonds$cut), decreasing = T
                  ))),
      
      actionButton("showall",
                   "Show All"),
      
      actionButton("appfil",
                   "Filter Mode"),
      
      h5("Price Summary/Expected"),
      
      verbatimTextOutput("summary"),
      
      sliderInput(
        "lm",
        "Carat",
        min = min(diamonds$carat),
        max = max(diamonds$carat),
        value = max(diamonds$carat) / 2,
        step = 0.1
      ),
      
      h4("Predicted Price"),
      
      verbatimTextOutput("predict"),
      
      width = 4
    ),
    
    # Show a plot of the carat/price relationship
    
    mainPanel(tabsetPanel(
      tabPanel("Plot", plotOutput("distPlot")),
      
      tabPanel(
        "Documentation/Info",
        br(),
        
        helpText(
          "This small shiny app helps you to determine the relationship of colour, carat and cut of diamonds vs. price. 
This is a simple and basic linear model to display this relationship, based on a filter set by the selected setting of the data and price prediction."
        ),
        
        br(),
        
        helpText(
          "You can set the filter to show details of a specific diamond setting or to show all dataset.
With FILTR MODE you can go back to the filters."
        ),
        
        br(),
        
        helpText(
          "The Data Summary is displayed and a price can be predicted/expted by selected filter options, based on the subset of the data and choosing diamond carat value.
Colour, Clairty and cut are the filter options. Play around with it to get results.
          "
        )),
      
      tabPanel(
        "Data Description",
        
        br(),
        
        helpText("Details to the Data can be found here:"),
        
        br(),
        
        tags$a(
          "http://ggplot2.tidyverse.org/reference/diamonds.html",
          href = "http://ggplot2.tidyverse.org/reference/diamonds.html"
        )
      )
      
        ))
    )
  ))