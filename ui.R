shinyUI(navbarPage("IPD International $1 Billion Challenge 2014",
                   tabPanel("YTD",
                            fluidPage(
                              title="IPD International $1 Billion Challenge 2014", 
                              img(src="600x100.jpg"),
                              hr(),
                              htmlOutput('myMap'),
                              fluidRow(
                                column(3,
                                       sliderInput('year', 'Map Year',format ="####",  min=2010, max=2012, value=2012, 
                                                   step=1)
                                ),
                                column(4,
                                       h5("Legend:", "100", {img(src="legend.png")}, "4000")
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