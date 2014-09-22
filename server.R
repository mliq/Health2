library(googleVis)
library(shiny)

shinyServer(function(input, output) {
  ###Pre-Processing
  YTD <- read.csv("1B.csv",stringsAsFactors=FALSE)
  YTD <-YTD[-1:-4,]
  YTD2<-YTD[,c(1,6:11,13:15)]
  #Columns selected, 
  #Row and column names
  colnames(YTD2)<-as.character(c("Country/Region","Full Year OP","YTD OP","YTD Actuals","% to OP","Meets OI Requirements", "YTD Incremental $$ over OP", "% Local Growth OP", "% Local Growth Actual", "LCG % pts. over OP"))
  #Filter
  YTD2$"sort1" <- as.numeric(sub("\\$","", YTD2$"Full Year OP"))
  YTD3<- subset(YTD2,sort1>=7)
  YTD4<-subset(YTD3,YTD3$"Meets OI Requirements"=="YES")
  #Cut to YTD columns
  YTD5<-YTD4[,c(1:5,7)]
  #Make numeric sort column, sort, erase sort column
  YTD5$"sort2" <- as.numeric(sub("\\$","", YTD5$"YTD Incremental $$ over OP"))
  YTD6<-YTD5[order(-YTD5$sort2),]
  rownames(YTD6)<-c(1:dim(YTD6)[1])
  YTD7<-cbind("Rank"=rownames(YTD6),YTD6[,1:6])
  #YTD Table ready.
  
  ##HTD , starting from YTD4
  #Cut to HTD columns
  HTD1<-YTD4[,c(1,8:10)]
  #Make numeric sort column, sort, erase sort column
  HTD1$"sort3" <- as.numeric(sub("\\%","", HTD1$"LCG % pts. over OP"))
  HTD2<-HTD1[order(-HTD1$sort3),]
  rownames(HTD2)<-c(1:dim(HTD2)[1])
  HTD3<-cbind("Rank"=rownames(HTD2),HTD2[,1:4])
  #HTD Table ready.
  
  ###Fix non-displayed countries
  #UK Ireland
  YTD8<-YTD7
  if (!is.null(which(YTD8[2]=="UK Ireland"))) {
    YTD8[,2]<-gsub("UK Ireland", "Great Britain", YTD8[,2])
    YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Great Britain"),])
    YTD8[dim(YTD8)[1],2]<-"Ireland"
  }
  if (!is.null(which(YTD8[2]=="UK Ireland"))) {
    YTD8[,2]<-gsub("UK Ireland", "Great Britain", YTD8[,2])
    YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Great Britain"),])
    YTD8[dim(YTD8)[1],2]<-"Ireland"
  }
  #if (!is.null(which(YTD8[2]=="UK Ireland")) && which(YTD8[2]=="UK Ireland")!=0) {
    #YTD8[,2]<-gsub("UK Ireland", "Great Britain", YTD8[,2])
    #YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Great Britain"),])
    #YTD8[dim(YTD8)[1],2]<-"Ireland"
  #}
  #if (which(YTD8[2]=="UK Ireland")!=0) {
    #YTD8[,2]<-gsub("UK Ireland", "Great Britain", YTD8[,2])
    #YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Great Britain"),])
    #YTD8[dim(YTD8)[1],2]<-"Ireland"
  #}
  #test if country does not exist.
#  YTD8[,2]<-gsub("NORDIC", "hot pocket", YTD8[,2])
  #YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="hot pocket"),])
  #If (which(YTD8[2]=="hot pocket")!=0) {
  #YTD8[dim(YTD8)[1],2]<-"Ireland"
  #}
  
  #LAST line will screw up, so need exception.
  
  #Alpine = Swiss, Liechtenstein, Austria.
  #Benelux = Belgium, Luxembourg, Netherlands
  #Gulf = Kuwait, Bahrain, Oman, Qatar, UAE
  #Iberia = Port, spain
  #ANZ = NA for now
  #Nordic = NA for now
  #Central America & Caribbean Region = DR, Panama, Guatemala, CR, Honduras, Nicaragua, El Salvador
  #Andean Region = Ecuador, Peru, Bolivia
  
  
  ###MAP
  output$myMap <- renderGvis({  
    if (input$adjust==1){
      data<-cbind(YTD8,"YTD Inc. USD over OP"=as.numeric(sub("\\$", "", YTD8$"YTD Incremental $$ over OP")))
      #color="{values:[0,.5,1,1.5],colors:['#FF0000', '#FFC0CB', '#FFA500','#008000']}"
      color="{colors:['#FF0000', '#FFC0CB', '#FFA500','#008000']}"
      var="YTD Inc. USD over OP"
    }
    if (input$adjust==2){
      data<-cbind(HTD3,"LCG Perc. over OP"=as.numeric(sub('\\%', '', HTD3$"LCG % pts. over OP")))
      #color="{values:[-50,0,10,30],colors:['#FF0000', '#FFC0CB', '#FFA500','#008000']}"
      color="{colors:['#FF0000', '#FFC0CB', '#FFA500','#008000']}"
      var="LCG Perc. over OP"
    }
  gvisGeoChart(data, locationvar="Country/Region", colorvar=var, options=list(                              
                                    colorAxis=color,height=400,width=600,keepAspectRatio='false'))
  })
  #TABLE
  output$myTable <- renderGvis({
    if (input$adjust==1){
      data<-YTD7
    }
    if (input$adjust==2){
      data<-HTD3
    }
    gvisTable(data,options=list(width=500))
  })
})