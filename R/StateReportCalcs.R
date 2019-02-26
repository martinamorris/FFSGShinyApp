library(dplyr)

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

#Create plot
linegraph_state <- function(filter){
  if(filter == "none") {
    permillgraph("Washington", FALSE,FALSE)
    )
  }else if(filer == "race") {
    matplot(2000:2017, t(state_race[, 2:19]), type = c("b"),pch=1,col = 1:6, ylab = "Fatal Encounters", xlab = "Year") #plot
    legend("topleft", legend = c("African-American/Black", "Asian/Pacific Islander", "European-American/White", "Hispanic/Latino", "Native American/Alaskan", "Unspecified"), col=1:6, pch=1) # optional legend
  }else{
    matplot(2000:2017, t(state_gender[, 2:19]), type = c("b"),pch=1,col = 1:3, ylab = "Fatal Encounters", xlab = "Year") #plot
    legend("topleft", legend = c("Female", "Male", "Unspecified"), col=1:3, pch=1) # optional legend
  }
}
