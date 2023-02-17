#shiny app doenerpreis
library(shiny)
library(tidyverse)

doener_data <- read.csv("./data/doener_data_shiny.csv", encoding = "latin1")

#ui
ui <- fluidPage(
  titlePanel("Ergebnisse Dönerpreisumfrage Q1 2023"),
  
  # Add reactive button to create histogram and summary statistics for Bundesland
  fluidRow(
    
    # Create a new Column for selectInputs
    column(4,
           selectInput("bundesland",
                       "Bundesland:",
                       c("All",
                         sort(unique(as.character(doener_data$bundesland))))),
           p("Im Dropdown-Menü kann nach Bundesländern gefiltert werden."),
           h3("Deskriptive Statistik"),
           verbatimTextOutput("price_summary")
    ),
    
    # Create a new Column for the price variable
    column(6,
           h3("Histogramm"),
           plotOutput("price_hist")
    )
  ),
  
  # Add heading and paragraph for raw data table
  fluidRow(
    column(12,
           h3("Rohdaten"),
           p('Die Daten werden entsprechend der obigen Auswahl im Dropdown-Menü gefiltert - um alle Daten anzuzeigen bitte "all" auswählen. Weiterhin können die einzelnen Spalten-Filter sowie die Suchfunktion verwendet werden')
    )
  ),
  
  
  # Create a new row for the table.
  DT::dataTableOutput("table")
)