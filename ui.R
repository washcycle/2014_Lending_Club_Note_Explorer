library(shiny)

shinyUI(fluidPage(
    # Application title
    
    titlePanel("2014 Lending Club(TM) Note Data Explorer"),
    
    fluidRow(
        column(3,
               wellPanel(
                   selectInput("xcol", "Density x-variable", choices = selectableData),
                   checkboxInput("logEnabled", "log x-values", value = F)
               ),
               wellPanel(
                   h4("Instructions"),
                   "Pick an x variable above to compare the density distributions for notes that were fully paid or charged off."
               )
        ), # end of col 3
        column(9,
            wellPanel(
                plotOutput("main_plot")
            ),
            wellPanel(
                uiOutput("var_table")
            )
        ) # end of col 9
    )
))