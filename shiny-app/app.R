#Libraries
source("global/libraries.R")

#### call modules #####
list.files("modules") %>% purrr::map(~ source(paste0("modules/", .)))
#### call modules #####


#### Connect to Production database #####
source("global/DBconnect.R")
#### End Connect to database #####


#### Initialize global dataframe ####
source("global/dataframe.R")
#### End Initialize global dataframe ####

#### Initialize global functions#### 
source("functions/functions.R")
#### End Initialize global functions ####

shinyOptions(cache = cachem::cache_disk("./app-cache"))

#### Create User Interface #####
ui <-
  tagList(  
    shinyjs::useShinyjs(),
    tags$head(# the javascript is checking the screen resolution to adapt the display
      tags$script(src = "javascripts.js")),
    tags$style(HTML(
      paste(
        "html,",
        ".container{
                    width: 100%;
                    margin: 0 auto;
                    padding: 0;
                }
               @media screen and (min-width: 700px){
                .container{
                    min-width: 1850px;
                    max-width: 1920px;
                }
               }
                          ",
        sep = " "
      )
    )),
    tags$div(id = "all",
      class = "container",
      dashboardPage(
        preloader = list(html = tagList(
          spin_3(),
          HTML('<font color="#000000">Country Profile</font>')
        ), color = "#fff"),
       header = dashboardHeader(disable = TRUE),
       dashboardSidebar(width = "0px"),
       body = dashboardBody(
          tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
          ),
          #UI for Country
          reporter_download_ui(id = "reporterdownload"),
          #End of UI for Country
          
          #UI for Demographics
          demographics_ui(id = "demographics"),
          #End of UI for Demographics

          #UI for Macroeconomic
          Macroeconomic_ui(id = "Macroeconomic"),
          #End of UI Macroeconomic

          #UI for Trade in goods
          tradeingoods_ui(id = "tradeingoods"),
          #End of UI for Trade in goods

          #UI for Trade Performance
          trade_performance_ui(id = "tradeperformance"),
          #End of UI Trade Performance

          #UI for Logistic Performance
          LPI_ui(id = "LPI"),
          #End of UI Logistic Performance

          # #UI for Bilateral Trade
          bilateral_ui(id = "bilateral"),
          #End of UI Bilateral Trade

          #UI for Trade Agreements
          trade_agreement_ui(id = "agreement"),
          #End of UI Trade Agreements

          #UI for Trade in services
          tradeinservices_ui(id = "tradeinservices"),
          #End of UI Trade in services

          #UI for Services Performance
          servicesperformance_ui(id = 'servicesperformance'),
          #End of UI Services Performance
                  #
          #UI for Digital
          Digital_ui(id = "Digital"),
          #End of UI Digital

          #UI for Digital
          trade_facilitation_ui(id = "tradefacilitation")
          #End of UI Digital
          
        )
      )
    )
  )
#### End Create User Interface #####


#### Create Server actions #####
server <- shinyServer(function(input, output, session) {
  

  #Initialize color palette
  mycolor <- color_palette(id = "color")
  
  #Initialize reporter
  reporter_iso_sel <-
    reporter_download_server(id = "reporterdownload")
  
  #Initialize trade flow parameter
  tradeflow <- tradeflow_server(id = "tradeingoods")

  #Initialize Services trade flow parameter
  services_tradeflow <- Services_tradeflow_server(id = "tradeinservices")

  #### Demographics ####
  demographics_server(id = "demographics",
                      reporter_iso_sel = reporter_iso_sel$reporter_iso_sel)
  #### Demographics ####
  
  
  ### Macroeconomic ####
Macroeconomic_server(
    id = "Macroeconomic",
    reporter_iso_sel = reporter_iso_sel$reporter_iso_sel,
    reporter = reporter_iso_sel$reporter,
    mycolor = mycolor
  )
  ### Macroeconomic ####
  

  #### Trade in goods ####
  tradeingoods_server(
    id = "tradeingoods",
    reporter_iso_sel = reporter_iso_sel$reporter_iso_sel,
    reporter = reporter_iso_sel$reporter,
    mycolor = mycolor,
    tradeflow = tradeflow
  )
  #### Trade in goods ####

  #### Trade performance ####
  trade_performance_server(
    id = "tradeperformance",
    reporter_iso_sel = reporter_iso_sel$reporter_iso_sel,
    reporter = reporter_iso_sel$reporter,
    mycolor = mycolor
  )
  #### Trade performance ####

  #### Logistic performance ####
  LPI_server(
    id = "LPI",
    reporter_iso_sel = reporter_iso_sel$reporter_iso_sel,
    reporter = reporter_iso_sel$reporter,
    mycolor = mycolor
  )
  #### Logistic performance ####

  #### Bilateral Trade ####
  bilateral_server(
    id = "bilateral",
    reporter_iso_sel = reporter_iso_sel$reporter_iso_sel,
    reporter = reporter_iso_sel$reporter,
    mycolor = mycolor
  )
  #### Bilateral Trade ####

  #### Trade Agreements ####
  trade_agreement_server(
    id = "agreement",
    reporter_iso_sel = reporter_iso_sel$reporter_iso_sel
  )
  #### Trade Agreements ####

  #### Trade in services ####
  tradeinservices_server(
     id = "tradeinservices",
     reporter_iso_sel = reporter_iso_sel$reporter_iso_sel,
     reporter = reporter_iso_sel$reporter,
     mycolor = mycolor,
     services_tradeflow = services_tradeflow
   )
  #### Trade in services ####

  #### Services performance ####
  services_performance_server(
    id = "servicesperformance",
    reporter_iso_sel = reporter_iso_sel$reporter_iso_sel,
    reporter = reporter_iso_sel$reporter,
    mycolor = mycolor
  )
  #### Services performance ####


  #### Digital ####
  Digital_server(
    id = "Digital",
    reporter_iso_sel = reporter_iso_sel$reporter_iso_sel,
    reporter = reporter_iso_sel$reporter,
    mycolor = mycolor
  )
  #### Digital ####

  # ### Digital - Trade Facilitation ####
  trade_facilitation_server(
    id = "tradefacilitation",
    reporter_iso_sel = reporter_iso_sel$reporter_iso_sel,
    reporter = reporter_iso_sel$reporter,
    mycolor = mycolor
  )

  # ### Digital - Trade Facilitation ####
  # 
  # #### Download ####
  # download_server(id = "reporterdownload")
  #### Download ####
  
})
#### End create Server actions #####

#### Run application #####
shinyApp(ui, server)
#### End Run application #####