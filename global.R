### USED PACKAGES
pack = c("shiny", "ggplot2", "magrittr", "reactable","tidyverse", "httr", "stringr", "lubridate", "plotly",
         "shinydashboard", "caret", "formattable", "data.table", "highcharter",
         "htmltools", "shinyjs", "leaflet", "reshape2", "class", 
         "FNN", "teamcolors", "ggrepel", "extrafont", "showtext","scales")

options(scipen = 999)
# VERIFY PACKAGES
# package.check <- lapply(pack, FUN = function(x) {
#   if (!require(x, character.only = TRUE)) {
#     install.packages(x, dependencies = TRUE)
#   }
# })

library(shiny)
library(ggplot2)
library(magrittr)
library(reactable)
library(tidyverse)
library(httr)
library(stringr)
library(lubridate)
library(plotly)
library(shinydashboard)
library(caret)
library(formattable)
library(data.table)
library(highcharter)
library(htmltools)
library(shinyjs)
library(leaflet)
library(reshape2)
library(class)
library(FNN)
library(teamcolors)
library(ggrepel)
library(extrafont)
library(showtext)
library(scales)
library(rvest)
library(eeptools)


playerbios = read_csv("playerbios.csv")
playerbios = playerbios %>%
  mutate(birthday = as.Date(birthday, format = "%m/%d/%Y")) %>%
  mutate(draftage = round(age_calc(dob = birthday, enddate = as.Date("07/29/2021", format = "%m/%d/%Y"), units = "years"),2)) %>%
  select(-rank) %>%
  arrange(player)

fullstats = read_csv("fullstats.csv") %>%
  select(-X22,-X23)

playerbios = playerbios %>%
  left_join(fullstats, by = c("player" = "Player")) %>%
  select(-Class,-Team) %>%
  relocate(c(player, year, school_team, ConfLeague, height_in, birthday, draftage), .before = G)
