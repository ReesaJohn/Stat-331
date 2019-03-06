# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(tidyverse)
titanic  <- read_csv("https://www.dropbox.com/s/volbfu8onyvjcri/titanic.csv?dl=1")

# Define a server for the Shiny app
function(input, output) {
  
  # Fill in the spot we created for a plot
  output$classPlot <- renderPlot({
    
    titanic %>%
      filter(Pclass == input$class)%>%
      ggplot(aes(x=Fare, fill =Sex ))+geom_density(alpha = 0.5, color = "black")
    # Render a barplot
  })
}

