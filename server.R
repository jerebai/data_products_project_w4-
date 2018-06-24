# Coursera project Data products week 4
# by holger speckter (jerebai)
# 15/06/2018
# Theme: Price vs Carat of Dimaonds Chart
# Server file
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(tidyverse)
library(curl)

### erver logic

shinyServer(function(input, output) {
  
  ## load the data for diamonds
  
  data(diamonds)
  
  ## output function 
  
  output$distPlot <- renderPlot({
    
    # subset based on set filter
    
    diamonds_sub <-
      subset(
        diamonds,
        cut == input$cut &
          color == input$color &
          clarity == input$clarity
      )
    
    # plot the dimaond data based on carat / price
    
    p <-
      ggplot(data = diamonds_sub, aes(x = carat, y = price)) + geom_point()
    p <-
      p + geom_smooth(method = "lm") + xlab("Carat") + ylab("Price")
    p <- p + xlim(0, 6) + ylim (0, 20000)
    p
  }, height = 700)
  
  # price summary functions
  
  output$summary <- renderPrint({
    diamonds_sub <-
      subset(
        diamonds,
        cut == input$cut &
          color == input$color &
          clarity == input$clarity
      )
    
    summary(diamonds_sub$price)
  })
  
  # linear model function
  
  output$predict <- renderPrint({
    diamonds_sub <-
      subset(
        diamonds,
        cut == input$cut &
          color == input$color &
          clarity == input$clarity
      )
    
    fit <- lm(price~carat,data=diamonds_sub)
    
    unname(predict(fit, data.frame(carat = input$lm)))
  })
  
  # filter function to reset
  
  observeEvent(input$showall, {
    distPlot <<- NULL
    
    output$distPlot <- renderPlot({
      p <-
        ggplot(data = diamonds, aes(x = carat, y = price)) + geom_point()
      p <-
        p + geom_smooth(method = "lm") + xlab("Carat") + ylab("Price")
      p <- p + xlim(0, 6) + ylim (0, 20000)
      p
    }, height = 700)
    
    # price summary
    
    output$summary <- renderPrint(summary(diamonds$price))
    
    # linear model
    
    output$predict <- renderPrint({
      
      fit <- lm(price~carat,data=diamonds)
      
      unname(predict(fit, data.frame(carat = input$lm)))
    })
    
    
  })
  
  # filter function / re apply
  
  observeEvent(input$appfil, {
    distPlot <<- NULL
    
    output$distPlot <- renderPlot({
      # subset the date based on the inputs
      
      diamonds_sub <-
        subset(
          diamonds,
          cut == input$cut &
            color == input$color &
            clarity == input$clarity
        )
      
      # plot the diamonds data and its influence regarding carat and price
      p <-
        ggplot(data = diamonds_sub, aes(x = carat, y = price)) + geom_point()
      p <-
        p + geom_smooth(method = "lm") + xlab("Carat") + ylab("Price")
      p <- p + xlim(0, 6) + ylim (0, 20000)
      p
    }, height = 700)
    
    # price summary
    
    output$summary <- renderPrint({
      diamonds_sub <-
        subset(
          diamonds,
          cut == input$cut &
            color == input$color &
            clarity == input$clarity
        )
      
      summary(diamonds_sub$price)
    })
    
    # linear model
    
    output$predict <- renderPrint({
      diamonds_sub <-
        subset(
          diamonds,
          cut == input$cut &
            color == input$color &
            clarity == input$clarity
        )
      
      fit <- lm(price~carat,data=diamonds_sub)
      
      unname(predict(fit, data.frame(carat = input$lm)))
    })
    
  })
  
})