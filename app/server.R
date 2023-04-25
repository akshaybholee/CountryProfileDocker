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
  plot_1 <- tradeingoods_server(
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
  plot_2 <- LPI_server(
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
  tradefacilitation <-    trade_facilitation_server(
    id = "tradefacilitation",
    reporter_iso_sel = reporter_iso_sel$reporter_iso_sel,
    reporter = reporter_iso_sel$reporter,
    mycolor = mycolor
  )
  
  # ### Digital - Trade Facilitation ####
  # 
  # #### Download ####
  download_server(id = "reporterdownload", reporter_iso_sel = reporter_iso_sel$reporter_iso_sel,
                  tradefacilitation = tradefacilitation )
  
  #### Download ####
  # observe(
  #   {
  #     req(plot_1 , plot_2, reporter_iso_sel$reporter_iso_sel)
  # screenshot(selector = "#treemapbar", timer = 3, filename = "tradeingoods", server_dir = ".", download = FALSE)
  #  screenshot(selector = "#LPI-LPIBox", timer = 3, filename = "LPI", server_dir = ".", download = FALSE)
  #     # screenshot(selector = "#tradeingoods-barchart", timer = 3, filename = "barchart")
  #   }
  # )
  
  
})
#### End create Server actions #####
