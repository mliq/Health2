library(googleVis)
library(shiny)

shinyServer(function(input, output) {
  #setwd("C:/Users/Michael/SkyDrive/Coursera/GitHub/Health2")
  ###Pre-Processing
  YTD <- read.csv("YTD.csv",stringsAsFactors=FALSE)
	##YTD First
  colnames(YTD)<-as.character(YTD[4,])
  #Eliminate Extra Header Rows
  YTD2<-YTD[5:27,]
  #Just FULL YEAR section AND Countries
  YTD3<-cbind("Rank"=c(1:23),"Country/Region"=YTD2$COUNTRY,YTD2[,15:18])
  #Rownames orderly again (if this matters I don't know yet)
  rownames(YTD3)<-c(1:23)
  ##
  ##HTD Now
  HTD <- read.csv("HTD.csv",stringsAsFactors=FALSE)
  colnames(HTD)<-as.character(HTD[4,])
  #Eliminate Extra Header Rows
  HTD2<-HTD[5:27,]
  #Just FULL YEAR section AND Countries
  HTD3<-cbind("Rank"=c(1:23),"Country/Region"=HTD2$COUNTRY,HTD2[,11:13])
  #Rownames orderly again (if this matters I don't know yet)
  rownames(HTD3)<-c(1:23)
  YTD<-YTD3
  HTD<-HTD3
  colnames(HTD)[5]<-"LCG % pts. over OP"
  #gsub('\\$', '', YTD[,6])
  ##
  ###

  
  output$myMap <- renderGvis({  
    if (input$adjust==1){
      data<-cbind(YTD," $$ over OP"=as.numeric(gsub('\\$', '', YTD[,6])))
      color="{values:[0,0,.5,1],colors:['#FF0000', '#FFC0CB', '#FFA500','#008000']}"
      var=" $$ over OP"
    }
    if (input$adjust==2){
      data<-cbind(HTD," LCG % pts. over OP"=as.numeric(gsub('\\%', '', HTD[,5])))
      color="{values:[0,5,10,20],colors:['#FF0000', '#FFC0CB', '#FFA500','#008000']}"
      var=" LCG % pts. over OP"
    }
  gvisGeoChart(data, locationvar="Country/Region", colorvar=var, options=list(                              
                                    colorAxis=color,height=400,width=600,keepAspectRatio='false'))
  })
  output$myTable <- renderGvis({
    if (input$adjust==1){
      data<-YTD
    }
    if (input$adjust==2){
      data<-HTD
    }
    gvisTable(data,options=list(width=450))
  })
  
 
})