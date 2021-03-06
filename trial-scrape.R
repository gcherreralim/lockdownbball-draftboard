library(tidyverse)
library(readr)
library(rvest)
library(xml2)

sample = "https://en.wikipedia.org/wiki/LeBron_James"
samp = read_html(sample) %>%
  html_nodes("table") %>%
  html_table()

#UPDATED: 04/02/21
svurl = "C:\\Users\\GHL\\Desktop\\R Projects\\lockdownbball-draftboard\\Vecenie’s 2021 NBA Draft Big Board, 2.0_ Jalen Suggs up to No. 2, plus NCAA Tournament performance breakdowns – The Athletic.html"
sv = read_html(svurl)
svtab = html_table(sv, fill = TRUE)[[1]] %>%
  separate(col = `PLAYER, SCHOOL/TEAM`, into = c("player", "schoolteam"), sep = ", ") %>%
  mutate(player = ifelse(player == "DJ Stewart Jr. Mississippi State", "DJ Stewart Jr.", player)) %>%
  mutate(schoolteam = ifelse(is.na(schoolteam), "Mississippi State", schoolteam))

#UPDATED: 03/18/21
ringfile = "C:\\Users\\GHL\\Desktop\\R Projects\\lockdownbball-draftboard\\ringertab.csv"
ring = read_csv(ringfile)
ring = ring %>%
  mutate(SchoolTeam = as.factor(SchoolTeam),
         Position = as.factor(Position))
