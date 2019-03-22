
library(tidyverse)
library(lubridate)
library(anomalize)
library(tibbletime)
library(shiny)
data("FANG")

shinyServer(function(input, output) {
  #common information for both graphs
  group_FANG <- reactive({
    req(input$symbols)
    req(input$targets)
    req(input$decomp_methods)
    req(input$anom_methods)
      FANG %>%
      filter(symbol == input$symbols)%>%
      time_decompose(target = input$targets, method = input$decomp_methods)%>%
      anomalize(target = remainder, method = input$anom_methods, 
                alpha = input$alpha_value,max_anoms =input$ max_anom_value)
  })
  #anomaly plot
  output$anomPlot <- renderPlot({
    group_FANG() %>%
      time_recompose()%>%
      plot_anomalies(time_recomposed = TRUE, 
                     color_no =input$not_anom_color, 
                     color_yes = input$anom_color, 
                     fill_ribbon = input$band_color, 
                     alpha_dots = input$dot_alpha, 
                     size_dots = input$dot_size)
  })
  #decomposition plot
  output$decompPlot <- renderPlot({
    group_FANG() %>%
      plot_anomaly_decomposition(ncol=2,
                                 color_no = input$not_anom_color, 
                                 color_yes = input$anom_color, 
                                 alpha_dots = input$dot_alpha,
                                 size_dots = input$dot_size , 
                                 strip.position = input$pos)
                                 
  })
  
})
