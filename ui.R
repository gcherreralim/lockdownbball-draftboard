ui <- (
  fluidPage(
    tags$head(HTML('<link rel="icon", href="nba-logo-transparent.png",
                   type="image/png"/>
                   <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700;900&display=swap" rel="stylesheet">
                   <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;600;800&display=swap" rel="stylesheet">
                   <link href="https://fonts.googleapis.com/css2?family=Paytone+One&display=swap" rel="stylesheet">
                   <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@200;400;500;700;900&display=swap" rel="stylesheet">')),
    
    ############# CSS CHUNKS ################
    tags$style(HTML('* { margin:0; padding:0;}
                    body{
                      font-family: "Open Sans", sans-serif;
                      font-size: 12px;
                      overflow-x: hidden;
                    }
                    .navbar{
                      background-color: #121212;
                      width: 103vw;
                      margin-left: -0.8vw;
                      font-weight: 500;
                      font-family: "Raleway", sans-serif;
                      border-color: transparent;
                    }
                    .navbar-default .navbar-brand, .navbar-default .navbar-brand:hover{
                      color: #FFF;
                      text-transform: uppercase;
                      letter-spacing: 3px;
                      font-weight: 600;
                      font-size: 12px;
                    }
                    .navbar-default .navbar-nav>li>a {
                      font-size: 10px;
                      color: #FFF;
                      letter-spacing: 1.5px;
                      border-bottom: 1px solid #121212;
                      transition: all 200ms ease-in-out;
                    }
                    .navbar-default .navbar-nav>li>a:hover{
                      background-color: #C9082A;
                      color: #FFF;
                      border-bottom: 1px solid #c9082a;
                    }
                    .navbar-default .navbar-nav>.active>a, .navbar-default .navbar-nav>.active>a:focus, .navbar-default .navbar-nav>.active>a:hover {
                      background-color: #C9082A;
                      color: #FFF;
                      text-transform: uppercase;
                      font-weight: 600;
                      border-bottom: 1px solid #c9082a;
                    }
                    hr{
                      height: 2px;
                      border: none;
                      background-color: #FFF;
                      padding-bottom: -100px;
                      padding-tom: -150px;
                    }
                    .btn{
                      background-color: #cc0000;
                      border: 3px solid #cc0000;
                      color: #FFF;
                      font-weight: 400;
                      text-transform: uppercase;
                      transition: all 200ms ease-in-out;
                    }
                    .btn:hover{
                      background-color: #FFF;
                      border: 3px solid #cc0000;
                      color: #cc0000;
                      font-weight: 600;
                    }
                    .well{
                      background-color: #121212;
                      color: #FFF;
                    }
                    h1, h2, h3, h4, h5{
                      font-family: "Open Sans", sans-serif;
                      font-weight: 600;
                    }
                    .control-label{
                      font-weight: 400;
                    }
                    
                    /* REACTABLE */
                    .reactable > div > div.rt-table > div.rt-thead.-header > div {
                      background-color: #17408B;
                    }
                    .reactable > div > div.rt-table > div.rt-thead.-header > div > div.rt-align-center{
                      padding: 8px;
                      border-bottom-width: 1px;
                      background-color: #17408B;
                      text-transform: uppercase;
                      font-size: 11px;
                      color: #FFF;
                      transition: box-shadow 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275)
                    }
                    .reactable > div > div.rt-table > div.rt-thead.-header > div > div.rt-align-center:hover {
                      background-color: #C9082A;
                      color: #FFF;
                    }
                    .reactable > div > div.rt-table > div.rt-thead.-header > div > div.rt-align-center[aria-sort="ascending"]{
                      background-color: #C9082A;
                      color: #FFF;
                      box-shadow: inset 0 10px 0 -6px #EDB439;
                    }
                    .reactable > div > div.rt-table > div.rt-thead.-header > div > div.rt-align-center[aria-sort="descending"]{
                      background-color: #C9082A;
                      color: #FFF;
                      box-shadow: inset 0 -10px 0 -6px #EDB439;
                    }
                    .nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover {
                      background-color: #C9082A;
                      color: #FFF;
                      border-radius: 0px;
                      border-color: #C9082A;
                      font-weight: 600;
                    }
                    .nav-tabs>.active>a, .nav-tabs>.active>a:hover, .nav-tabs>.active>a:focus {
                      border-color: transparent;
                      font-weight: 600;
                    }
                    .nav-tabs {
                      border-bottom: 8px solid #062256;
                      background-color: #17408B;
                    }
                    .nav-tabs > li > a{
                      transition: all 200ms ease-in-out;
                    }
                    .nav-tabs > li:hover > a{
                      background-color: #C9082A;
                      border-color: transparent;
                    }
                    .nav-tabs > li > a{
                      color: #FFF;
                      border-radius: 0px;
                      transition: all 200ms ease-in-out;
                    }
                    .tooltabtitle {
                      background: #030303;
                      width: 104vw;
                      margin-top: -2vh;
                      margin-left: -1.65vw;
                      padding: 40px;
                      margin-bottom: 2vh;
                      background-size: cover;
                      background-repeat: no-repeat;
                      background-position: right;
                    }
                    .tooltabtitle > h1, .tooltabtitle > h4{
                      color: #FFF;
                      width: 40vw;
                    }
                    .tooltabtitle > h1{
                      text-transform: uppercase;
                      font-weight: 700;
                      letter-spacing: 2px;
                      font-size: 32px;
                    }
                    .tooltabtitle > h4{
                      font-size: 12px;
                      text-align: justify;
                      text-align-last: left;
                    }
                    #TE_tooltitle{
                      background-image: url("TE_head.jpg");
                    }
                    #PTC_tooltitle{
                      background-image: url("PTC_head.jpg");
                    }
                    #WA_tooltitle{
                      background-image: url("WA_head.jpg");
                    }
                    #MTC_tooltitle{
                      background-image: url("MTC_head.jpg");
                    }
                    #PTC_PPPplot{
                      display: block;
                      margin-left: auto;
                      margin-right: auto;
                    }
                    #PTC_FREQplot{
                      display: block;
                      margin-left: auto;
                      margin-right: auto;
                    }
                    #PTC_PERCplot{
                      display: block;
                      margin-left: auto;
                      margin-right: auto;
                    }
                    #WA_title1{
                      margin: 0 auto;
                    }
                    .MTC_plottitle > h5{
                      text-transform: uppercase;
                      font-weight: 800;
                      letter-spacing: 1px;
                      text-align: center;
                    }
                    .shiny-output-error-validation,
                    .htmlwidgets-error{
                      color: #C9082A;
                      font-size: 13px;
                      text-align: center;
                    }
                    #TEChartTitle{
                      font-size: 18px;
                      font-weight: 700;
                      text-align: center;
                    }
                    #WA_title1,
                    #WA_subtitle1,
                    #WA_subtitle2,
                    #WA_subtitle3,
                    #WA_subtitle4{
                      text-align: center;
                    }
                    #WA_title1{
                      font-size: 16px;
                      font-weight: 700;
                      text-transform: uppercase;
                      margin-top: 10px;
                      margin-bottom: 5px;
                    }
                    #WA_subtitle1,
                    #WA_subtitle2,
                    #WA_subtitle3,
                    #WA_subtitle4{
                      font-size: 12px;
                      font-weight: 700;
                      text-transform: uppercase;
                      color: #030303;
                    }
                    #tab-2846-5 > h4,
                    #tab-2846-5 > h6{
                      font-size: 14px
                    }
                    .PTCteamtitle{
                      font-weight: 600;
                      text-transform: uppercase;
                      font-size: 14px;
                      color: #FFF;
                      background-color: #062256;
                      padding: 5px;
                      border-radius: 5px;
                      text-align: center;
                    }
                    #PPPselectedteam > img,
                    #FREQselectedteam > img,
                    #PERCselectedteam > img,
                    #EDselectedteam > img,
                    #FDselectedteam > img,
                    #PDselectedteam > img{
                      margin-left: auto;
                      margin-right: auto;
                      display: block;
                    }
                    #WAtabsub > h4,
                    #WAtabsub > h6{
                      font-size: 12px;
                      text-align: center;
                      font-weight: 700;
                      color: #030303;
                    }
                    .matchcenter{
                      text-align: center;
                    }
                    .matchcenter > div{
                      margin-left: auto;
                      margin-right: auto;
                      display: block;
                    }
                    #main-text{
                      font-size: 20px;
                      width: 90vw;
                      padding-top: 20px;
                      padding-bottom: 60px;
                      margin: 0 auto;
                      text-align: center;
                      color: #FFF;
                      font-weight: 400;
                    }
                    #homepage{
                      margin-left:-2.5vw;
                      margin-top:-20px;
                      width:100vw;
                      height: 100%;
                      background-color: #030303;
                    }
                    #aboutpage{
                      margin-left: -2.5vw;
                      margin-top: -20px;
                      width: 100vw;
                      height: 100%;
                      background-color: #030303;
                    }
                    #main-image{
                      width: 102vw;
                    }
                    #main-head{
                      margin: 0 auto;
                      padding-top: 60px;
                      text-align: center;
                      font-size: 50px;
                      font-family: "Raleway";
                      font-weight: 800;
                      color: #FFF;
                      letter-spacing: 2px;
                    }
                    #homepage > h5{
                      color: #FFF;
                      margin: 0 auto;
                      text-align: center;
                      padding-bottom: 200px;
                    }
                    #homepage > h5 > a,
                    #brett-links>a,
                    #gabby-links>a,
                    #joe-link{
                      color: #FFF;
                      text-decoration: none;
                      transition: all 350ms ease-in-out;
                    }
                    #homepage > h5 > a:hover,
                    #brett-links>a:hover,
                    #gabby-links>a:hover,
                    #joe-link:hover{
                      color: #C9082A;
                    }
                    #brett-links,
                    #gabby-links{
                      margin: 0 auto;
                      text-align: center;
                      padding-top: 10px;
                      padding-bottom: 50px;
                    }
                    #brett-head,
                    #gabby-head{
                      margin: 0 auto;
                      padding-top: 20px;
                      text-align: center;
                      font-size: 24px;
                      font-family: "Raleway";
                      font-weight: 800;
                      color: #FFF;
                      letter-spacing: 2px;
                      text-transform: uppercase;
                    }
                    #brett-text,
                    #gabby-text{
                      font-size: 16px;
                      width: 80vw;
                      padding-top: 20px;
                      padding-bottom: 10px;
                      margin: 0 auto;
                      text-align: center;
                      color: #FFF;
                      font-weight: 400;
                    }
                    #brett-pic,
                    #gabby-pic{
                      height: 350px;
                      margin-left: auto;
                      margin-right: auto;
                      display: block;
                      padding-top: 60px;
                    }
                    #tab-5883-3 > div.row > div.col-sm-2 > form > div:nth-child(2){
                      display:inline-block;
                    }
                    #PT_Name, #PT_Twit {
                      font-size: 10px;
                    }
                    [type = "number"] {
                      font-size: 10px;
                    }
                    [type = "button"] {
                      font-size: 12px;
                    }
                    #PT_sidebar {
                      overflow: auto;
                      height: 72vh;
                      scrollbar-color: #cc0000;
                    }
                    ')),
    
    
    ############# THEME ##############
    theme = NULL,
    navbarPage(
      selected = "Home",
      title = "BIG BOARD CREATOR",
      windowTitle = "2021 NBA Draft Big Board Tool | Lockdown Basketball",
      
      ########## UI CODE FOR 'HOME' TAB ##########
      tabPanel("Home",
               mainPanel(
                 div(id="homepage",
                 #includeHTML("html_pages/home.html")
                 img(src="home-head.jpg", id="main-image"),
                 h1("LOCKDOWN BASKETBALL: 2021 DRAFT TOOL", id="main-head"),
                 h3("TEXT TEXT TEXT", id="main-text"),
                 hr(),
                 h5("CJ Marchesani (",tags$a(href="https://www.twitter.com/cjmarchesani", target="_blank", "@cjmarchesani"),")   |   Brett Kornfeld (",tags$a(href="https://www.twitter.com/KornHoops", target="_blank", "@KornHoops"),")   |   Gabby Herrera-Lim (", tags$a(href="https://www.gcherreralim.com", target="_blank", "gcherreralim.com"),")")
                 )
               )),
      
      ########## UI CODE FOR 'FEATURED BOARDS' TAB ##########
      tabPanel("Featured 2021 Boards",
               div(
                h1('FEATURED 2021 BOARDS'),
                h4('Take a look at ------------------'),
                class = "tooltabtitle", id = 'TE_tooltitle'),
               sidebarPanel(width = 2,
                            selectizeInput(
                              inputId = "TEteams",
                              label = "Select up to 10 teams:",
                              choices = list(
                                "2015 - 2016" = sort(unique(genteams$TeamCode[genteams$Season == 2016])),
                                "2016 - 2017" = sort(unique(genteams$TeamCode[genteams$Season == 2017])),
                                "2017 - 2018" = sort(unique(genteams$TeamCode[genteams$Season == 2018])),
                                "2018 - 2019" = sort(unique(genteams$TeamCode[genteams$Season == 2019])),
                                "2019 - 2020" = sort(unique(genteams$TeamCode[genteams$Season == 2020]))),
                              multiple = TRUE,
                              selected = NULL,
                              options = list(maxItems = 10)),
                            shiny::br(),
                            varSelectInput("TExaxis", "X-Axis Variable", genteams[,7:36], selected="oEFF"),
                            varSelectInput("TEyaxis", "Y-Axis Variable", genteams[,7:36], selected="WinPerc"),
                            checkboxInput("TEall", "Show all teams", FALSE),
                            actionButton("TE_reset", "Reset")),
               mainPanel(width = 10,
                 shiny::textOutput("TEChartTitle"),
                 shiny::plotOutput("TEChart"),
                 reactable::reactableOutput("TEtable"),
                 br(),
                 br(),
                 div(style="display: inline-block; vertical-align: top; width: 200px; margin: 0 auto;",uiOutput("TE_plotdownappear"))
               ))
      ,
      
      
      ########## UI CODE FOR 'PERCENTILE TOOL' TAB ##########
      tabPanel("PERCENTILE TOOL",
               div(
                 h1('Board Percentile Visualization Tool'),
                 h4('This tool is used to visualize your percentile outcomes of any 5 to 15 players.'),
                 class = "tooltabtitle", id = 'PT_tooltitle'),
               sidebarLayout(
                 sidebarPanel(id = "PT_sidebar",
                              width = 4,
                              div(style = "display: inline-block; vertical-align: top; width: 160px; padding-right: 20px; font-size: 10px;", textInput(inputId = "PT_Name", label = "Name:", value = "")),
                              div(style = "display: inline-block; vertical-align: top; width: 160px; padding-right: 20px; font-size: 10px;", textInput(inputId = "PT_Twit", label = "Twitter User:", value = "")),
                              div(style = "display: inline-block; vertical-align: bottom;", actionButton("PT_submit", "Submit")),
                              div(style = "display: inline-block; vertical-align: bottom;", actionButton("PT_reset", "Reset")),
                              hr(),
                              div(selectInput(inputId = "PT_Player1",
                                             label = "Select your first player",
                                             choices = list(
                                               "Freshmen" = sort(unique(playerbios$player[playerbios$year == "FR"])),
                                               "Sophomores" = sort(unique(playerbios$player[playerbios$year == "SO"])),
                                               "Juniors" = sort(unique(playerbios$player[playerbios$year == "JR"])),
                                               "Seniors" = sort(unique(playerbios$player[playerbios$year == "SR"])),
                                               "International" = sort(unique(playerbios$player[playerbios$year == "INT"])),
                                               "G-League" = sort(unique(playerbios$player[playerbios$year == "G"]))),
                                             multiple = FALSE,
                                             selected = "Cade Cunningham"),
                                  style = "display: inline-block; width: 300px; font-size: 10px; vertical-align: top; padding-right: 20px; text-transform: uppercase;"),
                              div(numericInput(inputId = "PT_P1_100",
                                           label = "CEILING",
                                           value = 0,
                                           min = 0,
                                           max = 100,
                                           step = 1),style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P1_75TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P1_25TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P1_FLOOR"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              hr(),
                              ### PLAYER 2 ###
                              div(selectInput(inputId = "PT_Player2",
                                          label = "Select your second player",
                                          choices = list(
                                            "Freshmen" = sort(unique(playerbios$player[playerbios$year == "FR"])),
                                            "Sophomores" = sort(unique(playerbios$player[playerbios$year == "SO"])),
                                            "Juniors" = sort(unique(playerbios$player[playerbios$year == "JR"])),
                                            "Seniors" = sort(unique(playerbios$player[playerbios$year == "SR"])),
                                            "International" = sort(unique(playerbios$player[playerbios$year == "INT"])),
                                            "G-League" = sort(unique(playerbios$player[playerbios$year == "G"]))),
                                          multiple = FALSE,
                                          selected = "Evan Mobley"),
                                  style = "display: inline-block; width: 300px; font-size: 10px; vertical-align: top; padding-right: 20px; text-transform: uppercase;"),
                              div(numericInput(inputId = "PT_P2_100",
                                               label = "CEILING",
                                               value = 0,
                                               min = 0,
                                               max = 100,
                                               step = 1),style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P2_75TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P2_25TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P2_FLOOR"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              hr(),
                              ### PLAYER 3 ###
                              div(selectInput(inputId = "PT_Player3",
                                          label = "Select your third player",
                                          choices = list(
                                            "Freshmen" = sort(unique(playerbios$player[playerbios$year == "FR"])),
                                            "Sophomores" = sort(unique(playerbios$player[playerbios$year == "SO"])),
                                            "Juniors" = sort(unique(playerbios$player[playerbios$year == "JR"])),
                                            "Seniors" = sort(unique(playerbios$player[playerbios$year == "SR"])),
                                            "International" = sort(unique(playerbios$player[playerbios$year == "INT"])),
                                            "G-League" = sort(unique(playerbios$player[playerbios$year == "G"]))),
                                          multiple = FALSE,
                                          selected = "Jalen Green"),
                                  style = "display: inline-block; width: 300px; font-size: 10px; vertical-align: top; padding-right: 20px; text-transform: uppercase;"),
                              div(numericInput(inputId = "PT_P3_100",
                                               label = "CEILING",
                                               value = 0,
                                               min = 0,
                                               max = 100,
                                               step = 1),style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P3_75TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P3_25TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P3_FLOOR"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              hr(),
                              ### PLAYER 4 ###
                              div(selectInput(inputId = "PT_Player4",
                                          label = "Select your fourth player",
                                          choices = list(
                                            "Freshmen" = sort(unique(playerbios$player[playerbios$year == "FR"])),
                                            "Sophomores" = sort(unique(playerbios$player[playerbios$year == "SO"])),
                                            "Juniors" = sort(unique(playerbios$player[playerbios$year == "JR"])),
                                            "Seniors" = sort(unique(playerbios$player[playerbios$year == "SR"])),
                                            "International" = sort(unique(playerbios$player[playerbios$year == "INT"])),
                                            "G-League" = sort(unique(playerbios$player[playerbios$year == "G"]))),
                                          multiple = FALSE,
                                          selected = "Jalen Suggs"),
                                  style = "display: inline-block; width: 300px; font-size: 10px; vertical-align: top; padding-right: 20px; text-transform: uppercase;"),
                              div(numericInput(inputId = "PT_P4_100",
                                               label = "CEILING",
                                               value = 0,
                                               min = 0,
                                               max = 100,
                                               step = 1),style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P4_75TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P4_25TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P4_FLOOR"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              hr(),
                              ### PLAYER 5 ###
                              div(selectInput(inputId = "PT_Player5",
                                          label = "Select your fifth player",
                                          choices = list(
                                            "Freshmen" = sort(unique(playerbios$player[playerbios$year == "FR"])),
                                            "Sophomores" = sort(unique(playerbios$player[playerbios$year == "SO"])),
                                            "Juniors" = sort(unique(playerbios$player[playerbios$year == "JR"])),
                                            "Seniors" = sort(unique(playerbios$player[playerbios$year == "SR"])),
                                            "International" = sort(unique(playerbios$player[playerbios$year == "INT"])),
                                            "G-League" = sort(unique(playerbios$player[playerbios$year == "G"]))),
                                          multiple = FALSE,
                                          selected = "Jonathan Kuminga"),
                                  style = "display: inline-block; width: 300px; font-size: 10px; vertical-align: top; padding-right: 20px; text-transform: uppercase;"),
                              div(numericInput(inputId = "PT_P5_100",
                                               label = "CEILING",
                                               value = 0,
                                               min = 0,
                                               max = 100,
                                               step = 1),style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P5_75TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P5_25TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P5_FLOOR"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              hr(),
                              ### PLAYER 6 ###
                              div(selectInput(inputId = "PT_Player6",
                                              label = "Select your sixth player",
                                              choices = list(
                                                "Freshmen" = sort(unique(playerbios$player[playerbios$year == "FR"])),
                                                "Sophomores" = sort(unique(playerbios$player[playerbios$year == "SO"])),
                                                "Juniors" = sort(unique(playerbios$player[playerbios$year == "JR"])),
                                                "Seniors" = sort(unique(playerbios$player[playerbios$year == "SR"])),
                                                "International" = sort(unique(playerbios$player[playerbios$year == "INT"])),
                                                "G-League" = sort(unique(playerbios$player[playerbios$year == "G"]))),
                                              multiple = FALSE,
                                              selected = "Scottie Barnes"),
                                  style = "display: inline-block; width: 300px; font-size: 10px; vertical-align: top; padding-right: 20px; text-transform: uppercase;"),
                              div(numericInput(inputId = "PT_P6_100",
                                               label = "CEILING",
                                               value = 0,
                                               min = 0,
                                               max = 100,
                                               step = 1),style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P6_75TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P6_25TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P6_FLOOR"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              hr(),
                              ### PLAYER 7 ###
                              div(selectInput(inputId = "PT_Player7",
                                              label = "Select your seventh player",
                                              choices = list(
                                                "Freshmen" = sort(unique(playerbios$player[playerbios$year == "FR"])),
                                                "Sophomores" = sort(unique(playerbios$player[playerbios$year == "SO"])),
                                                "Juniors" = sort(unique(playerbios$player[playerbios$year == "JR"])),
                                                "Seniors" = sort(unique(playerbios$player[playerbios$year == "SR"])),
                                                "International" = sort(unique(playerbios$player[playerbios$year == "INT"])),
                                                "G-League" = sort(unique(playerbios$player[playerbios$year == "G"]))),
                                              multiple = FALSE,
                                              selected = "Moses Moody"),
                                  style = "display: inline-block; width: 300px; font-size: 10px; vertical-align: top; padding-right: 20px; text-transform: uppercase;"),
                              div(numericInput(inputId = "PT_P7_100",
                                               label = "CEILING",
                                               value = 0,
                                               min = 0,
                                               max = 100,
                                               step = 1),style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P7_75TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P7_25TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P7_FLOOR"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              hr(),
                              ### PLAYER 8 ###
                              div(selectInput(inputId = "PT_Player8",
                                              label = "Select your eighth player",
                                              choices = list(
                                                "Freshmen" = sort(unique(playerbios$player[playerbios$year == "FR"])),
                                                "Sophomores" = sort(unique(playerbios$player[playerbios$year == "SO"])),
                                                "Juniors" = sort(unique(playerbios$player[playerbios$year == "JR"])),
                                                "Seniors" = sort(unique(playerbios$player[playerbios$year == "SR"])),
                                                "International" = sort(unique(playerbios$player[playerbios$year == "INT"])),
                                                "G-League" = sort(unique(playerbios$player[playerbios$year == "G"]))),
                                              multiple = FALSE,
                                              selected = "Kai Jones"),
                                  style = "display: inline-block; width: 300px; font-size: 10px; vertical-align: top; padding-right: 20px; text-transform: uppercase;"),
                              div(numericInput(inputId = "PT_P8_100",
                                               label = "CEILING",
                                               value = 0,
                                               min = 0,
                                               max = 100,
                                               step = 1),style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P8_75TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P8_25TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P8_FLOOR"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              hr(),
                              ### PLAYER 9 ###
                              div(selectInput(inputId = "PT_Player9",
                                              label = "Select your ninth player",
                                              choices = list(
                                                "Freshmen" = sort(unique(playerbios$player[playerbios$year == "FR"])),
                                                "Sophomores" = sort(unique(playerbios$player[playerbios$year == "SO"])),
                                                "Juniors" = sort(unique(playerbios$player[playerbios$year == "JR"])),
                                                "Seniors" = sort(unique(playerbios$player[playerbios$year == "SR"])),
                                                "International" = sort(unique(playerbios$player[playerbios$year == "INT"])),
                                                "G-League" = sort(unique(playerbios$player[playerbios$year == "G"]))),
                                              multiple = FALSE,
                                              selected = "Kai Jones"),
                                  style = "display: inline-block; width: 300px; font-size: 10px; vertical-align: top; padding-right: 20px; text-transform: uppercase;"),
                              div(numericInput(inputId = "PT_P9_100",
                                               label = "CEILING",
                                               value = 0,
                                               min = 0,
                                               max = 100,
                                               step = 1),style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P9_75TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P9_25TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P9_FLOOR"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              hr(),
                              ### PLAYER 10 ###
                              div(selectInput(inputId = "PT_Player10",
                                              label = "Select your tenth player",
                                              choices = list(
                                                "Freshmen" = sort(unique(playerbios$player[playerbios$year == "FR"])),
                                                "Sophomores" = sort(unique(playerbios$player[playerbios$year == "SO"])),
                                                "Juniors" = sort(unique(playerbios$player[playerbios$year == "JR"])),
                                                "Seniors" = sort(unique(playerbios$player[playerbios$year == "SR"])),
                                                "International" = sort(unique(playerbios$player[playerbios$year == "INT"])),
                                                "G-League" = sort(unique(playerbios$player[playerbios$year == "G"]))),
                                              multiple = FALSE,
                                              selected = "Kai Jones"),
                                  style = "display: inline-block; width: 300px; font-size: 10px; vertical-align: top; padding-right: 20px; text-transform: uppercase;"),
                              div(numericInput(inputId = "PT_P10_100",
                                               label = "CEILING",
                                               value = 0,
                                               min = 0,
                                               max = 100,
                                               step = 1),style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P10_75TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P10_25TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P10_FLOOR"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              hr(),
                              ### PLAYER 11 ###
                              div(selectInput(inputId = "PT_Player11",
                                              label = "Select your eleventh player",
                                              choices = list(
                                                "Freshmen" = sort(unique(playerbios$player[playerbios$year == "FR"])),
                                                "Sophomores" = sort(unique(playerbios$player[playerbios$year == "SO"])),
                                                "Juniors" = sort(unique(playerbios$player[playerbios$year == "JR"])),
                                                "Seniors" = sort(unique(playerbios$player[playerbios$year == "SR"])),
                                                "International" = sort(unique(playerbios$player[playerbios$year == "INT"])),
                                                "G-League" = sort(unique(playerbios$player[playerbios$year == "G"]))),
                                              multiple = FALSE,
                                              selected = "Kai Jones"),
                                  style = "display: inline-block; width: 300px; font-size: 10px; vertical-align: top; padding-right: 20px; text-transform: uppercase;"),
                              div(numericInput(inputId = "PT_P11_100",
                                               label = "CEILING",
                                               value = 0,
                                               min = 0,
                                               max = 100,
                                               step = 1),style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P11_75TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P11_25TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P11_FLOOR"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              hr(),
                              ### PLAYER 12 ###
                              div(selectInput(inputId = "PT_Player8",
                                              label = "Select your eighth player",
                                              choices = list(
                                                "Freshmen" = sort(unique(playerbios$player[playerbios$year == "FR"])),
                                                "Sophomores" = sort(unique(playerbios$player[playerbios$year == "SO"])),
                                                "Juniors" = sort(unique(playerbios$player[playerbios$year == "JR"])),
                                                "Seniors" = sort(unique(playerbios$player[playerbios$year == "SR"])),
                                                "International" = sort(unique(playerbios$player[playerbios$year == "INT"])),
                                                "G-League" = sort(unique(playerbios$player[playerbios$year == "G"]))),
                                              multiple = FALSE,
                                              selected = "Kai Jones"),
                                  style = "display: inline-block; width: 300px; font-size: 10px; vertical-align: top; padding-right: 20px; text-transform: uppercase;"),
                              div(numericInput(inputId = "PT_P8_100",
                                               label = "CEILING",
                                               value = 0,
                                               min = 0,
                                               max = 100,
                                               step = 1),style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P8_75TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P8_25TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P8_FLOOR"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              hr(),
                              ### PLAYER 13 ###
                              div(selectInput(inputId = "PT_Player8",
                                              label = "Select your eighth player",
                                              choices = list(
                                                "Freshmen" = sort(unique(playerbios$player[playerbios$year == "FR"])),
                                                "Sophomores" = sort(unique(playerbios$player[playerbios$year == "SO"])),
                                                "Juniors" = sort(unique(playerbios$player[playerbios$year == "JR"])),
                                                "Seniors" = sort(unique(playerbios$player[playerbios$year == "SR"])),
                                                "International" = sort(unique(playerbios$player[playerbios$year == "INT"])),
                                                "G-League" = sort(unique(playerbios$player[playerbios$year == "G"]))),
                                              multiple = FALSE,
                                              selected = "Kai Jones"),
                                  style = "display: inline-block; width: 300px; font-size: 10px; vertical-align: top; padding-right: 20px; text-transform: uppercase;"),
                              div(numericInput(inputId = "PT_P8_100",
                                               label = "CEILING",
                                               value = 0,
                                               min = 0,
                                               max = 100,
                                               step = 1),style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P8_75TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P8_25TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P8_FLOOR"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              hr(),
                              ### PLAYER 14 ###
                              div(selectInput(inputId = "PT_Player8",
                                              label = "Select your eighth player",
                                              choices = list(
                                                "Freshmen" = sort(unique(playerbios$player[playerbios$year == "FR"])),
                                                "Sophomores" = sort(unique(playerbios$player[playerbios$year == "SO"])),
                                                "Juniors" = sort(unique(playerbios$player[playerbios$year == "JR"])),
                                                "Seniors" = sort(unique(playerbios$player[playerbios$year == "SR"])),
                                                "International" = sort(unique(playerbios$player[playerbios$year == "INT"])),
                                                "G-League" = sort(unique(playerbios$player[playerbios$year == "G"]))),
                                              multiple = FALSE,
                                              selected = "Kai Jones"),
                                  style = "display: inline-block; width: 300px; font-size: 10px; vertical-align: top; padding-right: 20px; text-transform: uppercase;"),
                              div(numericInput(inputId = "PT_P8_100",
                                               label = "CEILING",
                                               value = 0,
                                               min = 0,
                                               max = 100,
                                               step = 1),style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P8_75TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P8_25TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P8_FLOOR"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              hr(),
                              ### PLAYER 15 ###
                              div(selectInput(inputId = "PT_Player8",
                                              label = "Select your eighth player",
                                              choices = list(
                                                "Freshmen" = sort(unique(playerbios$player[playerbios$year == "FR"])),
                                                "Sophomores" = sort(unique(playerbios$player[playerbios$year == "SO"])),
                                                "Juniors" = sort(unique(playerbios$player[playerbios$year == "JR"])),
                                                "Seniors" = sort(unique(playerbios$player[playerbios$year == "SR"])),
                                                "International" = sort(unique(playerbios$player[playerbios$year == "INT"])),
                                                "G-League" = sort(unique(playerbios$player[playerbios$year == "G"]))),
                                              multiple = FALSE,
                                              selected = "Kai Jones"),
                                  style = "display: inline-block; width: 300px; font-size: 10px; vertical-align: top; padding-right: 20px; text-transform: uppercase;"),
                              div(numericInput(inputId = "PT_P8_100",
                                               label = "CEILING",
                                               value = 0,
                                               min = 0,
                                               max = 100,
                                               step = 1),style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P8_75TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P8_25TH"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              div(uiOutput("PT_P8_FLOOR"),
                                  style = "display: inline-block; width: 55px; font-size: 10px;"),
                              ),
                 mainPanel(width = 8,
                           tabsetPanel(
                             tabPanel("Percentile Outcome Boxplot",
                                      plotly::plotlyOutput("PTC_PPPplot",
                                                   height = "500px",
                                                   width = "700px"),
                                      shiny::hr(),
                                      reactable::reactableOutput("PT_Board")),
                             tabPanel("Playtype Frequency",
                                      fluidRow(
                                        column(2,
                                               h5("Selected Team:", class = "PTCteamtitle"),
                                               uiOutput("FREQselectedteam")),
                                        column(10,
                                               h5("Matched Teams:", class = "PTCteamtitle"),
                                               div(class="matchcenter",
                                               fluidRow(
                                                 column(2,
                                                        uiOutput("FREQteam1")),
                                                 column(2,
                                                        uiOutput("FREQteam2")),
                                                 column(2,
                                                        uiOutput("FREQteam3")),
                                                 column(2,
                                                        uiOutput("FREQteam4")),
                                                 column(2,
                                                        uiOutput("FREQteam5"))
                                               )))),
                                      hr(),
                                      plotly::plotlyOutput("PTC_FREQplot",
                                                   height = "500px",
                                                   width = "700px"),
                                      shiny::hr(),
                                      reactable::reactableOutput("PTC_FREQtable")),
                             tabPanel("Player Bios",
                                      fluidRow(
                                        column(2,
                                               h5("Selected Team:", class = "PTCteamtitle"),
                                               uiOutput("PERCselectedteam")),
                                        column(10,
                                               h5("Matched Teams:", class = "PTCteamtitle"),
                                               div(class="matchcenter",
                                               fluidRow(
                                                 column(2,
                                                        uiOutput("PERCteam1")),
                                                 column(2,
                                                        uiOutput("PERCteam2")),
                                                 column(2,
                                                        uiOutput("PERCteam3")),
                                                 column(2,
                                                        uiOutput("PERCteam4")),
                                                 column(2,
                                                        uiOutput("PERCteam5"))
                                               )))),
                                      hr(),
                                      plotly::plotlyOutput("PTC_PERCplot",
                                                           height = "500px",
                                                           width = "700px"),
                                      shiny::hr(),
                                      reactable::reactableOutput("PTC_PERCtable")),
                             tabPanel("Efficiency Data",
                                      fluidRow(
                                        column(2,
                                               h5("Selected Team:", class = "PTCteamtitle"),
                                               uiOutput("EDselectedteam")),
                                        column(10,
                                               h5("Matched Teams:", class = "PTCteamtitle"),
                                               div(class="matchcenter",
                                               fluidRow(
                                                 column(2,
                                                        uiOutput("EDteam1")),
                                                 column(2,
                                                        uiOutput("EDteam2")),
                                                 column(2,
                                                        uiOutput("EDteam3")),
                                                 column(2,
                                                        uiOutput("EDteam4")),
                                                 column(2,
                                                        uiOutput("EDteam5"))
                                               )))),
                                      hr(),
                                      h6("These are the playtype (all 10) numbers for the teams matched in the 'Playtype Efficiency' tab."),
                                      reactable::reactableOutput("PTC_PPPtable2"),
                                      hr(),
                                      downloadButton('PTC_PPPtabledownload2',"Download data")),
                             tabPanel("Frequency Data",
                                      fluidRow(
                                        column(2,
                                               h5("Selected Team:", class = "PTCteamtitle"),
                                               uiOutput("FDselectedteam")),
                                        column(10,
                                               h5("Matched Teams:", class = "PTCteamtitle"),
                                               div(class="matchcenter",
                                               fluidRow(
                                                 column(2,
                                                        uiOutput("FDteam1")),
                                                 column(2,
                                                        uiOutput("FDteam2")),
                                                 column(2,
                                                        uiOutput("FDteam3")),
                                                 column(2,
                                                        uiOutput("FDteam4")),
                                                 column(2,
                                                        uiOutput("FDteam5"))
                                               )))),
                                      hr(),
                                      h6("These are the playtype (all 10) numbers for the teams matched in the 'Playtype Frequency' tab."),
                                      reactable::reactableOutput("PTC_FREQtable2"),
                                      hr(),
                                      downloadButton('PTC_FREQtabledownload2',"Download data")),
                             tabPanel("Percentile Data",
                                      fluidRow(
                                        column(2,
                                               h5("Selected Team:", class = "PTCteamtitle"),
                                               uiOutput("PDselectedteam")),
                                        column(10,
                                               h5("Matched Teams:", class = "PTCteamtitle"),
                                               div(class="matchcenter",
                                               fluidRow(
                                                 column(2,
                                                        uiOutput("PDteam1")),
                                                 column(2,
                                                        uiOutput("PDteam2")),
                                                 column(2,
                                                        uiOutput("PDteam3")),
                                                 column(2,
                                                        uiOutput("PDteam4")),
                                                 column(2,
                                                        uiOutput("PDteam5"))
                                               )))),
                                      hr(),
                                      h6("These are the playtype (all 10) numbers for the teams matched in the 'Playtype Percentile' tab."),
                                      reactable::reactableOutput("PTC_PERCtable2"),
                                      hr(),
                                      downloadButton('PTC_PERCtabledownload2',"Download data")))))),

      

      ########## UI CODE FOR 'ABOUT US' TAB ##########
      tabPanel("About Us",
               mainPanel(
                 div(id="aboutpage",
                     #includeHTML("html_pages/home.html")
                     div(id="aboutcontent",
                     img(src="brett-pic.jpg", id="brett-pic"),
                     h1("Brett Kornfeld (concept/structure)", id="brett-head"),
                     h3("A basketball (and sports in general) junkie in every fashion, Brett received his Master's of Business Analytics  from the Mendoza College of Business at the University of
                        Notre Dame in 2020. A graduate of Indiana University's Kelley School of Business in 2018, Brett is a two-time participant in Larry Coon's Sports Business Classroom at the 
                        NBA Summer League, specializing in both video/scouting and salary cap. He is actively seeking work in professional or collegiate men's or women's basketball on the analytics 
                        or operations side.", id="brett-text"),
                     h5(id="brett-links",
                        tags$a(href="https://www.twitter.com/KornHoops", target="_blank", "@KornHoops"),
                        br(),
                        br(),
                        tags$a(href="mailto:brettkornfeld@gmail.com", target="_blank", "E-mail Brett!")),
                     hr(),
                     img(src="gabby-pic.JPG", id="gabby-pic"),
                     h1("Gabby Herrera-Lim (design/app)", id="gabby-head"),
                     h3("Gabby graduated with degrees in Business Analytics (MS, University of Notre Dame) and Business Administration (BS, University of the Philippines, Diliman). He is currently an
                        economic analyst at the Asian Development Bank in the Philippines. In his spare time, he loves talking sports (especially basketball), designing content and apps, binging shows, 
                        and being a LeBron James apologist.", id="gabby-text"),
                     h5(id="gabby-links",
                        tags$a(href="https://gcherreralim.com", target="_blank", "Portfolio"),
                        br(),
                        br(),
                        tags$a(href="mailto:gcherreralim@alumni.nd.edu", target="_blank", "E-mail Gabby!")
                     )))
               ))
    )
  )
)

