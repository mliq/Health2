shinyUI(navbarPage("HealthMap",
                   tabPanel("App",
                            fluidPage(
                              title="Health Expenditure Per Capita (Current US$)", 
                              h2("Health Expenditure Per Capita (Current US$)"),
                              h6("Source:", {a("World Bank", href="http://data.worldbank.org/indicator/SH.XPD.PCAP/countries?display=default")},
                              " | ","Code:", {a("https://github.com/mliq/HealthMap", href="https://github.com/mliq/HealthMap")}),
                              #htmlOutput('myMap'),
                              #h4("Legend:", "100", {img(src="legend.png")}, "4000"),
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
                   tabPanel("Overview / Help",
                            h3("Purpose"),
                            helpText("This app is intended for use by International Healthcare marketers and corporations interested in tracking growth in healthcare spending in different markets, or for segmenting healthcare markets. It can be easily adapted to use company-specific data instead of national data."),
                            h3("Usage & Features"),
                            h4("Map"),
                            helpText("At top a chloropleth world map is displayed which colors nations based on Annual Healthcare Spending Per Capita by country for 2010, 2011, or 2012. 2012 is the default, and below the map is a slider to change the year of data reflected in the map. To the right of the slider is the legend, indicating that red are countries with low spending, yellow in the middle, and green for the highest spending countries. Hovering with the mouse over any country in the map displays the name of the country and the corresponding data.")
                            ,h4("Calculations"),
                            helpText("Below the map is a \"Calculate Growth Rates\" widget which allows the user to select a country, either by drop-down selection or by clicking and typing in a name. That country's Annual Healthcare Spending Per Capita data will then be displayed, and below that the percentage annual growth rates are calculated and displayed. Below this table the average of the two annual growth rates is calculated and displayed."),
                            h4("Data Table"),
                            helpText("To the right of this widget is the complete data table with the countries and their annual spending in each year. This table is sortable by clicking on the column heading for both ascending or descending sort.")
                            )
  ))