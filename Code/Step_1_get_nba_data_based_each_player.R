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

### Step Three: Build a player table including playerID, full_link
alphabet <- c('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 
              'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 
              'y', 'z')
player_table = NULL
for(i.alph in 1:length(alphabet)){
  i.char <- alphabet[i.alph]
  i.url <- paste("https://www.basketball-reference.com/players/",i.char,"/",sep = "")
  html <- read_html(i.url)
  get_player_table <- html_nodes(html,"#players")
  i.player_table <- html_table(get_player_table)
  i.player_table <- data.frame(i.player_table[[1]])
  ID_list = NULL
  for(i.link in 1:nrow(i.player_table)){
    get_ID <- html_nodes(html, paste0("tr:nth-child(",i.link,") a")) %>% html_attr("href")
    ID_list = c(ID_list,get_ID[1])
  }
  ID_list = str_split_fixed(ID_list,"/",4)
  ID_list = ID_list[,4]
  ID_list = str_sub(ID_list,end = -6)
  i.player_table$ID = ID_list
  i.player_table$full_link = paste(i.url,i.player_table$ID,".html",sep = "")
  player_table = rbind(player_table,i.player_table)
  #for(i.link in 1:nrow(all_links)){
  #  i.player.url <- all_links$full_link[i.link]
  #  html <- read_html(i.player.url)
  #  get_salaries <- html_nodes(html,"#div_all_salaries")
    #}
}
player_table <- read.csv(paste(input,"/player_table.csv",sep = ""))


### Step Four: Get all stats available for each player

### Per game stats
per_game_table <- NULL
for(i.player in 1:nrow(player_table)){
  cat(paste("The " ,i.player,"'s stats have been collected","\n",sep = ""))
  if(player_table$To[i.player] >= 1981){
    i.url <- player_table$full_link[i.player]
    html <- read_html(i.url)
    i.per_game_table <- html_nodes(html,"#per_game")
    i.per_game_table <- html_table(i.per_game_table)
    i.per_game_table <- data.frame(i.per_game_table)
    i.per_game_table <- i.per_game_table[which(i.per_game_table$Age != "NA"),]
    i.per_game_table$player <- player_table$Player[i.player]
    i.per_game_table$ID <- player_table$ID[i.player]
    per_game_table <- rbind(per_game_table,i.per_game_table)
  }
}

### Advanced stats
#player_table$advanced_link = paste(player_table$full_link,"#advanced",sep = "")
advanced_stats <- NULL
for(i.player in 1:nrow(player_table)){
  cat(paste("The " ,i.player,"'s stats have been collected","\n",sep = ""))
  if(player_table$To[i.player] >= 1981){
    i.url <- as.character(player_table$full_link[i.player])
    html <- read_html(i.url)
    html <- html_nodes(html,xpath = "//comment()")
    i.advanced <- html %>%
      html_text() %>%    # extract comment text
      paste(collapse = '') %>%    # collapse to a single string
      read_html() %>%    # reparse to HTML
      html_node('table#advanced') %>%    # select the desired table
      html_table()
    i.advanced <- data.frame(i.advanced)
    i.advanced <- i.advanced[which(i.advanced$Age != "NA"),]
    i.advanced$player <- player_table$Player[i.player]
    i.advanced$ID <- player_table$ID[i.player]
    advanced_stats <- rbind(advanced_stats,i.advanced)
  }
}

### Salaries 
player_salary <- NULL
for(i.player in 1:nrow(player_table)){
  tryCatch({
  cat(paste("The " ,i.player,"'s stats have been collected","\n",sep = ""))
  if(player_table$To[i.player] >= 1981){
    i.url <- as.character(player_table$full_link[i.player])
    html <- read_html(i.url)
    html <- html_nodes(html,xpath = "//comment()")
    i.salary <- html %>%
      html_text() %>%    # extract comment text
      paste(collapse = '') %>%    # collapse to a single string
      read_html() %>%    # reparse to HTML
      html_node('table#all_salaries') %>%    # select the desired table
      html_table()
    i.salary <- data.frame(i.salary)
    i.salary <- i.salary[which(i.salary$Season != "Career"),]
    i.salary$player <- player_table$Player[i.player]
    i.salary$ID <- player_table$ID[i.player]
    player_salary <- rbind(player_salary,i.salary)
  }}, error=function(e){cat(conditionMessage(e))})
}

### College Stats #all_college_stats
college_stats <- NULL
for(i.player in 1:nrow(player_table)){
  tryCatch({
    cat(paste("The " ,i.player,"'s stats have been collected","\n",sep = ""))
    if(player_table$To[i.player] >= 1981){
      i.url <- as.character(player_table$full_link[i.player])
      html <- read_html(i.url)
      html <- html_nodes(html,xpath = "//comment()")
      i.college_stats <- html %>%
        html_text() %>%    # extract comment text
        paste(collapse = '') %>%    # collapse to a single string
        read_html() %>%    # reparse to HTML
        html_node('table#all_college_stats') %>%    # select the desired table
        html_table()
      colnames(i.college_stats)<- i.college_stats[1,]
      i.college_stats <- i.college_stats[-1,]
      i.college_stats <- i.college_stats[-1,]
      i.college_stats <- i.college_stats[which(i.college_stats$Season != "Career"),]
      i.college_stats$player <- player_table$Player[i.player]
      i.college_stats$ID <- player_table$ID[i.player]
      college_stats <- rbind(college_stats,i.college_stats)
    }}, error=function(e){cat(conditionMessage(e))})
}

### Step Five: write data as csv file in the input folder
write.csv(player_table,paste(input,"/player_table.csv",sep = ""),row.names = FALSE)
write.csv(advanced_stats,paste(input,"/advanced_stats.csv",sep = ""),row.names = FALSE)
write.csv(player_salary,paste(input,"/player_salary.csv",sep = ""),row.names = FALSE)
write.csv(college_stats,paste(input,"/college_stats.csv",sep = ""),row.names = FALSE)
