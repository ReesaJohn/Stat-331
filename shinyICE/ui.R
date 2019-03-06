

# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).

library(tidyverse)
titanic  <- read_csv("https://www.dropbox.com/s/volbfu8onyvjcri/titanic.csv?dl=1")


# Use a fluid Bootstrap layout
fluidPage(    
  # Give the page a title
  titlePanel("Titanic Fare by Gender and Passenger Class"),
  # Generate a row with a sidebar
  sidebarLayout(      
    # Define the sidebar with one input
    sidebarPanel(
      selectInput(inputId= "class",label = "Class:", 
                  choices= titanic %>%
                    select(Pclass)%>%
                    distinct(Pclass)%>% 
                    arrange(Pclass), selected = 1),
      hr(),
      helpText("Data from Titanic passenger lists")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("classPlot")  
    )
    
    )

  )

