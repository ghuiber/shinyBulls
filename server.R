library(shiny)

# code that runs once when app is launched
# (getting ready for visitors)
load('data/bulls.rda')
source("helpers.R")

# this unnamed function runs every time
# the app is visited
shinyServer(function(input, output) {
    # code that runs once per visit goes here
    yearsInput <- reactive({
        years <- input$checkYear
        tag <- NULL
        if(length(years)==1) {
            df  <- subset(bulls,Year==years)
            tag <- years
        } else if(length(years)==0) {
            df  <- bulls
            tag <- 'all years combined'
        } else {
            df <- subset(bulls,Year %in% years)
            tag <- paste('years',paste(years,collapse=', '),sep=' ')
        }
        out <- list(df,tag)
    })
    output$den <- renderPlot({ 
        # code that runs when visitors changes
        # an input widget goes here
        input$getYears
        isolate(plotIt(input$radio,yearsInput()))
    })
})
