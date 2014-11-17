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
                                #column(4, 
                                #       h4("Select A Country for Summary:"),
                                #       uiOutput("cSelector"),
                                #       tableOutput('myTable2'),
                                #       h4(htmlOutput('text1'))
                                #),
                                column(12,
                                       h4("Data Table (sortable) - Updated through October 2014*"),
                                       h5("*Only countries/territories that meet OI requirement (2013 OI < 2014 OI) appear on this table. "),
                                       h5("Countries listed in the table will only be eligible if they meet  OP by end of year. "),
                                       htmlOutput('myTable')
                                )
                              )
                            )                          
                            )
  ))