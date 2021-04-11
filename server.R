server <- function(input,output,session){
  
  ############## SERVER CODE FOR 'TEAM EVALUATION' TAB ################
  # Allow to select a name from the list of pre-existing names:
  observe({
    updateSelectizeInput(
      session = session,
      inputId = "TEteams",
      label = "Select up to 10 teams:",
      choices = list(
        "2015 - 2016" = sort(unique(genteams$TeamCode[genteams$Season == 2016])),
        "2016 - 2017" = sort(unique(genteams$TeamCode[genteams$Season == 2017])),
        "2017 - 2018" = sort(unique(genteams$TeamCode[genteams$Season == 2018])),
        "2018 - 2019" = sort(unique(genteams$TeamCode[genteams$Season == 2019])),
        "2019 - 2020" = sort(unique(genteams$TeamCode[genteams$Season == 2020]))),
      selected = NULL)
  })
  
  TE_out1 = reactive({
    genteams %>%
      filter(TeamCode %in% input$TEteams)
  })
  
  TE_out2 = reactive({
    genteams
  })
  
  TE_var1 = reactive({
    genteams %>%
      select(!!input$TExaxis)
  })
  
  TE_var2 = reactive({
    genteams %>%
      select(!!input$TEyaxis)
  })
  
  output$TEChartTitle = renderText({
    paste0(input$TExaxis, " - ", input$TEyaxis, " Comparison")
  })
  
  TEChartOut = reactive({
    
    req(input$TExaxis, input$TEyaxis)
    
    if (!input$TEall) {
      ggplot(TE_out1(), aes(x = !!input$TExaxis, y = !!input$TEyaxis,
                            xmax = max(TE_var1()), ymax = max(TE_var2()), 
                            color = name, fill = name)) +
        geom_point(shape = 21, size = 4, stroke = 1, show.legend = F) +
        ggrepel::geom_label_repel(aes(label = TeamCode), show.legend = F,
                                  fontface = "bold",
                                  box.padding = unit(0.55, "lines"),
                                  point.padding = unit(0.55, "lines"),
                                  segment.size = 1) +
        scale_fill_teams(2) +
        scale_color_teams(1) +
        labs(caption = "lockdownbball.online/team-comps   |   Brett Kornfeld   |   Gabby Herrera-Lim   |   Source: NBAstuffer") + 
        theme(text = element_text(color = "#030303",
                                  face = "bold"),
              panel.grid.major = element_line(colour = "#E4E4E4"),
              panel.grid.minor = element_line(color = "#E4E4E4"),
              panel.background = element_rect(fill = 'white'),
              axis.ticks = element_blank())
    } else {
      ggplot(TE_out2(), aes(x = !!input$TExaxis, y = !!input$TEyaxis,
                            xmax = max(TE_var1()), ymax = max(TE_var2()), 
                            color = name, fill = name)) +
        geom_point(data = TE_out2() %>%
                     filter(TeamCode %notin% input$TEteams),
                   shape = 21, size = 4, stroke = 1, show.legend = F, alpha = 0.35) +
        geom_point(data = TE_out2() %>%
                     filter(TeamCode %in% input$TEteams),
                   shape = 21, size = 4, stroke = 1, show.legend = F) +
        ggrepel::geom_label_repel(data = TE_out2() %>%
                                    filter(TeamCode %in% input$TEteams),
                                  aes(label = TeamCode), show.legend = F,
                                  fontface = "bold",
                                  box.padding = unit(2, "lines"),
                                  point.padding = unit(0.55, "lines"),
                                  segment.size = 1) +
        scale_fill_teams(2) +
        scale_color_teams(1) +
        labs(caption = "lockdownbball.online/team-comps   |   Brett Kornfeld   |   Gabby Herrera-Lim   |   Source: NBAstuffer") + 
        theme(text = element_text(color = "#030303",
                                  face = "bold"),
              panel.grid.major = element_line(colour = "#E4E4E4"),
              panel.grid.minor = element_line(color = "#E4E4E4"),
              panel.background = element_rect(fill = 'white'),
              axis.ticks = element_blank())
    }
  })
  
  
  output$TEChart = renderPlot({
    validate(
      need(length(input$TEteams) > 1,
           "Please select at least two teams to see plot and table results!")
    )
    
    req(TEChartOut())
    TEChartOut()
  })
  

  output$TEtable = renderReactable({
    validate(
      need(length(input$TEteams) > 1,
           "")
    )
    
    reactable(TE_out1(), pagination = FALSE, striped = FALSE, searchable = FALSE, defaultSorted = as.character(input$TE), defaultSortOrder = "desc",
              selection = "single", onClick = "select",
              theme = reactableTheme(
                rowSelectedStyle = list(backgroundColor = "rgba(23, 64, 139, 0.9)", color = "#FFF", fontWeight = "600", boxShadow = "inset 2px 0 0 0 #C9082A")
              ),
              defaultColDef = colDef(align = "center",
                                     minWidth = 90),
              columns = list(
                Team = colDef(show = FALSE),
                TeamCode = colDef(name = "Team"),
                Div = colDef(name = "Division"),
                Season = colDef(show = FALSE),
                SeasonRange = colDef(name = "Season"),
                Wins = colDef(name = "W"),
                Losses = colDef(name = "L"),
                WinPerc = colDef(name = "W%"),
                EstWinPerc = colDef(show = FALSE),
                ProjWinPerc = colDef(show = FALSE),
                AchLevel = colDef(show = FALSE),
                SchedAdjRTG = colDef(name = "SchedARtg"),
                Consistency = colDef(name = "Cons"),
                AvgPTDiff = colDef(name = "Diff"),
                EFFDiff = colDef(name = "eDiff"),
                ASTPerc = colDef(name = "AST%"),
                ORebPerc = colDef(name = "OREB%"),
                DRebPerc = colDef(name = "DREB%"),
                RebPerc = colDef(name = "REB%"),
                TOVPerc = colDef(name = "TOV%"),
                eFGPercSeason = colDef(name = "eFG%"),
                TSPerc = colDef(name = "TS%"),
                Playoff = colDef(show = FALSE),
                name = colDef(show = FALSE),
                primary = colDef(show = FALSE),
                secondary = colDef(show = FALSE),
                .selection = colDef(show = FALSE)
              ),
              showSortIcon = FALSE,
              highlight = TRUE)
  })
  observeEvent(input$TE_reset,{
    updateSelectizeInput(session, 'TEteams', selected = "")
    updateVarSelectInput(session, 'TExaxis', selected = "oEFF")
    updateVarSelectInput(session, 'TEyaxis', selected = "WinPerc")
    updateCheckboxInput(session, "TEall", value = FALSE)
  })
  
  output$TE_plotdownappear = renderUI({
    if(length(input$TEteams)>=2){
      downloadButton('TE_graphdownload', "Download the graph")
    }
  })
  
  output$TE_graphdownload = downloadHandler(
    filename = function(){
      paste0(as.character(input$TExaxis),"-",as.character(input$TEyaxis),' Comparison Graph (',paste(input$TEteams,collapse=","), ').png')
    },
    content = function(graphfile){
      req(TEChartOut())
      ggsave(graphfile, plot = TEChartOut(), device = 'png')
    }
  )
  
  # output$TE_tabdownappear = renderUI({
  #   if(length(input$TEteams)>=2){
  #     downloadButton('TE_tabledownload',"Download the data")
  #   }
  # })
  # 
  # output$TE_tabledownload <- downloadHandler(
  #   filename = function() {
  #     paste0(as.character(input$TExaxis),"-",as.character(input$TEyaxis),' Comparisons (',paste(input$TEteams,collapse=","), ').csv')
  #   },
  #   content = function(file) {
  #     TEtabledown1 = TE_out1() %>%
  #       select(-Team, -Season, -EstWinPerc, -ProjWinPerc, -AchLevel, -Playoff, -name, -primary, -secondary)
  #     
  #     write.csv(TEtabledown1, file, row.names = FALSE)
  #   }
  # )
  
  ############## SERVER CODE FOR 'PERCENTILE TOOL' TAB ################
  #PLAYER 1 INPUT
  output$PT_P1_75TH = renderUI({
    numericInput(inputId = "PT_P1_75",
                 label = "75TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P1_100),
                 step = 1)})
  output$PT_P1_25TH = renderUI({
    numericInput(inputId = "PT_P1_25",
                 label = "25TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P1_75),
                 step = 1)})
  output$PT_P1_FLOOR = renderUI({
    numericInput(inputId = "PT_P1_0",
                 label = "FLOOR",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P1_25),
                 step = 1)})
  #PLAYER 2 INPUT
  output$PT_P2_75TH = renderUI({
    numericInput(inputId = "PT_P2_75",
                 label = "75TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P2_100),
                 step = 1)})
  output$PT_P2_25TH = renderUI({
    numericInput(inputId = "PT_P2_25",
                 label = "25TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P2_75),
                 step = 1)})
  output$PT_P2_FLOOR = renderUI({
    numericInput(inputId = "PT_P2_0",
                 label = "FLOOR",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P2_25),
                 step = 1)})
  
  #PLAYER 3 INPUT
  output$PT_P3_75TH = renderUI({
    numericInput(inputId = "PT_P3_75",
                 label = "75TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P3_100),
                 step = 1)})
  output$PT_P3_25TH = renderUI({
    numericInput(inputId = "PT_P3_25",
                 label = "25TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P3_75),
                 step = 1)})
  output$PT_P3_FLOOR = renderUI({
    numericInput(inputId = "PT_P3_0",
                 label = "FLOOR",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P3_25),
                 step = 1)})
  
  #PLAYER 4 INPUT
  output$PT_P4_75TH = renderUI({
    numericInput(inputId = "PT_P4_75",
                 label = "75TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P4_100),
                 step = 1)})
  output$PT_P4_25TH = renderUI({
    numericInput(inputId = "PT_P4_25",
                 label = "25TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P4_75),
                 step = 1)})
  output$PT_P4_FLOOR = renderUI({
    numericInput(inputId = "PT_P4_0",
                 label = "FLOOR",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P4_25),
                 step = 1)})
  
  #PLAYER 5 INPUT
  output$PT_P5_75TH = renderUI({
    numericInput(inputId = "PT_P5_75",
                 label = "75TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P5_100),
                 step = 1)})
  output$PT_P5_25TH = renderUI({
    numericInput(inputId = "PT_P5_25",
                 label = "25TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P5_75),
                 step = 1)})
  output$PT_P5_FLOOR = renderUI({
    numericInput(inputId = "PT_P5_0",
                 label = "FLOOR",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P5_25),
                 step = 1)})
  
  #PLAYER 5 INPUT
  output$PT_P5_75TH = renderUI({
    numericInput(inputId = "PT_P5_75",
                 label = "75TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P5_100),
                 step = 1)})
  output$PT_P5_25TH = renderUI({
    numericInput(inputId = "PT_P5_25",
                 label = "25TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P5_75),
                 step = 1)})
  output$PT_P5_FLOOR = renderUI({
    numericInput(inputId = "PT_P5_0",
                 label = "FLOOR",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P5_25),
                 step = 1)})
  
  #PLAYER 6 INPUT
  output$PT_P6_75TH = renderUI({
    numericInput(inputId = "PT_P6_75",
                 label = "75TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P6_100),
                 step = 1)})
  output$PT_P6_25TH = renderUI({
    numericInput(inputId = "PT_P6_25",
                 label = "25TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P6_75),
                 step = 1)})
  output$PT_P6_FLOOR = renderUI({
    numericInput(inputId = "PT_P6_0",
                 label = "FLOOR",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P6_25),
                 step = 1)})
  
  #PLAYER 7 INPUT
  output$PT_P7_75TH = renderUI({
    numericInput(inputId = "PT_P7_75",
                 label = "75TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P7_100),
                 step = 1)})
  output$PT_P7_25TH = renderUI({
    numericInput(inputId = "PT_P7_25",
                 label = "25TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P7_75),
                 step = 1)})
  output$PT_P7_FLOOR = renderUI({
    numericInput(inputId = "PT_P7_0",
                 label = "FLOOR",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P7_25),
                 step = 1)})
  
  #PLAYER 8 INPUT
  output$PT_P8_75TH = renderUI({
    numericInput(inputId = "PT_P8_75",
                 label = "75TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P8_100),
                 step = 1)})
  output$PT_P8_25TH = renderUI({
    numericInput(inputId = "PT_P8_25",
                 label = "25TH",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P8_75),
                 step = 1)})
  output$PT_P8_FLOOR = renderUI({
    numericInput(inputId = "PT_P8_0",
                 label = "FLOOR",
                 value = 0,
                 min = 0,
                 max = as.numeric(input$PT_P8_25),
                 step = 1)})
  
  # Selected Team - Freq
  PTCteamfreq = reactive({
    playtypeFreq %>%
      filter(Team == input$PTC_team,
             SeasonRange == input$PTC_season,
             OffDef == input$PTC_offdef)
  })
  
  # Selected Team - Perc
  PTCteamperc = reactive({
    playtypePerc %>%
      filter(Team == input$PTC_team,
             SeasonRange == input$PTC_season,
             OffDef == input$PTC_offdef)
  })

  # Other Teams - Eff
  PTCothereff = reactive({
    PTCotherteamsE = playtypeEff %>%
      filter(Team != input$PTC_team,
             Conf %in% input$PTC_conf,
             OffDef == input$PTC_offdef)
    PTCotherteamsE
  })
  
  # Other Teams - Freq
  PTCotherfreq = reactive({
    PTCotherteamsF = playtypeFreq %>%
      filter(Team != input$PTC_team,
             Conf %in% input$PTC_conf,
             OffDef == input$PTC_offdef)
    PTCotherteamsF
  })

  # Other Teams - Perc
  PTCotherperc = reactive({
    PTCotherteamsP = playtypePerc %>%
      filter(Team != input$PTC_team,
             Conf %in% input$PTC_conf,
             OffDef == input$PTC_offdef)
    PTCotherteamsP
  })

  # Merge - Eff
  PTCallEff = reactive({
    rbind(PTCteameff(), PTCothereff())
  })
  
  # Merge - Freq
  PTCallFreq = reactive({
    rbind(PTCteamfreq(), PTCotherfreq())
  })

  # Merge - Perc
  PTCallPerc = reactive({
    rbind(PTCteamperc(), PTCotherperc())
  })

  # KNN Data - Eff
  PTC_KNNeff = reactive({
    if (input$PTC_offdef == "offense") {
      
      KNNeff = PTCallEff() %>%
        select(8:17)
      KNNeff
    } else {
      KNNeff = PTCallEff() %>%
        select(9:17)
      KNNeff
    }
  })
  
  # KNN Data - Freq
  PTC_KNNfreq = reactive({
    if (input$PTC_offdef == "offense") {
      
      KNNfreq = PTCallFreq() %>%
        select(8:17)
      KNNfreq
    } else {
      KNNfreq = PTCallFreq() %>%
        select(9:17)
      KNNfreq
    }
  })

  # KNN Data - Perc
  PTC_KNNperc = reactive({
    if (input$PTC_offdef == "offense") {
      
      KNNfreq = PTCallPerc() %>%
        select(8:17)
      KNNfreq
    } else {
      KNNfreq = PTCallPerc() %>%
        select(9:17)
      KNNfreq
    }
  })

  # KNN Eff
  PTC_KNNmatch_e = reactive({
    as.numeric(knnx.index(PTC_KNNeff(), PTC_KNNeff()[1, ,drop = FALSE], k = 6))
  })
  
  # KNN Freq
  PTC_KNNmatch_f = reactive({
    as.numeric(knnx.index(PTC_KNNfreq(), PTC_KNNfreq()[1, ,drop = FALSE], k = 6))
  })

  # KNN Perc
  PTC_KNNmatch_p = reactive({
    as.numeric(knnx.index(PTC_KNNperc(), PTC_KNNperc()[1, ,drop = FALSE], k = 6))
  })

  # TEAM MATCHES
  PTC_match_e = reactive({
    allmatch_e = PTCallEff()[PTC_KNNmatch_e(),]
    selteam_e = allmatch_e[1,]
    othermatch_e = allmatch_e[-1,]
    combine_e = rbind(selteam_e, othermatch_e)
  })
  
  PTC_match_f = reactive({
    allmatch_f = PTCallFreq()[PTC_KNNmatch_f(),]
    selteam_f = allmatch_f[1,]
    othermatch_f = allmatch_f[-1,]
    combine_f = rbind(selteam_f, othermatch_f)
  })

  PTC_match_p = reactive({
    allmatch_p = PTCallPerc()[PTC_KNNmatch_p(),]
    selteam_p = allmatch_p[1,]
    othermatch_p = allmatch_p[-1,]
    combine_p = rbind(selteam_p, othermatch_p)
  })

  PTC_PPPdata = reactive({
    if (input$PTC_offdef == "offense") {
      
      PTC_match_e() %>%
        select(Cut, Handoff, Iso, OffScreen, PNRHandler, PNRRollman, PostUp, Putbacks, SpotUp, Transition)
      
    } else{
      
      PTC_match_e() %>%
        select(Handoff, Iso, OffScreen, PNRHandler, PNRRollman, PostUp, Putbacks, SpotUp, Transition)
    }
  })
  
  PTC_FREQdata = reactive({
    if (input$PTC_offdef == "offense") {
      
      PTC_match_f() %>%
        select(Cut, Handoff, Iso, OffScreen, PNRHandler, PNRRollman, PostUp, Putbacks, SpotUp, Transition)
      
    } else{
      
      PTC_match_f() %>%
        select(Handoff, Iso, OffScreen, PNRHandler, PNRRollman, PostUp, Putbacks, SpotUp, Transition)
    }
  })
  
  PTC_PERCdata = reactive({
    if (input$PTC_offdef == "offense") {
      
      PTC_match_p() %>%
        select(Cut, Handoff, Iso, OffScreen, PNRHandler, PNRRollman, PostUp, Putbacks, SpotUp, Transition)
      
    } else{
      
      PTC_match_p() %>%
        select(Handoff, Iso, OffScreen, PNRHandler, PNRRollman, PostUp, Putbacks, SpotUp, Transition)
    }
  })
  
  ### Images
  # Selected Team - PPP
  output$PPPselectedteam = renderUI({
    tags$img(src = paste0(PTCteameff()$TeamCode,".jpg"),
             height = "150px")
  })
  
  # Matches - PPP
  output$PPPteam1 = renderUI({
    tags$img(src = paste0(PTC_match_e()[2,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$PPPteam2 = renderUI({
    tags$img(src = paste0(PTC_match_e()[3,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$PPPteam3 = renderUI({
    tags$img(src = paste0(PTC_match_e()[4,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$PPPteam4 = renderUI({
    tags$img(src = paste0(PTC_match_e()[5,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$PPPteam5 = renderUI({
    tags$img(src = paste0(PTC_match_e()[6,]$TeamCode,".jpg"),
             height = "150px")
  })
  
  # Selected Team - FREQ
  output$FREQselectedteam = renderUI({
    tags$img(src = paste0(PTCteamfreq()$TeamCode,".jpg"),
             height = "150px")
  })
  
  # Matches - FREQ
  output$FREQteam1 = renderUI({
    tags$img(src = paste0(PTC_match_f()[2,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$FREQteam2 = renderUI({
    tags$img(src = paste0(PTC_match_f()[3,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$FREQteam3 = renderUI({
    tags$img(src = paste0(PTC_match_f()[4,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$FREQteam4 = renderUI({
    tags$img(src = paste0(PTC_match_f()[5,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$FREQteam5 = renderUI({
    tags$img(src = paste0(PTC_match_f()[6,]$TeamCode,".jpg"),
             height = "150px")
  })
  
  # Selected Team - PERC
  output$PERCselectedteam = renderUI({
    tags$img(src = paste0(PTCteamperc()$TeamCode,".jpg"),
             height = "150px")
  })
  
  # Matches - PERC
  output$PERCteam1 = renderUI({
    tags$img(src = paste0(PTC_match_p()[2,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$PERCteam2 = renderUI({
    tags$img(src = paste0(PTC_match_p()[3,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$PERCteam3 = renderUI({
    tags$img(src = paste0(PTC_match_p()[4,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$PERCteam4 = renderUI({
    tags$img(src = paste0(PTC_match_p()[5,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$PERCteam5 = renderUI({
    tags$img(src = paste0(PTC_match_p()[6,]$TeamCode,".jpg"),
             height = "150px")
  })
  
  # Selected Team - ED
  output$EDselectedteam = renderUI({
    tags$img(src = paste0(PTCteameff()$TeamCode,".jpg"),
             height = "150px")
  })
  
  # Matches - ED
  output$EDteam1 = renderUI({
    tags$img(src = paste0(PTC_match_e()[2,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$EDteam2 = renderUI({
    tags$img(src = paste0(PTC_match_e()[3,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$EDteam3 = renderUI({
    tags$img(src = paste0(PTC_match_e()[4,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$EDteam4 = renderUI({
    tags$img(src = paste0(PTC_match_e()[5,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$EDteam5 = renderUI({
    tags$img(src = paste0(PTC_match_e()[6,]$TeamCode,".jpg"),
             height = "150px")
  })
  
  # Selected Team - FD
  output$FDselectedteam = renderUI({
    tags$img(src = paste0(PTCteamfreq()$TeamCode,".jpg"),
             height = "150px")
  })
  
  # Matches - FD
  output$FDteam1 = renderUI({
    tags$img(src = paste0(PTC_match_f()[2,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$FDteam2 = renderUI({
    tags$img(src = paste0(PTC_match_f()[3,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$FDteam3 = renderUI({
    tags$img(src = paste0(PTC_match_f()[4,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$FDteam4 = renderUI({
    tags$img(src = paste0(PTC_match_f()[5,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$FDteam5 = renderUI({
    tags$img(src = paste0(PTC_match_f()[6,]$TeamCode,".jpg"),
             height = "150px")
  })
  
  # Selected Team - PD
  output$PDselectedteam = renderUI({
    tags$img(src = paste0(PTCteamperc()$TeamCode,".jpg"),
             height = "150px")
  })
  
  # Matches - PD
  output$PDteam1 = renderUI({
    tags$img(src = paste0(PTC_match_p()[2,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$PDteam2 = renderUI({
    tags$img(src = paste0(PTC_match_p()[3,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$PDteam3 = renderUI({
    tags$img(src = paste0(PTC_match_p()[4,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$PDteam4 = renderUI({
    tags$img(src = paste0(PTC_match_p()[5,]$TeamCode,".jpg"),
             height = "150px")
  })
  output$PDteam5 = renderUI({
    tags$img(src = paste0(PTC_match_p()[6,]$TeamCode,".jpg"),
             height = "150px")
  })
  
  ### Graph
  # Eff Plot
  output$PTC_PPPplot = renderPlotly({
    validate(
      need(dim(PTCothereff())[1]>=5, "Sorry, the required number of matches was not met. Please change the input filters.")
    )
    
    #Assigning Team Names for Colors
    PTC_t1e = as.character(PTC_match_e()[1,1])
    PTC_t2e = as.character(PTC_match_e()[2,1])
    PTC_t3e = as.character(PTC_match_e()[3,1])
    PTC_t4e = as.character(PTC_match_e()[4,1])
    PTC_t5e = as.character(PTC_match_e()[5,1])
    PTC_t6e = as.character(PTC_match_e()[6,1])
    
    
    if (input$PTC_offdef == "offense") {
      
      PTC_effplot = plot_ly(type = "scatterpolar",
                            mode = "closest",
                            fill = "toself",
                            colors = color_map) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PPPdata()[1,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          name = PTC_match_e()[1,2],
          marker = list(color = color_map[PTC_t1e]),
          fillcolor = toRGB(color_map[PTC_t1e], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PPPdata()[2,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_e()[2,2],
          marker = list(color = color_map[PTC_t2e]),
          fillcolor = toRGB(color_map[PTC_t2e], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PPPdata()[3,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_e()[3,2],
          marker = list(color = color_map[PTC_t3e]),
          fillcolor = toRGB(color_map[PTC_t3e], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PPPdata()[4,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_e()[4,2],
          marker = list(color = color_map[PTC_t4e]),
          fillcolor = toRGB(color_map[PTC_t4e], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PPPdata()[5,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_e()[5,2],
          marker = list(color = color_map[PTC_t5e]),
          fillcolor = toRGB(color_map[PTC_t5e], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PPPdata()[6,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_e()[6,2],
          marker = list(color = color_map[PTC_t6e]),
          fillcolor = toRGB(color_map[PTC_t6e], alpha = 0.5)
        ) %>%
        layout(
          polar = list(
            radialaxis = list(
              visible = T,
              range = c(0,1.5),
              tickfont = list(size = 11)),
            angularaxis = list(tickfont = list(size = 11))),
          showlegend = TRUE,
          legend = list(font = list(size = 9)),
          annotations = 
            list(x = 1, y = -0.1, text = "lockdownbball.online/team-comps  |  Brett Kornfeld  |  Gabby Herrera-Lim  |  Source: stats.nba.com", 
                 showarrow = F, xref='paper', yref='paper', 
                 xanchor='right', yanchor='auto', xshift=0, yshift=0,
                 font=list(size=8, color="black")))
      PTC_effplot
      
    } else {
      PTC_effplot = plot_ly(type = "scatterpolar",
                            mode = "closest",
                            fill = "toself",
                            colors = color_map) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PPPdata()[1,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          name = PTC_match_e()[1,2],
          marker = list(color = color_map[PTC_t1e]),
          fillcolor = toRGB(color_map[PTC_t1e], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PPPdata()[2,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_e()[2,2],
          marker = list(color = color_map[PTC_t2e]),
          fillcolor = toRGB(color_map[PTC_t2e], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PPPdata()[3,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_e()[3,2],
          marker = list(color = color_map[PTC_t3e]),
          fillcolor = toRGB(color_map[PTC_t3e], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PPPdata()[4,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_e()[4,2],
          marker = list(color = color_map[PTC_t4e]),
          fillcolor = toRGB(color_map[PTC_t4e], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PPPdata()[5,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_e()[5,2],
          marker = list(color = color_map[PTC_t5e]),
          fillcolor = toRGB(color_map[PTC_t5e], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PPPdata()[6,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_e()[6,2],
          marker = list(color = color_map[PTC_t6e]),
          fillcolor = toRGB(color_map[PTC_t6e], alpha = 0.5)
        ) %>%
        layout(
          polar = list(
            radialaxis = list(
              visible = T,
              range = c(0,1.5),
              tickfont = list(size = 11)),
            angularaxis = list(tickfont = list(size = 11))),
          showlegend = TRUE,
          legend = list(font = list(size = 9)),
          annotations = 
            list(x = 1, y = -0.1, text = "lockdownbball.online/team-comps  |  Brett Kornfeld  |  Gabby Herrera-Lim  |  Source: stats.nba.com", 
                 showarrow = F, xref='paper', yref='paper', 
                 xanchor='right', yanchor='auto', xshift=0, yshift=0,
                 font=list(size=8, color="black")))
      PTC_effplot
    }
  })
  

  # Eff Table
  output$PTC_PPPtable = renderReactable({
    if (input$PTC_offdef == "offense") {
      
      reactable(PTC_match_e() %>%
                  select(TeamCode, Conf, Div, Cut, Handoff, Iso, OffScreen, PNRHandler, PNRRollman, PostUp, Putbacks, SpotUp, Transition),
                pagination = FALSE, striped = FALSE, searchable = FALSE,
                selection = "single", onClick = "select",
                theme = reactableTheme(
                  rowSelectedStyle = list(backgroundColor = "rgba(23, 64, 139, 0.9)", color = "#FFF", fontWeight = "600", boxShadow = "inset 2px 0 0 0 #C9082A")
                ),
                defaultColDef = colDef(align = "center",
                                       minWidth = 60),
                columns = list(
                  TeamCode = colDef(name = "Team"),
                  Div = colDef(name = "Division"),
                  Conf = colDef(name = "Conference"),
                  .selection = colDef(show = FALSE)
                ),
                showSortIcon = FALSE,
                highlight = TRUE) 
      
    } else {
      
      reactable(PTC_match_e() %>%
                  select(TeamCode, Conf, Div, Handoff, Iso, OffScreen, PNRHandler, PNRRollman, PostUp, Putbacks, SpotUp, Transition),
                pagination = FALSE, striped = FALSE, searchable = FALSE,
                selection = "single", onClick = "select",
                theme = reactableTheme(
                  rowSelectedStyle = list(backgroundColor = "rgba(23, 64, 139, 0.9)", color = "#FFF", fontWeight = "600", boxShadow = "inset 2px 0 0 0 #C9082A")
                ),
                defaultColDef = colDef(align = "center",
                                       minWidth = 60),
                columns = list(
                  TeamCode = colDef(name = "Team"),
                  Div = colDef(name = "Division"),
                  Conf = colDef(name = "Conference"),
                  .selection = colDef(show = FALSE)
                ),
                showSortIcon = FALSE,
                highlight = TRUE) 
    }
  })

  # Freq Plot
  output$PTC_FREQplot = renderPlotly({
    validate(
      need(dim(PTCotherfreq())[1]>=5, "Sorry, the required number of matches was not met. Please change the input filters.")
    )
    
    #Assigning Team Names for Colors
    PTC_t1f = as.character(PTC_match_f()[1,1])
    PTC_t2f = as.character(PTC_match_f()[2,1])
    PTC_t3f = as.character(PTC_match_f()[3,1])
    PTC_t4f = as.character(PTC_match_f()[4,1])
    PTC_t5f = as.character(PTC_match_f()[5,1])
    PTC_t6f = as.character(PTC_match_f()[6,1])
    
    
    if (input$PTC_offdef == "offense") {
      
      PTC_freqplot = plot_ly(type = "scatterpolar",
                            mode = "closest",
                            fill = "toself",
                            colors = color_map) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_FREQdata()[1,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          name = PTC_match_f()[1,2],
          marker = list(color = color_map[PTC_t1f]),
          fillcolor = toRGB(color_map[PTC_t1f], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_FREQdata()[2,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_f()[2,2],
          marker = list(color = color_map[PTC_t2f]),
          fillcolor = toRGB(color_map[PTC_t2f], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_FREQdata()[3,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_f()[3,2],
          marker = list(color = color_map[PTC_t3f]),
          fillcolor = toRGB(color_map[PTC_t3f], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_FREQdata()[4,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_f()[4,2],
          marker = list(color = color_map[PTC_t4f]),
          fillcolor = toRGB(color_map[PTC_t4f], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_FREQdata()[5,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_f()[5,2],
          marker = list(color = color_map[PTC_t5f]),
          fillcolor = toRGB(color_map[PTC_t5f], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_FREQdata()[6,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_f()[6,2],
          marker = list(color = color_map[PTC_t6f]),
          fillcolor = toRGB(color_map[PTC_t6f], alpha = 0.5)
        ) %>%
        layout(
          polar = list(
            radialaxis = list(
              visible = T,
              range = c(0,35),
              tickfont = list(size = 11)),
            angularaxis = list(tickfont = list(size = 11))),
          showlegend = TRUE,
          legend = list(font = list(size = 9)),
          annotations = 
            list(x = 1, y = -0.1, text = "lockdownbball.online/team-comps  |  Brett Kornfeld  |  Gabby Herrera-Lim  |  Source: stats.nba.com", 
                 showarrow = F, xref='paper', yref='paper', 
                 xanchor='right', yanchor='auto', xshift=0, yshift=0,
                 font=list(size=8, color="black")))
      PTC_freqplot
      
    } else {
      PTC_freqplot = plot_ly(type = "scatterpolar",
                            mode = "closest",
                            fill = "toself",
                            colors = color_map) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_FREQdata()[1,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          name = PTC_match_f()[1,2],
          marker = list(color = color_map[PTC_t1f]),
          fillcolor = toRGB(color_map[PTC_t1f], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_FREQdata()[2,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_f()[2,2],
          marker = list(color = color_map[PTC_t2f]),
          fillcolor = toRGB(color_map[PTC_t2f], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_FREQdata()[3,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_f()[3,2],
          marker = list(color = color_map[PTC_t3f]),
          fillcolor = toRGB(color_map[PTC_t3f], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_FREQdata()[4,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_f()[4,2],
          marker = list(color = color_map[PTC_t4f]),
          fillcolor = toRGB(color_map[PTC_t4f], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_FREQdata()[5,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_f()[5,2],
          marker = list(color = color_map[PTC_t5f]),
          fillcolor = toRGB(color_map[PTC_t5f], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_FREQdata()[6,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_f()[6,2],
          marker = list(color = color_map[PTC_t6f]),
          fillcolor = toRGB(color_map[PTC_t6f], alpha = 0.5)
        ) %>%
        layout(
          polar = list(
            radialaxis = list(
              visible = T,
              range = c(0,35),
              tickfont = list(size = 11)),
            angularaxis = list(tickfont = list(size = 11))),
          showlegend = TRUE,
          legend = list(font = list(size = 9)),
          annotations = 
            list(x = 1, y = -0.1, text = "lockdownbball.online/team-comps  |  Brett Kornfeld  |  Gabby Herrera-Lim  |  Source: stats.nba.com", 
                 showarrow = F, xref='paper', yref='paper', 
                 xanchor='right', yanchor='auto', xshift=0, yshift=0,
                 font=list(size=8, color="black")))
      PTC_freqplot
    }
  })
  
  # Freq Table
  output$PTC_FREQtable = renderReactable({
    if (input$PTC_offdef == "offense") {
      
      reactable(PTC_match_f() %>%
                  select(TeamCode, Conf, Div, Cut, Handoff, Iso, OffScreen, PNRHandler, PNRRollman, PostUp, Putbacks, SpotUp, Transition),
                pagination = FALSE, striped = FALSE, searchable = FALSE,
                selection = "single", onClick = "select",
                theme = reactableTheme(
                  rowSelectedStyle = list(backgroundColor = "rgba(23, 64, 139, 0.9)", color = "#FFF", fontWeight = "600", boxShadow = "inset 2px 0 0 0 #C9082A")
                ),
                defaultColDef = colDef(align = "center",
                                       minWidth = 90),
                columns = list(
                  TeamCode = colDef(name = "Team"),
                  Div = colDef(name = "Division"),
                  Conf = colDef(name = "Conference"),
                  .selection = colDef(show = FALSE)
                ),
                showSortIcon = FALSE,
                highlight = TRUE) 
      
    } else {
      
      reactable(PTC_match_f() %>%
                  select(TeamCode, Conf, Div, Handoff, Iso, OffScreen, PNRHandler, PNRRollman, PostUp, Putbacks, SpotUp, Transition),
                pagination = FALSE, striped = FALSE, searchable = FALSE,
                selection = "single", onClick = "select",
                theme = reactableTheme(
                  rowSelectedStyle = list(backgroundColor = "rgba(23, 64, 139, 0.9)", color = "#FFF", fontWeight = "600", boxShadow = "inset 2px 0 0 0 #C9082A")
                ),
                defaultColDef = colDef(align = "center",
                                       minWidth = 90),
                columns = list(
                  TeamCode = colDef(name = "Team"),
                  Div = colDef(name = "Division"),
                  Conf = colDef(name = "Conference"),
                  .selection = colDef(show = FALSE)
                ),
                showSortIcon = FALSE,
                highlight = TRUE) 
    }
  })
  
  
  # Perc Plot
  output$PTC_PERCplot = renderPlotly({
    validate(
      need(dim(PTCotherperc())[1]>=5, "Sorry, the required number of matches was not met. Please change the input filters.")
    )
    
    PTC_t1p = as.character(PTC_match_p()[1,1])
    PTC_t2p = as.character(PTC_match_p()[2,1])
    PTC_t3p = as.character(PTC_match_p()[3,1])
    PTC_t4p = as.character(PTC_match_p()[4,1])
    PTC_t5p = as.character(PTC_match_p()[5,1])
    PTC_t6p = as.character(PTC_match_p()[6,1])

    
    if (input$PTC_offdef == "offense") {
      
      PTC_percplot = plot_ly(type = "scatterpolar",
                             mode = "closest",
                             fill = "toself",
                             colors = color_map) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PERCdata()[1,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          name = PTC_match_p()[1,2],
          marker = list(color = color_map[PTC_t1p]),
          fillcolor = toRGB(color_map[PTC_t1p], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PERCdata()[2,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_p()[2,2],
          marker = list(color = color_map[PTC_t2p]),
          fillcolor = toRGB(color_map[PTC_t2p], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PERCdata()[3,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_p()[3,2],
          marker = list(color = color_map[PTC_t3p]),
          fillcolor = toRGB(color_map[PTC_t3p], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PERCdata()[4,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_p()[4,2],
          marker = list(color = color_map[PTC_t4p]),
          fillcolor = toRGB(color_map[PTC_t4p], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PERCdata()[5,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_p()[5,2],
          marker = list(color = color_map[PTC_t5p]),
          fillcolor = toRGB(color_map[PTC_t5p], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PERCdata()[6,])),
          theta = c("Cut", "Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_p()[6,2],
          marker = list(color = color_map[PTC_t6p]),
          fillcolor = toRGB(color_map[PTC_t6p], alpha = 0.5)
        ) %>%
        layout(
          polar = list(
            radialaxis = list(
              visible = T,
              range = c(0,100),
              tickfont = list(size = 11)),
            angularaxis = list(tickfont = list(size = 11))),
          showlegend = TRUE,
          legend = list(font = list(size = 9)),
          annotations = 
            list(x = 1, y = -0.1, text = "lockdownbball.online/team-comps  |  Brett Kornfeld  |  Gabby Herrera-Lim  |  Source: stats.nba.com", 
                 showarrow = F, xref='paper', yref='paper', 
                 xanchor='right', yanchor='auto', xshift=0, yshift=0,
                 font=list(size=8, color="black")))
      PTC_percplot
      
    } else {
      
      PTC_percplot = plot_ly(type = "scatterpolar",
                             mode = "closest",
                             fill = "toself",
                             colors = color_map) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PERCdata()[1,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          name = PTC_match_p()[1,2],
          marker = list(color = color_map[PTC_t1p]),
          fillcolor = toRGB(color_map[PTC_t1p], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PERCdata()[2,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_p()[2,2],
          marker = list(color = color_map[PTC_t2p]),
          fillcolor = toRGB(color_map[PTC_t2p], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PERCdata()[3,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_p()[3,2],
          marker = list(color = color_map[PTC_t3p]),
          fillcolor = toRGB(color_map[PTC_t3p], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PERCdata()[4,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_p()[4,2],
          marker = list(color = color_map[PTC_t4p]),
          fillcolor = toRGB(color_map[PTC_t4p], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PERCdata()[5,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_p()[5,2],
          marker = list(color = color_map[PTC_t5p]),
          fillcolor = toRGB(color_map[PTC_t5p], alpha = 0.5)
        ) %>%
        add_trace(
          r = as.numeric(as.matrix(PTC_PERCdata()[6,])),
          theta = c("Handoff", "Iso", "OffScreen", "PNRHandler", "PNRRollman", "PostUp", "Putbacks", "SpotUp", "Transition"),
          showlegend = TRUE,
          mode = "markers",
          visible = "legendonly",
          name = PTC_match_p()[6,2],
          marker = list(color = color_map[PTC_t6p]),
          fillcolor = toRGB(color_map[PTC_t6p], alpha = 0.5)
        ) %>%
        layout(
          polar = list(
            radialaxis = list(
              visible = T,
              range = c(0,100),
              tickfont = list(size = 11)),
            angularaxis = list(tickfont = list(size = 11))),
          showlegend = TRUE,
          legend = list(font = list(size = 9)),
          annotations = 
            list(x = 1, y = -0.1, text = "lockdownbball.online/team-comps  |  Brett Kornfeld  |  Gabby Herrera-Lim  |  Source: stats.nba.com", 
                 showarrow = F, xref='paper', yref='paper', 
                 xanchor='right', yanchor='auto', xshift=0, yshift=0,
                 font=list(size=8, color="black")))
      PTC_percplot
      
    }
  })

  # Perc Table
  output$PTC_PERCtable = renderReactable({
    if (input$PTC_offdef == "offense") {
      
      reactable(PTC_match_p() %>%
                  select(TeamCode, Conf, Div, Cut, Handoff, Iso, OffScreen, PNRHandler, PNRRollman, PostUp, Putbacks, SpotUp, Transition),
                pagination = FALSE, striped = FALSE, searchable = FALSE,
                selection = "single", onClick = "select",
                theme = reactableTheme(
                  rowSelectedStyle = list(backgroundColor = "rgba(23, 64, 139, 0.9)", color = "#FFF", fontWeight = "600", boxShadow = "inset 2px 0 0 0 #C9082A")
                ),
                defaultColDef = colDef(align = "center",
                                       minWidth = 90),
                columns = list(
                  TeamCode = colDef(name = "Team"),
                  Div = colDef(name = "Division"),
                  Conf = colDef(name = "Conference"),
                  .selection = colDef(show = FALSE)
                ),
                showSortIcon = FALSE,
                highlight = TRUE) 
      
    } else {
      
      reactable(PTC_match_p() %>%
                  select(TeamCode, Conf, Div, Handoff, Iso, OffScreen, PNRHandler, PNRRollman, PostUp, Putbacks, SpotUp, Transition),
                pagination = FALSE, striped = FALSE, searchable = FALSE,
                selection = "single", onClick = "select",
                theme = reactableTheme(
                  rowSelectedStyle = list(backgroundColor = "rgba(23, 64, 139, 0.9)", color = "#FFF", fontWeight = "600", boxShadow = "inset 2px 0 0 0 #C9082A")
                ),
                defaultColDef = colDef(align = "center",
                                       minWidth = 90),
                columns = list(
                  TeamCode = colDef(name = "Team"),
                  Div = colDef(name = "Division"),
                  Conf = colDef(name = "Conference"),
                  .selection = colDef(show = FALSE)
                ),
                showSortIcon = FALSE,
                highlight = TRUE) 
      
    }
  })

  # Full Tables
  playtypeMatchEff = reactive({
    playtypes %>%
    filter(TeamCode %in% PTC_match_e()$TeamCode) 
  })
  
  output$PTC_PPPtable2 = renderReactable({
    reactable(playtypeMatchEff() %>%
                select(-Team, -SeasonRange, -Conf, -Div, -Season, -GP, -Mins, -Playoff, -name, -primary, -secondary),
              pagination = TRUE, defaultPageSize = 10, showPageSizeOptions = TRUE, pageSizeOptions = c(10,20,30,50), 
              striped = FALSE, searchable = FALSE, defaultSorted = "PlayType", defaultSortOrder = "asc", filterable = TRUE,
              selection = "single", onClick = "select",
              theme = reactableTheme(
                rowSelectedStyle = list(backgroundColor = "rgba(23, 64, 139, 0.9)", color = "#FFF", fontWeight = "600", boxShadow = "inset 2px 0 0 0 #C9082A")
              ),
              defaultColDef = colDef(align = "center",
                                     minWidth = 90),
              columns = list(
                TeamCode = colDef(name = "Team"),
                Div = colDef(name = "Division"),
                Conf = colDef(name = "Conference"),
                Wins = colDef(name = "W"),
                Losses = colDef(name = "L"),
                WinPerc = colDef(name = "Pct"),
                .selection = colDef(show = FALSE)
              ),
              showSortIcon = FALSE,
              highlight = TRUE)
  })
  
  playtypeMatchFreq = reactive({
    playtypes %>%
      filter(TeamCode %in% PTC_match_f()$TeamCode)
  })
  
  output$PTC_FREQtable2 = renderReactable({
    reactable(playtypeMatchFreq() %>%
                select(-Team, -SeasonRange, -Conf, -Div, -Season, -GP, -Mins, -Playoff, -name, -primary, -secondary),
              pagination = TRUE, defaultPageSize = 10, showPageSizeOptions = TRUE, pageSizeOptions = c(10,20,30,50), striped = FALSE, searchable = FALSE, defaultSorted = "PlayType", defaultSortOrder = "asc", filterable = TRUE,
              selection = "single", onClick = "select",
              theme = reactableTheme(
                rowSelectedStyle = list(backgroundColor = "rgba(23, 64, 139, 0.9)", color = "#FFF", fontWeight = "600", boxShadow = "inset 2px 0 0 0 #C9082A")
              ),
              defaultColDef = colDef(align = "center",
                                     minWidth = 90),
              columns = list(
                TeamCode = colDef(name = "Team"),
                Div = colDef(name = "Division"),
                Conf = colDef(name = "Conference"),
                Wins = colDef(name = "W"),
                Losses = colDef(name = "L"),
                WinPerc = colDef(name = "Pct"),
                .selection = colDef(show = FALSE)
              ),
              showSortIcon = FALSE,
              highlight = TRUE)
  })

  playtypeMatchPerc = reactive({
    playtypes %>%
      filter(TeamCode %in% PTC_match_p()$TeamCode)
  })

  output$PTC_PERCtable2 = renderReactable({
    reactable(playtypeMatchPerc() %>%
                select(-Team, -SeasonRange, -Conf, -Div, -Season, -GP, -Mins, -Playoff, -name, -primary, -secondary),
              pagination = TRUE, defaultPageSize = 10, showPageSizeOptions = TRUE, pageSizeOptions = c(10,20,30,50),
              striped = FALSE, searchable = FALSE, defaultSorted = "PlayType", defaultSortOrder = "asc", filterable = TRUE,
              selection = "single", onClick = "select",
              theme = reactableTheme(
                rowSelectedStyle = list(backgroundColor = "rgba(23, 64, 139, 0.9)", color = "#FFF", fontWeight = "600", boxShadow = "inset 2px 0 0 0 #C9082A")
              ),
              defaultColDef = colDef(align = "center",
                                     minWidth = 90),
              columns = list(
                TeamCode = colDef(name = "Team"),
                Div = colDef(name = "Division"),
                Conf = colDef(name = "Conference"),
                Wins = colDef(name = "W"),
                Losses = colDef(name = "L"),
                WinPerc = colDef(name = "Pct"),
                .selection = colDef(show = FALSE)
              ),
              showSortIcon = FALSE,
              highlight = TRUE)
  })
  
  output$PTC_PPPtabledownload2 <- downloadHandler(
    filename = function() {
      paste0(as.character(input$PTC_team),"_",as.character(input$PTC_season),"_",as.character(input$PTC_offdef),'efficiencymatchtable', '.csv')
    },
    content = function(file) {
      PPPtabledown1 = playtypeMatchEff()
      
      PPPtabledown2 <- PPPtabledown1 %>% 
        select(-Team, -SeasonRange, -Conf, -Div, -Season, -GP, -Mins, -Playoff, -name, -primary, -secondary)  
      
      write.csv(PPPtabledown2, file)
    }
  )
  
  output$PTC_FREQtabledownload2 <- downloadHandler(
    filename = function() {
      paste0(as.character(input$PTC_team),"_",as.character(input$PTC_season),"_",as.character(input$PTC_offdef),'frequencymatchtable', '.csv')
    },
    content = function(file) {
      FREQtabledown1 = playtypeMatchFreq()
      
      FREQtabledown2 <- FREQtabledown1 %>% 
        select(-Team, -SeasonRange, -Conf, -Div, -Season, -GP, -Mins, -Playoff, -name, -primary, -secondary)  
      
      write.csv(FREQtabledown2, file)
    }
  )
  
  output$PTC_PERCtabledownload2 <- downloadHandler(
    filename = function() {
      paste0(as.character(input$PTC_team),"_",as.character(input$PTC_season),"_",as.character(input$PTC_offdef),'percentilematchtable', '.csv')
    },
    content = function(file) {
      PERCtabledown1 = playtypeMatchPerc()
      
      PERCtabledown2 <- PERCtabledown1 %>% 
        select(-Team, -SeasonRange, -Conf, -Div, -Season, -GP, -Mins, -Playoff, -name, -primary, -secondary)  
      
      write.csv(PERCtabledown2, file)
    }
  )
  
  
  observeEvent(input$PTC_reset,{
    updateSelectInput(session, 'PTC_team', selected = "MIL")
    updateSelectInput(session, 'PTC_season', selected = "2019-2020")
    updateCheckboxGroupInput(session, 'PTC_conf', selected = c("West" = "West", "East" = "East"))
    updateRadioButtons(session, 'PTC_offdef', selected = "offense")
  })
  
  
 
}