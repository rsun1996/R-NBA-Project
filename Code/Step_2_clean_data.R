### This code is for cleaning all NBA Dataset
### Author: Renhao Sun
  
  ### Set up mydir
  mydir <- "C:/Users/peter/Documents/UTSA/R/Project"
  codedir <- paste(mydir,"/Code",sep = "")
  input <-  paste(mydir,"/Data",sep = "")
  output <- paste(mydir,"/Output/Data",sep = "")
  source(paste(codedir,"/Package.R",sep = ""))
  library(tidyverse)
  
    ### Clean dataset player_per_game_stats 
        ### Read dataset
        player_per_game_stats <- read.csv(paste(input,"/player_per_game_stats.csv",sep = ""))
        
        ### Split season column into start end
        player_per_game_stats <- player_per_game_stats %>%
          separate(Season,c("Start","End"),"-")
        
        ### Delete all obervation before 1984
        player_per_game_stats <- player_per_game_stats[which(player_per_game_stats$Start>=1984),]
        
        ### Exclude all non-NBA lg observation
        player_per_game_stats <- player_per_game_stats[which(player_per_game_stats$Lg=="NBA"),]
        
        ### Rename the column
        colnames(player_per_game_stats) <- c("Start","End","Age","Team","League",
                                             "Position","G","GS","MP","FG","FGA",
                                             "Field_goals_percentage","Three_point_field_goals_per_game",
                                             "Three_point_field_goals_attempt_per_game","Three_point_field_goal_percentage",
                                             "Two_point_field_goals_per_game","Two_point_field_goals_attempt_per_game","Two_point_field_goal_percentage",
                                             "efG","FT","FTA","FT_percentage","ORB","DRB","TRB","AST","STL","BLK","TOV","PF","PTS","Player","ID"
        )
        
        ### Exclude players who played less than 20 games in a season
        player_per_game_stats$G <- as.numeric(player_per_game_stats$G) ### Error message: G is a factor. Need to change it to numeric
        player_per_game_stats <- player_per_game_stats[player_per_game_stats$G>=20,]
        
        ### Add Season column back
        player_per_game_stats$Season <- paste(player_per_game_stats$Start,"-",player_per_game_stats$End,sep = "")
        
        ### Clean dataset advanced_stats
        ### Read dataset 
        advanced_stats <- read.csv(paste(input,"/advanced_stats.csv",sep = ""))
        
        ### Split season column into start end
        advanced_stats <- advanced_stats %>%
          separate(Season,c("Start","End"),"-")
        
        ### Delete all obervation before 1984
        advanced_stats <- advanced_stats[which(advanced_stats$Start>=1984),]
        
        ### Exclude all non-NBA lg observation
        advanced_stats <- advanced_stats[which(advanced_stats$Lg=="NBA"),]
        
        ### Exclude players who played less than 20 games in a season
        advanced_stats <- advanced_stats[advanced_stats$G>=20,]
        
        ### Add Season Column back
        advanced_stats$Season <- paste(advanced_stats$Start,"-",advanced_stats$End,sep = "")
        
        ### rename the column
        colnames(advanced_stats) <- c("Start","End","Age","Team","League",
                                      "Position","G","MP","PER","True_Shooting_Percentage",
                                      "three_point_attempt_rate","Free_throw_rate","Offensive_rebound_percentage",
                                      "Defensive_rebound_percentage","Total_rebound_percentage","Assistant_percentage",
                                      "Steal_percentage","Block_percentage","Turnover_percentage","UsaGE_percentage",
                                      "Offensive_win_shares","Defensive_win_shares","win_shares","win_shares_per_48_minutes",
                                      "Offensive_box_plus_minus","Defensive_box_plus_minus","Box_plus_minus","Value_over_replacement_player",
                                      "Player","ID","Season"
        )
        
        ### Clean dataset player_salary
        ### Read dataset
        player_salary <- read.csv(paste(input,"/player_salary.csv",sep = ""))
        
        ### Split season column into start end
        player_salary <- player_salary %>%
          separate(Season,c("Start","End"),"-")
        
        ### Delete all obervation before 1984
        player_salary <- player_salary[which(player_salary$Start>=1984),]
        
        ### Exclude all non-NBA lg observation
        player_salary$Season <- paste(player_salary$Start,"-",player_salary$End,sep = "")
        
        ### Rename the column
        colnames(player_salary) <- c("Start","End","Team","League",
                                     "Salary","Player","ID","Season")
         
      ### Finish cleaning process. Output the results
         write.csv(player_per_game_stats,paste(output,"/player_per_game_stats.csv",sep = ""),row.names = FALSE)
         write.csv(advanced_stats,paste(output,"/advanced_stats.csv",sep = ""),row.names = FALSE)
         write.csv(player_salary,paste(output,"/player_salary.csv",sep = ""),row.names = FALSE)
         
         