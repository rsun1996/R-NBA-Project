### This Code is for NBA Data Analysis
### Author: Renhao Sun

    ### Set up mydir
    mydir <- "C:/Users/peter/Documents/UTSA/R/Project"
    codedir <- paste(mydir,"/Code",sep = "")
    input <-  paste(mydir,"/Data",sep = "")
    output <- paste(mydir,"/Output/Data",sep = "")
    source(paste(codedir,"/Package.R",sep = ""))
    library(tidyverse)
    
    ### Read NBA_Stats_Merge and Salary_Cap datasets
    NBA_Stats_Merge <- read.csv(paste(output,"/NBA_Stats_Merge.csv",sep = ""))
    Salary_Cap <- read.csv(paste(output,"/Salary_Cap.csv",sep = ""))
    colnames(Salary_Cap) <- c("Year","Soft_Cap")
    Salary_Cap$Soft_Cap <- as.numeric(gsub('[$,]', '',Salary_Cap$Soft_Cap))
    Salary_Cap$Year <- as.factor(Salary_Cap$Year)
    
    ### Salary Cap figure 
    pl_1 <- ggplot()+
      theme_bw()+
      geom_bar(data = Salary_Cap,aes(y=Year,x=Soft_Cap),fill = "#051C2D" ,stat = "identity")+
      ggtitle("NBA Salary Cap History",
              subtitle = "1984 - 2021")+
      theme(legend.position = 'bottom',
            legend.direction = "horizontal",
            plot.title = element_text(size = 12,face = "bold",hjust = 0.5,family = "Arial",colour = "#051C2D"),
            plot.subtitle = element_text(size = 10,hjust = 0.5,family = "Arial",colour = "#051C2D"),
            legend.title = element_blank(),
            legend.background = element_blank(),
            legend.box.background = element_rect(colour = "#051C2D"),
            legend.key = element_rect(colour = "transparent", fill = "white"),
            legend.text = element_text(family = "Arial",colour = "#051C2D",size = 12),
            panel.background = element_rect(fill = "transparent",color = NA),
            plot.background = element_rect(fill = "transparent",colour = NA),
            axis.text.x = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.text.y = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.title.x = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            axis.title.y = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            panel.border = element_blank())+
      scale_x_continuous(name = "Salary Cap ($)",breaks = c(0,30000000,60000000,90000000))
    
    ### Get stats for each position
    c <- NBA_Stats_Merge[which(NBA_Stats_Merge$Position == "C" | NBA_Stats_Merge$Position == "C,PF"),]
    pf <- NBA_Stats_Merge[which(NBA_Stats_Merge$Position == "PF" | NBA_Stats_Merge$Position == "PF,SF" | NBA_Stats_Merge$Position == "PF,SG"),]
    sf <- NBA_Stats_Merge[which(NBA_Stats_Merge$Position == "SF" | NBA_Stats_Merge$Position == "SF,SG"),]
    pg  <- NBA_Stats_Merge[which(NBA_Stats_Merge$Position == "PG" | NBA_Stats_Merge$Position == "PG,SF" | NBA_Stats_Merge$Position == "PG,SG"),]
    sg <- NBA_Stats_Merge[which(NBA_Stats_Merge$Position == "SG"),]
    
    ### Graphs for demonstrating differences among each position
    parameter_2 <- c("C" = "#0c2340","PF" = "#F15A22","SF" = "#B52532","SG" = "#051C2D","PG" = "#EE756C")
    position <- c("C","PF","SF","SG","PG")
    pts <- c(round(mean(c$PTS),2),round(mean(pf$PTS),2),round(mean(sf$PTS),2),round(mean(sg$PTS),2),round(mean(pg$PTS),2))
    ast <- c(round(mean(c$AST),2),round(mean(pf$AST),2),round(mean(sf$AST),2),round(mean(sg$AST),2),round(mean(pg$AST),2))
    TRB <- c(round(mean(c$TRB),2),round(mean(pf$TRB),2),round(mean(sf$TRB),2),round(mean(sg$TRB),2),round(mean(pg$TRB),2))
    position_stats <- data.frame(position,pts,ast,TRB)
    colnames(position_stats) <- c("Position","PTS","AST","TRB")
    pl_2 <- ggplot()+
      theme_bw()+
      geom_bar(data = position_stats,aes(x = Position,y = PTS,fill =  Position),stat = "identity",width = 1)+
      coord_polar()+
      ggtitle("Points per Game based on Position",
              subtitle = "1984 - 2021")+
      scale_fill_manual("legend", values = parameter_2)+
      theme(legend.position = 'bottom',
              legend.direction = "horizontal",
              plot.title = element_text(size = 12,face = "bold",hjust = 0.5,family = "Arial",colour = "#051C2D"),
              plot.subtitle = element_text(size = 10,hjust = 0.5,family = "Arial",colour = "#051C2D"),
              legend.title = element_blank(),
              legend.background = element_blank(),
              legend.box.background = element_rect(colour = "#051C2D"),
              legend.key = element_rect(colour = "transparent", fill = "white"),
              legend.text = element_text(family = "Arial",colour = "#051C2D",size = 12),
              panel.background = element_rect(fill = "transparent",color = NA),
              plot.background = element_rect(fill = "transparent",colour = NA),
              axis.text.x = element_text(family = "Arial",colour = "#051C2D",size = 12),
              axis.text.y = element_text(family = "Arial",colour = "#051C2D",size = 12),
              axis.title.x = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
              axis.title.y = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
              panel.border = element_blank())
    
    pl_3 <- ggplot()+
      theme_bw()+
      geom_bar(data = position_stats,aes(x = Position,y = TRB,fill =  Position),stat = "identity",width = 1)+
      coord_polar()+
      ggtitle("Total Rebounds per Game based on Position",
              subtitle = "1984 - 2021")+
      scale_fill_manual("legend", values = parameter_2)+
      theme(legend.position = 'bottom',
            legend.direction = "horizontal",
            plot.title = element_text(size = 12,face = "bold",hjust = 0.5,family = "Arial",colour = "#051C2D"),
            plot.subtitle = element_text(size = 10,hjust = 0.5,family = "Arial",colour = "#051C2D"),
            legend.title = element_blank(),
            legend.background = element_blank(),
            legend.box.background = element_rect(colour = "#051C2D"),
            legend.key = element_rect(colour = "transparent", fill = "white"),
            legend.text = element_text(family = "Arial",colour = "#051C2D",size = 12),
            panel.background = element_rect(fill = "transparent",color = NA),
            plot.background = element_rect(fill = "transparent",colour = NA),
            axis.text.x = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.text.y = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.title.x = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            axis.title.y = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            panel.border = element_blank())
    
    pl_4 <- ggplot()+
      theme_bw()+
      geom_bar(data = position_stats,aes(x = Position,y = AST,fill =  Position),stat = "identity",width = 1)+
      coord_polar()+
      ggtitle("Total Assists per Game based on Position",
              subtitle = "1984 - 2021")+
      scale_fill_manual("legend", values = parameter_2)+
      theme(legend.position = 'bottom',
            legend.direction = "horizontal",
            plot.title = element_text(size = 12,face = "bold",hjust = 0.5,family = "Arial",colour = "#051C2D"),
            plot.subtitle = element_text(size = 10,hjust = 0.5,family = "Arial",colour = "#051C2D"),
            legend.title = element_blank(),
            legend.background = element_blank(),
            legend.box.background = element_rect(colour = "#051C2D"),
            legend.key = element_rect(colour = "transparent", fill = "white"),
            legend.text = element_text(family = "Arial",colour = "#051C2D",size = 12),
            panel.background = element_rect(fill = "transparent",color = NA),
            plot.background = element_rect(fill = "transparent",colour = NA),
            axis.text.x = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.text.y = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.title.x = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            axis.title.y = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            panel.border = element_blank())
    
    ### Graphes for Case study
    sf$Salary <- as.numeric(gsub('[$,]', '',sf$Salary))
    sf_2017 <- sf[which(sf$Start>=2017),]
    sf_2017$Salary <- as.numeric(gsub('[$,]', '',sf_2017$Salary))
    sf_2017 <- sf_2017[-which(is.na(sf_2017$Salary)),]
    for (i.player in 1:nrow(sf_2017)){
      if(sf_2017$Start[i.player] < 2019){
        sf_2017[i.player,"Salary_Adjusted"] = sf_2017$Salary[i.player]*1.05^(2019-sf_2017$Start[i.player])
      }else{
        sf_2017[i.player,"Salary_Adjusted"] = sf_2017$Salary[i.player]
      }
    }
    
      ### PTS 
      pl_5 =  ggplot()+
        theme_bw()+
        geom_point(data = sf_2017, mapping = aes(x = Salary_Adjusted, y = sf_2017$PTS),color = "#051C2D",size = 3)+
        ggtitle("scatter Plot between PTS and Salary",
                subtitle = "All SFs in NBA from 2017 to 2021")+
        xlab("Salary ($)") +
        ylab("PTS")+
        theme(legend.position = 'bottom',
              legend.direction = "horizontal",
              plot.title = element_text(size = 12,face = "bold",hjust = 0.5,family = "Arial",colour = "#051C2D"),
              plot.subtitle = element_text(size = 10,hjust = 0.5,family = "Arial",colour = "#051C2D"),
              legend.title = element_blank(),
              legend.background = element_blank(),
              legend.box.background = element_rect(colour = "#051C2D"),
              legend.key = element_rect(colour = "transparent", fill = "white"),
              legend.text = element_text(family = "Arial",colour = "#051C2D",size = 12),
              panel.background = element_rect(fill = "transparent",color = NA),
              plot.background = element_rect(fill = "transparent",colour = NA),
              axis.text.x = element_text(family = "Arial",colour = "#051C2D",size = 12),
              axis.text.y = element_text(family = "Arial",colour = "#051C2D",size = 12),
              axis.title.x = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
              axis.title.y = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
              panel.border = element_blank())+
      scale_y_continuous(breaks = c(0,5,10,15,20,25,30),limits = c(0,30))
      pl_5
    
      ### AST
      pl_6 = ggplot()+
        theme_bw()+
        geom_point(data = sf_2017, mapping = aes(x = Salary_Adjusted, y = sf_2017$AST),color = "#051C2D",size = 3)+
        ggtitle("Scatter Plot between PTS and Salary",
                subtitle = "All SFs in NBA from 2017 to 2021")+
        xlab("Salary ($)") +
        ylab("AST")+
        theme(legend.position = 'bottom',
              legend.direction = "horizontal",
              plot.title = element_text(size = 12,face = "bold",hjust = 0.5,family = "Arial",colour = "#051C2D"),
              plot.subtitle = element_text(size = 10,hjust = 0.5,family = "Arial",colour = "#051C2D"),
              legend.title = element_blank(),
              legend.background = element_blank(),
              legend.box.background = element_rect(colour = "#051C2D"),
              legend.key = element_rect(colour = "transparent", fill = "white"),
              legend.text = element_text(family = "Arial",colour = "#051C2D",size = 12),
              panel.background = element_rect(fill = "transparent",color = NA),
              plot.background = element_rect(fill = "transparent",colour = NA),
              axis.text.x = element_text(family = "Arial",colour = "#051C2D",size = 12),
              axis.text.y = element_text(family = "Arial",colour = "#051C2D",size = 12),
              axis.title.x = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
              axis.title.y = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
              panel.border = element_blank())+
        scale_y_continuous(breaks = c(0,5,10,15,20,25,30),limits = c(0,30))
        pl_6
        
    ###  TRB
    pl_7 = ggplot()+
      theme_bw()+
      geom_point(data = sf_2017, mapping = aes(x = Salary_Adjusted, y = sf_2017$TRB),color = "#051C2D",size = 3)+
      ggtitle("Scatter Plot between AST and Salary",
              subtitle = "All SFs in NBA from 2017 to 2021")+
      xlab("Salary ($)") +
      ylab("TRB")+
      theme(legend.position = 'bottom',
            legend.direction = "horizontal",
            plot.title = element_text(size = 12,face = "bold",hjust = 0.5,family = "Arial",colour = "#051C2D"),
            plot.subtitle = element_text(size = 10,hjust = 0.5,family = "Arial",colour = "#051C2D"),
            legend.title = element_blank(),
            legend.background = element_blank(),
            legend.box.background = element_rect(colour = "#051C2D"),
            legend.key = element_rect(colour = "transparent", fill = "white"),
            legend.text = element_text(family = "Arial",colour = "#051C2D",size = 12),
            panel.background = element_rect(fill = "transparent",color = NA),
            plot.background = element_rect(fill = "transparent",colour = NA),
            axis.text.x = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.text.y = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.title.x = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            axis.title.y = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            panel.border = element_blank())+
      scale_y_continuous(breaks = c(0,1,2,3,4,5,6,7,8),limits = c(0,8))
    
    ### BLK
    pl_8 = ggplot()+
      theme_bw()+
      geom_point(data = sf_2017, mapping = aes(x = Salary_Adjusted, y = sf_2017$BLK),color = "#051C2D",size = 3)+
      ggtitle("Scatter Plot between BLK and Salary",
              subtitle = "All SFs in NBA from 2017 to 2021")+
      xlab("Salary ($)") +
      ylab("BLK")+
      theme(legend.position = 'bottom',
            legend.direction = "horizontal",
            plot.title = element_text(size = 12,face = "bold",hjust = 0.5,family = "Arial",colour = "#051C2D"),
            plot.subtitle = element_text(size = 10,hjust = 0.5,family = "Arial",colour = "#051C2D"),
            legend.title = element_blank(),
            legend.background = element_blank(),
            legend.box.background = element_rect(colour = "#051C2D"),
            legend.key = element_rect(colour = "transparent", fill = "white"),
            legend.text = element_text(family = "Arial",colour = "#051C2D",size = 12),
            panel.background = element_rect(fill = "transparent",color = NA),
            plot.background = element_rect(fill = "transparent",colour = NA),
            axis.text.x = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.text.y = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.title.x = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            axis.title.y = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            panel.border = element_blank())+
      scale_y_continuous(breaks = c(0,0.4,0.8,1.2,1.6,2.0),limits = c(0,2))
    
    pl_8
    
    ### Three
    pl_9 = ggplot()+
      theme_bw()+
      geom_point(data = sf_2017, mapping = aes(x = Salary_Adjusted, y = sf_2017$Three_point_field_goals_per_game),color = "#051C2D",size = 3)+
      ggtitle("Scatter Plot between Three Field Goals per Game and Salary",
              subtitle = "All SFs in NBA from 2017 to 2021")+
      xlab("Salary ($)") +
      ylab("Three Point Field Goals per Game")+
      theme(legend.position = 'bottom',
            legend.direction = "horizontal",
            plot.title = element_text(size = 12,face = "bold",hjust = 0.5,family = "Arial",colour = "#051C2D"),
            plot.subtitle = element_text(size = 10,hjust = 0.5,family = "Arial",colour = "#051C2D"),
            legend.title = element_blank(),
            legend.background = element_blank(),
            legend.box.background = element_rect(colour = "#051C2D"),
            legend.key = element_rect(colour = "transparent", fill = "white"),
            legend.text = element_text(family = "Arial",colour = "#051C2D",size = 12),
            panel.background = element_rect(fill = "transparent",color = NA),
            plot.background = element_rect(fill = "transparent",colour = NA),
            axis.text.x = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.text.y = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.title.x = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            axis.title.y = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            panel.border = element_blank())+
      scale_y_continuous(breaks = c(0,0.4,0.8,1.2,1.6,2.0),limits = c(0,2))
    
    ### PER
    pl_10 = ggplot()+
      theme_bw()+
      geom_point(data = sf_2017, mapping = aes(x = Salary_Adjusted, y = sf_2017$PER),color = "#051C2D",size = 3)+
      ggtitle("Scatter Plot between PER and Salary",
              subtitle = "All SFs in NBA from 2017 to 2021")+
      xlab("Salary ($)") +
      ylab("PER")+
      theme(legend.position = 'bottom',
            legend.direction = "horizontal",
            plot.title = element_text(size = 12,face = "bold",hjust = 0.5,family = "Arial",colour = "#051C2D"),
            plot.subtitle = element_text(size = 10,hjust = 0.5,family = "Arial",colour = "#051C2D"),
            legend.title = element_blank(),
            legend.background = element_blank(),
            legend.box.background = element_rect(colour = "#051C2D"),
            legend.key = element_rect(colour = "transparent", fill = "white"),
            legend.text = element_text(family = "Arial",colour = "#051C2D",size = 12),
            panel.background = element_rect(fill = "transparent",color = NA),
            plot.background = element_rect(fill = "transparent",colour = NA),
            axis.text.x = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.text.y = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.title.x = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            axis.title.y = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            panel.border = element_blank())+
      scale_y_continuous(breaks = c(0,5,10,15,20,25,30),limits = c(0,30))
    
    ### WS
    pl_11 = ggplot()+
      theme_bw()+
      geom_point(data = sf_2017, mapping = aes(x = Salary_Adjusted, y = sf_2017$win_shares),color = "#051C2D",size = 3)+
      ggtitle("Scatter Plot between Win Share and Salary",
              subtitle = "All SFs in NBA from 2017 to 2021")+
      xlab("Salary ($)") +
      ylab("WS")+
      theme(legend.position = 'bottom',
            legend.direction = "horizontal",
            plot.title = element_text(size = 12,face = "bold",hjust = 0.5,family = "Arial",colour = "#051C2D"),
            plot.subtitle = element_text(size = 10,hjust = 0.5,family = "Arial",colour = "#051C2D"),
            legend.title = element_blank(),
            legend.background = element_blank(),
            legend.box.background = element_rect(colour = "#051C2D"),
            legend.key = element_rect(colour = "transparent", fill = "white"),
            legend.text = element_text(family = "Arial",colour = "#051C2D",size = 12),
            panel.background = element_rect(fill = "transparent",color = NA),
            plot.background = element_rect(fill = "transparent",colour = NA),
            axis.text.x = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.text.y = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.title.x = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            axis.title.y = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            panel.border = element_blank())+
      scale_y_continuous(breaks = c(0,2,4,6,8,10,12),limits = c(0,12))
    
    ### OBPM
    pl_12 = ggplot()+
      theme_bw()+
      geom_point(data = sf_2017, mapping = aes(x = Salary_Adjusted, y = sf_2017$Offensive_box_plus_minus),color = "#051C2D",size = 3)+
      ggtitle("Scatter Plot between Offensive Box plus/minus and Salary",
              subtitle = "All SFs in NBA from 2017 to 2021")+
      xlab("Salary ($)") +
      ylab("OBPM")+
      theme(legend.position = 'bottom',
            legend.direction = "horizontal",
            plot.title = element_text(size = 12,face = "bold",hjust = 0.5,family = "Arial",colour = "#051C2D"),
            plot.subtitle = element_text(size = 10,hjust = 0.5,family = "Arial",colour = "#051C2D"),
            legend.title = element_blank(),
            legend.background = element_blank(),
            legend.box.background = element_rect(colour = "#051C2D"),
            legend.key = element_rect(colour = "transparent", fill = "white"),
            legend.text = element_text(family = "Arial",colour = "#051C2D",size = 12),
            panel.background = element_rect(fill = "transparent",color = NA),
            plot.background = element_rect(fill = "transparent",colour = NA),
            axis.text.x = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.text.y = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.title.x = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            axis.title.y = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            panel.border = element_blank())+
      scale_y_continuous(breaks = c(-4,-2,0,2,4),limits = c(-4,4))
    
    ### DBPM
    pl_13 = ggplot()+
      theme_bw()+
      geom_point(data = sf_2017, mapping = aes(x = Salary_Adjusted, y = sf_2017$Defensive_box_plus_minus),color = "#051C2D",size = 3)+
      ggtitle("Scatter Plot between Defensive Box plus/minus and Salary",
              subtitle = "All SFs in NBA from 2017 to 2021")+
      xlab("Salary ($)") +
      ylab("DBPM")+
      theme(legend.position = 'bottom',
            legend.direction = "horizontal",
            plot.title = element_text(size = 12,face = "bold",hjust = 0.5,family = "Arial",colour = "#051C2D"),
            plot.subtitle = element_text(size = 10,hjust = 0.5,family = "Arial",colour = "#051C2D"),
            legend.title = element_blank(),
            legend.background = element_blank(),
            legend.box.background = element_rect(colour = "#051C2D"),
            legend.key = element_rect(colour = "transparent", fill = "white"),
            legend.text = element_text(family = "Arial",colour = "#051C2D",size = 12),
            panel.background = element_rect(fill = "transparent",color = NA),
            plot.background = element_rect(fill = "transparent",colour = NA),
            axis.text.x = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.text.y = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.title.x = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            axis.title.y = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            panel.border = element_blank())+
      scale_y_continuous(breaks = c(-4,-2,0,2,4),limits = c(-4,4))
    
    ### Value_over_replacement_player
    pl_14 = ggplot()+
      theme_bw()+
      geom_point(data = sf_2017, mapping = aes(x = Salary_Adjusted, y = sf_2017$Defensive_box_plus_minus),color = "#051C2D",size = 3)+
      ggtitle("Scatter Plot of Value over replacement player(VRP)",
              subtitle = "All SFs in NBA from 2017 to 2021")+
      xlab("Salary ($)") +
      ylab("VRP")+
      theme(legend.position = 'bottom',
            legend.direction = "horizontal",
            plot.title = element_text(size = 12,face = "bold",hjust = 0.5,family = "Arial",colour = "#051C2D"),
            plot.subtitle = element_text(size = 10,hjust = 0.5,family = "Arial",colour = "#051C2D"),
            legend.title = element_blank(),
            legend.background = element_blank(),
            legend.box.background = element_rect(colour = "#051C2D"),
            legend.key = element_rect(colour = "transparent", fill = "white"),
            legend.text = element_text(family = "Arial",colour = "#051C2D",size = 12),
            panel.background = element_rect(fill = "transparent",color = NA),
            plot.background = element_rect(fill = "transparent",colour = NA),
            axis.text.x = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.text.y = element_text(family = "Arial",colour = "#051C2D",size = 12),
            axis.title.x = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            axis.title.y = element_text(family = "Arial",colour = "#051C2D",size = 12,face = "bold"),
            panel.border = element_blank())+
      scale_y_continuous(breaks = c(-4,-2,0,2,4),limits = c(-4,4))
    
    ### Historical Average 
    Salary_Cap <- Salary_Cap %>%
      separate(Year,c("Start","End"),"-")
    
    for(i.row in 1:nrow(sf)){
      sf$Salary_Cap[i.row] <- Salary_Cap[which(Salary_Cap$Start == sf$Start[i.row]),"Soft_Cap"] 
    }
    sf$Cap_Space <- sf$Salary/sf$Salary_Cap
    
    benchmark_sf <- sf[which(sf$Cap_Space >= 0.25),]
    mean(benchmark_sf$PTS)
    mean(benchmark_sf$TRB)
    mean(benchmark_sf$AST)
    mean(benchmark_sf$PER)
    mean(benchmark_sf$win_shares)
    mean(benchmark_sf$Offensive_box_plus_minus)