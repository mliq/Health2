shinyUI(navbarPage("IPD International $1 Billion Challenge 2014",
                   tabPanel("YTD",
                            fluidPage(
                              title="IPD International $1 Billion Challenge 2014", 
                              img(src="600x100.jpg"),
                              hr(),
                              htmlOutput('myMap'),
                              fluidRow(
                                column(3,
                                       selectInput("select", label = h3("Select Contest Duration"), 
                                                    choices = list("YTD" = 1, "HTD" = 2)
                                                   , selected = 1)
                                         
                                ),
                                column(4,
                                       img(src="legend3.png")
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
                            ),
                   tabPanel("HTD"
                           )
  ))