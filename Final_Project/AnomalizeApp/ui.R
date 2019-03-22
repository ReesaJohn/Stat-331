#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(tidyverse)
library(lubridate)
library(anomalize)
library(tibbletime)
library(shiny)
library(colourpicker)
library(shinythemes)
data("FANG")

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("flatly"),
  
  # Application title
  titlePanel("Anomaly Detection with Anomalize"),
  
  # Sidebar with various inputs
  sidebarLayout(
    sidebarPanel(
      #data
      wellPanel(
        h3("Time Series Data"),
        
        selectInput(inputId = "symbols", label = "Stocks", 
                    choices = c("Facebook"= "FB", 
                                "Amazon"= "AMZN", 
                                "Netflix"= "NFLX", 
                                "Google"= "GOOG"), 
                    selected = "FB", multiple = FALSE,
                    selectize = FALSE, width = NULL, size = NULL),
        
        selectInput(inputId = "targets", label = "Detect Anomalies in:",
                    choices = c("Open: Stock price at the open of trading, in USD"="open",
                                "Close: Stock price at the close of trading, in USD" = "close", 
                                "High: Stock price at the highest point during trading, in USD" = "high", 
                                "Low: Stock price at the lowest point during trading, in USD" = "low", 
                                "Adjusted: Volume: Number of shares traded" = "volume", 
                                "Stock price at the close of trading adjusted for stock splits, in USD"= "adjusted"),
                    selected = "stl", multiple = FALSE,
                    selectize = FALSE, width = NULL, size = NULL)
      ),
      #function inputs
      tabsetPanel(type = "tabs",
            
            tabPanel(
              "Decomposition",
              wellPanel(
              h3("Decomposition"),
              selectInput(inputId = "decomp_methods", label = "Decomposition Method",
                          choices = c("stl","twitter"),
                          selected = "stl", multiple = FALSE,
                          selectize = FALSE, width = NULL, size = NULL)
              )
              
            ),
            tabPanel(
              
              "Anomaly Detection",
                wellPanel(
                h3("Anomaly Detection"),
                selectInput(inputId = "anom_methods", label = "Anomaly Detection Methods",
                            choices = c("iqr","gesd"),
                            selected = "iqr", multiple = FALSE,
                            selectize = FALSE, width = NULL, size = NULL),
                
                sliderInput(inputId = "alpha_value", 
                            label= "Alpha", min = 0.025, 
                            max = 0.1,
                            value = 0.05),
                sliderInput(inputId = "max_anom_value", 
                            label= "Maximum Percentage of Anomalies Allowed", min = 0.01, 
                            max = 0.5,
                            value = 0.2)
              )
            ),
            tabPanel(
                      "General Plot Aesthetics",
                  wellPanel(
                     h3("General Plot Aesthethics"),
                     colourInput(inputId = "not_anom_color", label = "Dot Color", 
                                 value = "#2c3e50", showColour = "background"),
                     colourInput(inputId = "anom_color", label = "Anomaly Color", 
                                 value = "#e31a1c", showColour = "background"),
                     sliderInput(inputId = "dot_alpha", 
                                 label= "Dot Alpha", min = 0, 
                                 max = 1,
                                 value = 1),
                     sliderInput(inputId = "dot_size", 
                                 label= "Dot Size", min = 1, 
                                 max = 4.5,
                                 value = 1.5)
                    
                  )
                  
              ),
              tabPanel("Plot-Specific Aesthetics",
                wellPanel(
                  h3("Anomaly Plot-Specific"),
                  
                  colourInput(inputId = "band_color", label = "Band Color", 
                              value = "#b3b3b3", showColour = "background")
                ),
                wellPanel(
                  h3("Decomposition Plot-Specific"),
                  selectInput(inputId = "pos", label = "Label Position",
                              choices = c("top", "bottom", "left", "right"),
                              selected = "top", multiple = FALSE,
                              selectize = FALSE, width = NULL, size = NULL)
                
              )
          )
       )
    ),
    
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel(title= "Anomaly Plot",
                           h2("Anomaly Plot"),
                           br(),
                           plotOutput("anomPlot")
                  ),
     
                  tabPanel(title = "Decomposition Plot",
                           h2("Decomposition Plot"),
                           br(),
                           plotOutput("decompPlot")
                  )
      )
    )
  )
 )
)


