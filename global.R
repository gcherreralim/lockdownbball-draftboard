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

sampleplayers = c("Cade Cunningham", "Franz Wagner", "Jalen Suggs", "Tre Mann","Scottie Lewis")
sampleceiling = c(100,85,90, 80, 75)
sample75 = c(85, 80, 83, 75, 70)
sample25 = c(60, 40, 55, 35, 40)
samplefloor = c(55, 30, 40, 20, 15)
sampleset = playerbios %>%
  filter(player %in% sampleplayers) %>%
  mutate(ceiling = sampleceiling,
         perc75 = sample75,
         perc25 = sample25,
         floor = samplefloor) %>%
  pivot_longer(cols = c(ceiling, perc75, perc25, floor), names_to = "perc", values_to = "value")

c(unique(sampleset$player))
paste(c(unique(sampleset$player)), collapse = ", ")
