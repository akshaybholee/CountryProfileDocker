reporter_download_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
          fluidRow(column(
    8, offset = 2, shinydashboard::box(
      solidHeader = TRUE,
      column(6,selectInput(
        inputId =   ns("Reporter"),
        label = "",
        choices =  df_country$Country,
        selected = "United States of America"
      ), class = "Reporter_Padding"),  
      column(6, align = 'right',  class = 'download_padding', 
             downloadButton(
               outputId =   ns("download1"),
               label = "Download Report",
               style = "visibility: hidden;"
             ),
             actionButton(
        inputId =   ns("download"),
        label = "Download Report",
        class = 'download_button',
        width = 150
      )
      ),
      width = 16,
      
    )
    
  )))
  
}

reporter_download_server <- function(id) {
  moduleServer(id,
               
               function(input, output, session) {
                 reporter_iso_sel <-  reactive({
                   reporter_iso <-
                     df_country$Country_ISO[df_country$Country == input$Reporter]
                   reporter_iso
                 }) %>% bindCache(input$Reporter)
                 
                 
                 return(list(
                   reporter_iso_sel = reporter_iso_sel,
                   reporter = reactive(input$Reporter),
                   dnwload = reactive(input$download)
                 ))
                 
               })
  
}

download_server <- function(id, reporter_iso_sel, tradefacilitation) {
  moduleServer( id,
                function(input, output, session){
                  
                  observeEvent(input$download,
                    {
              
                      screenshot(selector = "#demographic",  filename = "demographic", server_dir = "./ReportImg", download = FALSE)
                      screenshot(selector = "#Macroeconomic-Boxheader",  filename = "macroheader", server_dir = "./ReportImg", download = FALSE)
                      screenshot(selector = "#Macroeconomic-Boxcharts",  filename = "macrochart", server_dir = "./ReportImg", download = FALSE)
                      screenshot(selector = "#treemapbar",  filename = "tradeingoods", server_dir = "./ReportImg", download = FALSE)
                      screenshot(selector = "#tradeperformance",  filename = "tradeperformance", server_dir = "./ReportImg", download = FALSE)
                      screenshot(selector = "#LPI-LPIBox",  filename = "LPI", server_dir = "./ReportImg", download = FALSE)
                      screenshot(selector = "#bilateral-title",  filename = "bilateralhead", server_dir = "./ReportImg", download = FALSE)
                      screenshot(selector = "#bilateralchord",  filename = "bilateralchord", server_dir = "./ReportImg", download = FALSE)
                      screenshot(selector = "#agreement-TR",  filename = "agreement", server_dir = "./ReportImg", download = FALSE)
                      screenshot(selector = "#tradeinservices-ServicesBox2",  filename = "tradeinservices", server_dir = "./ReportImg", download = FALSE)
                      screenshot(selector = "#servicesperformance-SPBox",  filename = "servicesperformance", server_dir = "./ReportImg", download = FALSE)
                      screenshot(selector = "#digital",  filename = "digital", server_dir = "./ReportImg", download = FALSE)
                      screenshot(selector = "#tradefacilitation-DFTBox",  filename = "tradefacilitation", server_dir = "./ReportImg", download = FALSE)
                      
                     Sys.sleep(8)
                      shinyjs::runjs("document.getElementById('reporterdownload-download1').click();")
                      })
    
                 
              
              
                  output$download1 <- downloadHandler(
             
                    
                      filename =  "new_report.pdf",
                      content = function(file) {
                        withProgress(message = 'Downloading report...', {
                        
                        # tempReport <- normalizePath('report.Rmd')
                        # file.copy("myRmarkdown.Rmd", tempReport, overwrite = TRUE)
                        params <- list(tradefacilitation =tradefacilitation()
                        )
                        # html_fn <-
                          # rmarkdown::render(tempReport
                          #                   ,  
                          #                   params = params,
                          #                            envir = new.env(parent = globalenv()))
                          
                          rmarkdown::render("report.Rmd", output_format = "pdf_document", output_file = file,  params = params,
                                            envir = new.env(parent = globalenv()))
                        
                

                        # pagedown::chrome_print(html_fn, file)
                      })
                      }
                    )
               
                }

  )
}