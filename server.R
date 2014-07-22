library(shiny)

# what I need for my assignment
load('data/bulls.rda')

# what I need to do for the Shiny tutorial
# this was lesson 4
shinyServer(function(input, output) {
    output$text1 <- renderText({ 
        paste("You have selected", input$var)
    })
    output$text2 <- renderText({ 
        paste("You have chosen a range that goes from", 
              input$range[1],"to",input$range[2])
    })
})

# now lesson 5
# code that runs once when app is launched
# (getting ready for visitors)
library(maps)
library(mapproj)
counties <- readRDS("data/counties.rds")
source("helpers.R")

# this unnamed function runs every time
# the app is visited
shinyServer(function(input, output) {
    # code that runs once per visit goes here
    output$map <- renderPlot({ 
        # code that runs when visitors changes
        # an input widget goes here
        data <- switch(input$var, 
                       "Percent White" = counties$white,
                       "Percent Black" = counties$black,
                       "Percent Hispanic" = counties$hispanic,
                       "Percent Asian" = counties$asian)  
        percent_map(var = data, color = "darkgreen", legend.title = input$var, 
                    max = input$range[2], min = input$range[1])
    })
})
