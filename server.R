library(googleVis)
library(shiny)

shinyServer(function(input, output) {

  #Pre-Processing
  YTD <- read.csv("YTD.csv",stringsAsFactors=FALSE)
  HTD <- read.csv("HTD.csv",stringsAsFactors=FALSE)
	#YTD First
  colnames(YTD)<-as.character(YTD[4,])
  #Eliminate Extra Header Rows
  YTD2<-YTD[5:29,]
  #Just FULL YEAR section AND Countries
  YTD3<-cbind("COUNTRY/REGION"=YTD2$COUNTRY,YTD2[,15:18])
  #Rownames orderly again (if this matters I don't know yet)
  rownames(YTD3)<-c(1:25)
  
  
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
})