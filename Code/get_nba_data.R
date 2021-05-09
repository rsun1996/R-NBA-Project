## Project Code for UTSA R Class 
### Author: Renhao Sun 
### Project Stage One: Scraping stats from Basketball Reference

### Step One: Setting up direction and loading all packages 
mydir = "C:/Users/peter/Documents/UTSA/R/Project"
codedir = paste(mydir,"/Code",sep = "")
input =  paste(mydir,"/Data",sep = "")
source(paste(codedir,"/Package.R",sep = ""))
library("rvest")

### Step Two: Create a trim function which uses regular expressions to clean white space
trim <- function( x ) {
  gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)
}

### Step Three: grab player stats for each season both basic and advanced stats
season <- c(1981:2021)
per_game_stats = NULL
for(i.season in 1:length(season)){
  i.year <- season[i.season]
  i.url <- paste("https://www.basketball-reference.com/leagues/NBA_",i.year,"_per_game.html",sep = "")
  html <- read_html(i.url)
  get_per_game_stats <- html_nodes(html,"#per_game_stats")
  table_per_game_stats <- html_table(get_per_game_stats)
  i.per_game_stats <- data.frame(table_per_game_stats[[1]])
  i.per_game_stats <- i.per_game_stats[which(i.per_game_stats$Rk != "Rk"),]
  per_game_stats = rbind(per_game_stats,i.per_game_stats)
}

advance_stats = NULL
for(i.season in 1:length(season)){
  i.year <- season[i.season]
  i.url <- paste("https://www.basketball-reference.com/leagues/NBA_",i.year,"_advanced.html",sep = "")
  html <- read_html(i.url)
  get_advanced_stats <- html_nodes(html,"#advanced_stats")
  table_advanced_stats <- html_table(get_advanced_stats)
  i.advanced_stats <- data.frame(table_advanced_stats[[1]])
  i.advanced_stats <- i.advanced_stats[which(i.advanced_stats$Rk != "Rk"),]
  advance_stats = rbind(advance_stats,i.advanced_stats)
}

### Step Four: grab each player's salaries for each year
alphabet <- c('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 
              'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 
              'y', 'z')
salay <- paste(input,"/salary",sep = "")

for(i.alph in 1:length(alphabet)){
  i.char <- alphabet[i.alph]
  i.url <- paste("https://www.basketball-reference.com/players/",i.char,"/",sep = "")
  html <- read_html(i.url)
  get_player_table <- html_nodes(html,"#players")
  player_table <- html_table(get_player_table)
  i.player_table <- data.frame(player_table[[1]])
  all_links <- data.frame(html=character())
  link_list = NULL
  for(i.link in 1:nrow(i.player_table)){
    get_links <- html_nodes(html, paste0("tr:nth-child(",i.link,") a")) %>% html_attr("href")
    link_list = c(link_list,get_links[1])
  }
  all_links$html = link_list
  all_links$full_link = paste(i.url,all_links$html,sep = "")
  for(i.link in 1:nrow(all_links)){
    i.player.url <- all_links$full_link[i.link]
    html <- read_html(i.player.url)
    get_salaries <- html_nodes(html,"#div_all_salaries")
    
  }
}




### Step Four: write data as csv file in the input folder
write.csv(per_game_stats,paste(input,"/per_game_stats.csv",sep = ""),row.names = FALSE)
