### This code is for mergeing all NBA Output datasets together to produce a large dataset called: NBA_Stats_Merge for analysis later on
### Author: Renhao Sun

    ### Set up mydir
    mydir <- "C:/Users/peter/Documents/UTSA/R/Project"
    codedir <- paste(mydir,"/Code",sep = "")
    input <-  paste(mydir,"/Data",sep = "")
    output <- paste(mydir,"/Output/Data",sep = "")
    source(paste(codedir,"/Package.R",sep = ""))
    library(tidyverse)
    
    ### Read all clean datasets
    player_per_game_stats <- read.csv(paste(output,"/player_per_game_stats.csv",sep = ""))
    advanced_stats <- read.csv(paste(output,"/advanced_stats.csv",sep = ""))
    player_salary <- read.csv(paste(output,"/player_salary.csv",sep = ""))
    
    ### Merge all dataset together as one
    NBA_Stats_Merge <- sqldf(
      "Select a.Start,a.End,a.Season,a.Player,a.ID,a.Team,a.Position,
      a.G,a.GS,a.MP,a.FG,a.FGA,a.Field_goals_percentage,a.Three_point_field_goals_per_game,
      a.Three_point_field_goals_attempt_per_game,a.Three_point_field_goal_percentage,
      a.Two_point_field_goals_per_game,a.Two_point_field_goals_attempt_per_game,a.Two_point_field_goal_percentage,
      a.efG,a.FT,a.FTA,a.FT_percentage,a.ORB,a.DRB,a.TRB,a.AST,a.STL,a.BLK,a.TOV,a.PF,a.PTS,
      b.MP,b.PER,b.True_Shooting_Percentage,b.three_point_attempt_rate,
      b.Free_throw_rate,b.Offensive_rebound_percentage,b.Defensive_rebound_percentage,b.Total_rebound_percentage,b.Assistant_percentage,
      b.Steal_percentage,b.Block_percentage,b.Turnover_percentage,b.UsaGE_percentage,b.Offensive_win_shares,b.Defensive_win_shares,b.win_shares,
      b.win_shares_per_48_minutes,b.Offensive_box_plus_minus,b.Defensive_box_plus_minus,b.Box_plus_minus,b.Value_over_replacement_player,
      c.Salary
      FROM player_per_game_stats AS a
      INNER JOIN advanced_stats AS b ON a.ID = b.ID
        AND a.Season = b.Season
      INNER JOIN player_salary AS c ON a.ID = c.ID
        AND a.Season = c.Season
      "
    )
    
    ### Output csv file
    write.csv(NBA_Stats_Merge,paste(output,"/NBA_Stats_Merge.csv",sep = ""),row.names = FALSE)
    
    