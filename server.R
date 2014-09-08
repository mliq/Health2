library(googleVis)
library(shiny)

shinyServer(function(input, output) {

  ###Pre-Processing
  YTD <- read.csv("YTD.csv",stringsAsFactors=FALSE)
	##YTD First
  colnames(YTD)<-as.character(YTD[4,])
  #Eliminate Extra Header Rows
  YTD2<-YTD[5:29,]
  #Just FULL YEAR section AND Countries
  YTD3<-cbind("Rank"=c(1:25),"COUNTRY/REGION"=YTD2$COUNTRY,YTD2[,15:18])
  #Rownames orderly again (if this matters I don't know yet)
  rownames(YTD3)<-c(1:25)
  ##
  ##HTD Now
  HTD <- read.csv("HTD.csv",stringsAsFactors=FALSE)
  colnames(HTD)<-as.character(HTD[4,])
  #Eliminate Extra Header Rows
  HTD2<-HTD[5:29,]
  #Just FULL YEAR section AND Countries
  HTD3<-cbind("Rank"=c(1:25),"COUNTRY/REGION"=HTD2$COUNTRY,HTD2[,10:12])
  #Rownames orderly again (if this matters I don't know yet)
  rownames(HTD3)<-c(1:25)
  YTD<-YTD3
  HTD<-HTD3
  gsub('\\$', '', YTD[,6])
  ##
  ###
  dataInput <- reactive({
      data<-input$select
    })
  
  output$myMap <- renderGvis({  
      data<-cbind(YTD," $$ over OP"=gsub('\\$', '', YTD[,6]))
    
  gvisGeoChart(data, locationvar="COUNTRY/REGION", colorvar=" $$ over OP", options=list(                              colorAxis="{values:[0,1,2,3],
                                   colors:['#FF0000', '#FFC0CB', '#FFA500','#008000']}",height=400,width=600,keepAspectRatio='false'))
  })
  output$myTable <- renderGvis({
    gvisTable(YTD3,options=list(width=450))
  })
  
 
})