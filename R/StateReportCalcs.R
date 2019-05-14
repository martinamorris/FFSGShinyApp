library(dplyr)
library(tidyr)
library(DT)
source("R/permillcalculation.R")


load("extdata/fe.clean.Rdata")
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
barplot(top10, city, Total)


getrank <- function(stateabbr, capita = TRUE) {
  festates <- permillcalc(capita=capita)
  if(capita == TRUE) {
    festates <- festates %>%
      select(state, mean) %>%
      arrange(desc(mean))
  } else {
    festates <- festates %>%
      select(state, Total) %>%
      arrange(desc(Total))
  }
  rank <- which(festates$state == stateabbr)
  return(rank)
}


## Create Table of Metrics

counts <- permillcalc(capita = FALSE)
capita <- permillcalc(capita = TRUE)

state_capita <- capita[which(capita$state == "WA"),]
state_counts <- counts[which(counts$state == "WA"),]

Metric <- c("In 2017", "Since 2000", "Rank")
Capita <- c(state_capita$p2017, state_capita$mean, getrank("WA", capita = TRUE))
Counts <- c(state_counts$p2017, state_counts$Total, getrank("WA", capita = FALSE))

Metrics <- data.frame(Metric, Counts, Capita)

Metric_DT <- datatable(Metrics)

##Map

library(leaflet)

leaflet(festate) %>% addTiles() %>%
  addMarkers(lng = ~longitude, lat = ~latitude, clusterOptions = markerClusterOptions())

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
