library(googleVis)
library(shiny)

shinyServer(function(input, output) {

  #Pre-Processing
  data1 <- read.csv("sh.xpd.pcap_Indicator_en_csv_v2.1.csv")
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
    selectInput("country", "Select Country:", as.list(data3$Countries)) 
  })
  output$myMap <- renderGvis({
  gvisGeoChart(data3, locationvar="Countries", colorvar=input$year, options=list(legend='false', 
                              colorAxis="{values:[100,500,1000,4000],
                                   colors:['#FF0000', '#FFC0CB', '#FFA500','#008000']}",height=400,width=600,keepAspectRatio='false'))
  })
  output$myTable <- renderGvis({
    gvisTable(data3,options=list(width=450))
  })
})