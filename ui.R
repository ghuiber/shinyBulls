library(shiny)

# you can define as many shinyUI() functions as you want.
# only the last one will be considered by runApp().
# so, just change the order of your definitions accordingly:
# e.g., to see your choices of widgets move the shinyUI()
# definition that displays them to the bottom of the script. 

# my choices of widgets
shinyUI(fluidPage(
    titlePanel("Basic widgets"),
    
    fluidRow(
        
        column(3,
               h3("Buttons"),
               actionButton("action", label = "Action"),
               br(),
               br(), 
               submitButton("Submit")),
        
        column(3,
               h3("Single checkbox"),
               checkboxInput("checkbox", label = "Choice A", value = TRUE)),
        
        column(3, 
               checkboxGroupInput("checkGroup", 
                                  label = h3("Checkbox group"), 
                                  choices = list("Choice 1" = 1, 
                                                 "Choice 2" = 2, "Choice 3" = 3),
                                  selected = 1)),
        
        column(3, 
               dateInput("date", 
                         label = h3("Date input"), 
                         value = ))   
    ),
    
    fluidRow(
        
        column(3,
               dateRangeInput("dates", label = h3("Date range"))),
        
        column(3,
               fileInput("file", label = h3("File input"))),
        
        column(3, 
               h3("Help text"),
               helpText("Note: help text isn't a true widget,", 
                        "but it provides an easy way to add text to",
                        "accompany other widgets.")),
        
        column(3, 
               numericInput("num", 
                            label = h3("Numeric input"), 
                            value = 1))   
    ),
    
    fluidRow(
        
        column(3,
               radioButtons("radio", label = h3("Radio buttons"),
                            choices = list("Choice 1" = 1, "Choice 2" = 2,
                                           "Choice 3" = 3),selected = 1)),
        
        column(3,
               selectInput("select", label = h3("Select box"), 
                           choices = list("Choice 1" = 1, "Choice 2" = 2,
                                          "Choice 3" = 3), selected = 1)),
        
        column(3, 
               sliderInput("slider1", label = h3("Sliders"),
                           min = 0, max = 100, value = 50),
               sliderInput("slider2", "",
                           min = 0, max = 100, value = c(25, 75))
        ),
        
        column(3, 
               textInput("text", label = h3("Text input"), 
                         value = "Enter text..."))   
    )
    
))

# what I want to do as class project
shinyUI(fluidPage(
    titlePanel(h3("Running of the Bulls 8K -- ages and paces by gender")),
    sidebarLayout(
        sidebarPanel(h4("Make your choices here:"),
                     p("You can plot paces and ages for a given year or group of years, separately by gender."), 
                     p("You can show ages as a pair of bar plots of age groups, one for each gender."),
                     p("You can show paces as a pair of histograms, each overlaid with an empirical distribution curve and one choice of some common probability distributions with parametes estimated by maximum likelihood from the data."),
                     p("Finally, paces can be plotted by age group, as a box plot."),
                     checkboxGroupInput("checkGroup", 
                                        label = h4("Data from"), 
                                        choices = list(2011,2012,2013,2014),
                                        selected = 2011),
                     radioButtons("radio", label = h4("Ages, paces, or both"),
                                  choices = list("Ages (bar plot)" = 1, 
                                                 "Paces (histogram with density curves overlaid)" = 2,
                                                 "Both (box plots)" = 3),selected = 1)),   
        mainPanel("Durham, ",
                  code("NC 2011-2014"),
                  p("A new paragraph?"),
                  div("In blue?",p("Another paragraph?",
                                   em("How about now?")), style="color:blue"))
    )
))

# what I need to do for the Shiny tutorial

# lesson 4
shinyUI(fluidPage(
    titlePanel("censusVis"),
    sidebarLayout(
        sidebarPanel(helpText("Create demographic maps with information from the 2010 US Census"),
                     selectInput("var", label = h5("Choose a variable to display"), 
                                 choices = c("Percent White", 
                                             "Percent Black",
                                             "Percent Hispanic",
                                             "Percent Asian"), selected = "Percent White"),
                     sliderInput("range", label=h5("Range of interest:"),
                                 min = 0, max = 100, value = c(0, 100))
        ),
        mainPanel(
            textOutput("text1"),
            textOutput("text2")
        )
    )
))

# lesson 5
shinyUI(fluidPage(
    titlePanel("censusVis"),
    sidebarLayout(
        sidebarPanel(helpText("Create demographic maps with information from the 2010 US Census"),
                     selectInput("var", label = h5("Choose a variable to display"), 
                                 choices = c("Percent White", 
                                             "Percent Black",
                                             "Percent Hispanic",
                                             "Percent Asian"), selected = "Percent White"),
                     sliderInput("range", label=h5("Range of interest:"),
                                 min = 0, max = 100, value = c(0, 100))
        ),
        mainPanel(
            plotOutput("map")
        )
    )
))