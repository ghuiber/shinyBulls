library(shiny)

# my class project
shinyUI(fluidPage(
    titlePanel(h3("Running of the Bulls 8K -- ages and paces by gender")),
    sidebarLayout(
        sidebarPanel(h4("Make your choices here"),
                     p("You can plot paces and ages for a given year or group of years, separately by gender."), 
                     radioButtons("radio", label = h4("Ages, paces, or both:"),
                                  choices = list("Show ages as a pair of bar plots of age groups, one for each gender." = 1, 
                                                 "Show density plots of paces by gender, overlaid with vertical bars at the means." = 2,
                                                 "Show box plots of paces by age group." = 3),selected = 1),  
                     checkboxGroupInput("checkYear", 
                                        label = h4("Data from:"), 
                                        choices = list(2011,2012,2013,2014,2015),
                                        selected = 2011),
                     actionButton("getYears", "Go")),
        mainPanel(
            plotOutput("den")
        )
    )
))
