shinyUI(navbarPage("IPD International $1 Billion Challenge",
                   tabPanel("2014",
                            fluidPage(
                              title="IPD International $1 Billion Challenge 2014", 
                              img(src="600x100.jpg"),
                              hr(),
                              htmlOutput('myMap'),
                              fluidRow(
                                column(3,
                                       selectInput("adjust", label = h3("Select Contest"), 
                                                    choices = list("YTD Absolute $" = 1, "HTD LC%" = 2)
                                                   , selected = 1)
                                         
                                )
                              ),
                              fluidRow(
                                column(4, 
                                       h4("Calculate Growth Rates"),
                                       uiOutput("cSelector"),
                                       tableOutput('myTable2'),
                                       h4(htmlOutput('text1'))
                                ),
                                column(4,
                                       h4("Data Table (sortable)"),
                                       htmlOutput('myTable')
                                )
                              )
                            )                          
                            )
  ))