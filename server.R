#shiny app doenerpreis
library(shiny)
library(tidyverse)

doener_data <- read.csv("./data/doener_data_shiny.csv", encoding = "latin1")

#server
server <- function(input, output, session) {
  
  
  
  # Filter data based on selections
  filtered_data <- reactive({
    daten <- doener_data
    if (input$bundesland != "All") {
      daten <- daten[daten$bundesland == input$bundesland,]
    }
    daten
  })
  
  # Generate the histogram
  output$price_hist <- renderPlot({
    ggplot(filtered_data(), aes(x = preis)) + 
      geom_histogram(color = "darkgreen", fill = "lightgreen", binwidth = 0.5) +
      xlab("Preis") +
      ylab("Häufigkeit") +
      ggtitle("Verteilung der Dönerpreise im ausgewählten Gebiet") +
      theme_classic()
  })
  
  # Generate the summary statistics
  output$price_summary <- renderPrint({
    summary(filtered_data()$preis)
  })
  
  # Show the filtered data
  output$table <- DT::renderDataTable({
    DT::datatable(filtered_data(), filter = "top")
  })
}
