library(shiny)
library(ggplot2)

shinyServer(function(input, output, session) {
    
    selectedData <- reactive({
        input$xcol
    })
    
    output$main_plot <- renderPlot({
        
        
            plot0 <- ggplot(data = notes_charged_full_paid, aes_string(x = selectedData(), color = "loan_status")) +
                geom_density(aes(y=..density.., fill = loan_status), alpha = 0.2)
            #facet_grid(. ~ purpose)
            if(input$logEnabled){
                plot0 <- plot0 + scale_x_log10()
            }
            plot0
    })
    
    output$var_table <- renderUI({
        inclRmd("vartable.Rmd")
    })
})