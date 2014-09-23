library(googleVis)
library(shiny)

shinyServer(function(input, output) {
  ###Pre-Processing
  YTD <- read.csv("1B.csv",stringsAsFactors=FALSE)
  YTD <-YTD[-1:-4,]
  YTD2<-YTD[,c(1,6:11,13:15)]
  YTD2=apply(YTD2, c(1,2), function(x) gsub('\\%', '', x)) 
  YTD2=apply(YTD2, c(1,2), function(x) gsub('\\$', '', x)) 
  YTD2=data.frame(YTD2)
  #YTD2[,2:9] <- sapply(YTD2[,2:9], as.numeric)
  as.numeric
  #Columns selected, 
  #Row and column names
  colnames(YTD2)<-as.character(c("Country/Region","Full Year OP ($$)","YTD OP ($$)","YTD Actuals ($$)","% to OP (%)","Meets OI Requirements", "YTD Incremental over OP ($$)", "% Local Growth OP", "% Local Growth Actual", "LCG % pts. over OP"))
  #Filter
  YTD2$"sort1" <- as.numeric(sub("\\$","", YTD2$"Full Year OP ($$)"))
  YTD3<- subset(YTD2,sort1>=7)
  YTD4<-subset(YTD3,YTD3$"Meets OI Requirements"=="YES")
  #Cut to YTD columns
  YTD5<-YTD4[,c(1:5,7)]
  #Make numeric sort column, sort, erase sort column
  YTD5$"sort2" <- as.numeric(sub("\\$","", YTD5$"YTD Incremental over OP ($$)"))
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
  YTD9<-YTD7
  HTD4<-HTD3
  regions <- function(YTD8) {
    #UK Ireland
    if (!is.null(which(YTD8[2]=="UK Ireland"))) {
      YTD8[,2]<-gsub("UK Ireland", "Great Britain", YTD8[,2])
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Great Britain"),])
      YTD8[dim(YTD8)[1],2]<-"Ireland"
    }
    #Alpine = Swiss, Liechtenstein, Austria.
    if (!is.null(which(YTD8[2]=="Alpine"))) {
      YTD8[,2]<-gsub("Alpine", "Switzerland", YTD8[,2])
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Switzerland"),])
      YTD8[dim(YTD8)[1],2]<-"Liechtenstein"
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Switzerland"),])
      YTD8[dim(YTD8)[1],2]<-"Austria"
    }
    #Benelux = Belgium, Luxembourg, Netherlands
    if (!is.null(which(YTD8[2]=="Benelux"))) {
      YTD8[,2]<-gsub("Benelux", "Netherlands", YTD8[,2])
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Netherlands"),])
      YTD8[dim(YTD8)[1],2]<-"Luxembourg"
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Netherlands"),])
      YTD8[dim(YTD8)[1],2]<-"Belgium"
    }
    #Gulf = Kuwait, Bahrain, Oman, Qatar, UAE
    if (!is.null(which(YTD8[2]=="Gulf"))) {
      YTD8[,2]<-gsub("Gulf", "United Arab Emirates", YTD8[,2])
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="United Arab Emirates"),])
      YTD8[dim(YTD8)[1],2]<-"Oman"
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="United Arab Emirates"),])
      YTD8[dim(YTD8)[1],2]<-"Qatar"
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="United Arab Emirates"),])
      YTD8[dim(YTD8)[1],2]<-"Bahrain"
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="United Arab Emirates"),])
      YTD8[dim(YTD8)[1],2]<-"Kuwait"
    }
    #Iberia = Port, spain
    if (!is.null(which(YTD8[2]=="Iberia"))) {
      YTD8[,2]<-gsub("Iberia", "Spain", YTD8[,2])
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Spain"),])
      YTD8[dim(YTD8)[1],2]<-"Portugal"
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Spain"),])
      YTD8[dim(YTD8)[1],2]<-"Andorra"
    }
    #Central America & Caribbean Region = DR, Panama, Guatemala, CR, Honduras, Nicaragua, El Salvador
    if (!is.null(which(YTD8[2]=="Central America & Caribbean Region"))) {
      YTD8[,2]<-gsub("Central America & Caribbean Region", "Dominican Republic", YTD8[,2])
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Dominican Republic"),])
      YTD8[dim(YTD8)[1],2]<-"Panama"
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Dominican Republic"),])
      YTD8[dim(YTD8)[1],2]<-"Guatemala"
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Dominican Republic"),])
      YTD8[dim(YTD8)[1],2]<-"Costa Rica"
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Dominican Republic"),])
      YTD8[dim(YTD8)[1],2]<-"Honduras"
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Dominican Republic"),])
      YTD8[dim(YTD8)[1],2]<-"Nicaragua"
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Dominican Republic"),])
      YTD8[dim(YTD8)[1],2]<-"El Salvador"
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Dominican Republic"),])
      YTD8[dim(YTD8)[1],2]<-"Jamaica"
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Dominican Republic"),])
      YTD8[dim(YTD8)[1],2]<-"Trinidad and Tobago"
    }
    #Andean Region = Ecuador, Peru, Bolivia, Paraguay
    if (!is.null(which(YTD8[2]=="Andean Region"))) {
      YTD8[,2]<-gsub("Andean Region", "Ecuador", YTD8[,2])
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Ecuador"),])
      YTD8[dim(YTD8)[1],2]<-"Peru"
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Ecuador"),])
      YTD8[dim(YTD8)[1],2]<-"Bolivia"
      YTD8<-rbind(YTD8,YTD8[which(YTD8[2]=="Ecuador"),])
      YTD8[dim(YTD8)[1],2]<-"Paraguay"
    }
    #ANZ = NA for now
    #Nordic = NA for now
    #Argentina Uruguay
    #Cesko
    #Singapore Region
    return(YTD8)
  }
  YTD9<-regions(YTD9)
  HTD4<-regions(HTD4)
  
  ###MAP
  output$myMap <- renderGvis({  
    if (input$adjust==1){
      data<-cbind(YTD9,"YTD Inc. USD over OP"=as.numeric(sub("\\$", "", YTD9$"YTD Incremental over OP ($$)")))
      #color="{values:[0,.5,1,1.5],colors:['#FF0000', '#FFC0CB', '#FFA500','#008000']}"
      color="{colors:['#FF0000', '#FFC0CB', '#FFA500','#008000']}"
      var="YTD Inc. USD over OP"
    }
    if (input$adjust==2){
      data<-cbind(HTD4,"LCG Perc. over OP"=as.numeric(sub('\\%', '', HTD4$"LCG % pts. over OP")))
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
      data[,1]=as.numeric(as.character(data[,1]))
      data[,3]=as.numeric(as.character(data[,3]))
      data[,4]=as.numeric(as.character(data[,4]))
      data[,5]=as.numeric(as.character(data[,5]))
      data[,6]=as.numeric(as.character(data[,6]))
      data[,7]=as.numeric(as.character(data[,7]))
    }
    if (input$adjust==2){
      data<-HTD3
      data[,1]=as.numeric(as.character(data[,1]))
      data[,3]=as.numeric(as.character(data[,3]))
      data[,4]=as.numeric(as.character(data[,4]))
      data[,5]=as.numeric(as.character(data[,5]))
    }
    mytab<-gvisTable(data,options=list(width=600,cssClassNames = "{headerRow: 'myTableHeadrow', tableRow: 'myTablerow', rowNumberCell}", alternatingRowStyle = FALSE))
  })
})