library(dplyr)
library(tidyr)
library(DT)
source("R/permillcalculation.R")


load("data/fe.clean.Rdata")
fatalencounters <- fe.clean

x = fatalencounters

#filters data for state
festate <- x %>%
  filter(state == "WA")

#finds fatal encounters by race over years
state_race <- festate %>%
  group_by(year) %>%
  count(race) %>%
  spread(year, n)
state_race[is.na(state_race)] <- 0 #replaces NA with 0

#finds fatal encounters by race over years
state_gender <- festate %>%
  group_by(year) %>%
  count(sex) %>%
  spread(year, n)
state_gender[is.na(state_gender)] <- 0 #replaces NA with 0

state_city <- festate %>%
  group_by(year) %>%
  count(city) %>%
  spread(year, n)
state_city[is.na(state_city)] <- 0 #replaces NA with 0
state_city$Total = rowSums(state_city[,2:20])
top10 <- state_city %>%
  arrange(desc(Total)) %>%
  top_n(10, Total) %>%
  select(city, Total)
top10dt <- datatable(top10)

getrank <- function(stateabbr, capita = TRUE) {
  festates <- permillcalc(capita=capita)
  festates <- festates %>%
    select(state, mean) %>%
    arrange(desc(mean))
  rank <- which(festates$state == stateabbr)
  return(rank)
}

#Create plot
linegraph_state <- function(filter){
  if(filter == "none") {
    permillgraph("Washington", FALSE,FALSE)
  }else if(filter == "race") {
    matplot(2000:2017, t(state_race[, 2:19]), type = c("b"),pch=1,col = 1:6, ylab = "Fatal Encounters", xlab = "Year") #plot
    legend("topleft", legend = c("African-American/Black", "Asian/Pacific Islander", "European-American/White", "Hispanic/Latino", "Native American/Alaskan", "Unspecified"), col=1:6, pch=1) # optional legend
  }else{
    matplot(2000:2017, t(state_gender[, 2:19]), type = c("b"),pch=1,col = 1:3, ylab = "Fatal Encounters", xlab = "Year") #plot
    legend("topleft", legend = c("Female", "Male", "Unspecified"), col=1:3, pch=1) # optional legend
  }
}

globalVariables(c("year"))
