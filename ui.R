library(shiny)

shinyUI(fluidPage(
    # Application title
    
    titlePanel("2014 Lending Club(TM) Note Data Explorer"),
    
    fluidRow(
        column(3,
               wellPanel(
                   selectInput("xcol", "Density x-variable", choices = selectableData),
                   checkboxInput("logEnabled", "log x-values", value = F)
               )
        ),
        column(9,
            wellPanel(
                plotOutput("main_plot")
            )
        )
    )
))