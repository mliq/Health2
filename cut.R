#Calculation Table
output$myTable2 <- renderTable(table(input$country),include.rownames=FALSE)
table<-function(x){
  y1<-data3[x,2]
  y2<-data3[x,3]
  y3<-data3[x,4]
  g1<-100*((y2-y1)/y1)
  g1<-as.numeric(format(round(g1, 2), nsmall = 2))
  g2<-((y3-y2)/y2)*100
  g2<-as.numeric(format(round(g2, 2), nsmall = 2))
  avg<-((g1+g2)/2)
  df<-data.frame(rbind(data3[x,-1],c("YoY Growth % :",g1,g2)),check.rows = FALSE,check.names=FALSE)
  output$text1 <- renderText({ 
    paste("Avg. Growth % ",avg)
  })
  return(df)
}
output$cSelector <- renderUI({
  selectInput("country", "Select Country:", as.list(YTD3$"COUNTRY/REGION")) 
})
--
sliderInput('year', 'Map Year',format ="####",  min=2010, max=2012, value=2012, 
            step=1)
--
data2<-data1[,-2:-54]
data2<-data2[,-5]
data3<-data.frame(na.omit(data2),check.names=FALSE,stringsAsFactors=FALSE)
data3$Country.Name<-as.character(data3$Country.Name)
colnames(data3)<-c("Countries","2010","2011","2012")
data3[170,1]<-"Russia"
data3[213,1]<-"Venezuela"
data3[220,1]<-"CD"
data3[91,1]<-"Iran"
data3[38,1]<-"Congo"
data3[183,1]<-"SS"
data3[58,1]<-"Egypt"
data3[188,1]<-"Slovakia"
data3[101,1]<-"Kyrgyzstan"
row.names(data3)<-data3$Countries
#Rounding, 2 decimals
round2<-function(x){
  x<-as.numeric(format(round(x,2),nsmall=2))
  return(x)
}
data3[2:4]<-sapply(data3[,2:4],round2)
#Alphabetize
data3<-data3[order(data3$Countries),]

##
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

title="Health Expenditure Per Capita (Current US$)", 
h2("Health Expenditure Per Capita (Current US$)"),

h6("Source:", {a("World Bank", href="http://data.worldbank.org/indicator/SH.XPD.PCAP/countries?display=default")},
   " | ","Code:", {a("https://github.com/mliq/HealthMap", href="https://github.com/mliq/HealthMap")}),
#htmlOutput('myMap'),
#h4("Legend:", "100", {img(src="legend.png")}, "4000"),

h5("Legend:", "100", {img(src="legend3.png")}, "4000")