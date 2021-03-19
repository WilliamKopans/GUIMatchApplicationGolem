#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- fluidPage(theme = shinytheme("spacelab"),
  
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
                  
                  
                  navbarPage("Match App",
                             
                             tabPanel("Top Data Import",
                                      h3("Import Data to the Top Plot"),
                                      
                                      sidebarLayout(
                                        sidebarPanel(
                                          fileInput("Top", "Choose Data File", multiple = FALSE, accept = c("text/csv","text/comma-separated-values,text/plain",".csv")),
                                          tags$hr(),
                                          checkboxInput("header", "Header", TRUE),
                                          radioButtons("sep", "Separator",
                                                       choices = c(Comma = ",", Semicolon = ";", Tab = "\t"),
                                                       selected = ","),
                                          radioButtons("quote", "Quote",
                                                       choices = c(None = "", "Double Quote" = '"', "Single Quote" = "'"),
                                                       selected = '"'),
                                          tags$hr(),
                                          radioButtons("disp", "Display",
                                                       choices = c(Head = "head", All = "all"), selected = "head"),
                                          #checkboxGroupInput("FinalTopTransformations", "Data Transformations:",
                                          #                   choiceNames = list(("Zero-Mean"), ("Any Other?")),
                                          #                   choiceValues = list("ZeroMean", "AnyOther") #https://shiny.rstudio.com/reference/shiny/latest/checkboxGroupInput.html
                                          #),
                                          
                                          #~~~~~~~~~~~~~~~
                                          
                                          uiOutput("FinalTopVarX"),
                                          uiOutput("FinalTopVarY"),
                                          br(),
                                          actionButton("FinalShowTopPlot", "Update Top Plot"),
                                        ),
                                        
                                        mainPanel(
                                          tableOutput("FinalTopContents"),
                                        )
                                      )
                             ),
                             tabPanel("Bottom Data Import",
                                      h3("Import Data to the Bottom Plot"),
                                      
                                      sidebarLayout(
                                        sidebarPanel(
                                          fileInput("Bottom", "Choose Data File", multiple = FALSE, accept = c("text/csv","text/comma-separated-values,text/plain",".csv")),
                                          tags$hr(),
                                          checkboxInput("headerBottom", "Header", TRUE),
                                          radioButtons("sepBottom", "Separator",
                                                       choices = c(Comma = ",", Semicolon = ";", Tab = "\t"),
                                                       selected = ","),
                                          radioButtons("quoteBottom", "Quote",
                                                       choices = c(None = "", "Double Quote" = '"', "Single Quote" = "'"),
                                                       selected = '"'),
                                          tags$hr(),
                                          radioButtons("dispBottom", "Display",
                                                       choices = c(Head = "headBottom", All = "allBottom"), selected = "headBottom"),
                                          #heckboxGroupInput("FinalBottomTransformations", "Data Transformations:",
                                          #                  choiceNames = list(("Zero-Mean"), ("Any Other?")),
                                          #                  choiceValues = list("ZeroMeanBottom", "AnyOther") #https://shiny.rstudio.com/reference/shiny/latest/checkboxGroupInput.html
                                          #,
                                          
                                          #~~~~~~~~~~~~~~~
                                          
                                          uiOutput("FinalBottomVarX"),
                                          uiOutput("FinalBottomVarY"),
                                          br(),
                                          actionButton("FinalShowBottomPlot", "Update Bottom Plot"),
                                        ),
                                        
                                        mainPanel(
                                          tableOutput("FinalBottomContents"),
                                        )
                                      )
                             ),
                             tabPanel("Graphs",
                                      h3("Graphs"),
                                      fluidRow(
                                        column(6,numericInput("FinalRowNumber", label = h3("Tie Point Number"), value = 1)),
                                        downloadButton("downloadEmptyData", "Download New Tie File"),
                                        #column(6, fileInput("TiePointFile", label = "Upload Tie Point File", multiple = FALSE, accept = c(".tie")),) #Old Tie upload
                                        shinyFilesButton('files', 'File select', 'Please select a file', FALSE), #New Tie file import
                                      ),
                                      tableOutput("TiePShow"),
                                      actionButton(
                                        inputId = "launchDelete",
                                        label = "Clear Tie Point Data (This Row Only)"
                                      ),
                                      actionButton(
                                        inputId = "FinalCheck",
                                        label = "Finalize Tie File"
                                      ),
                                      fluidRow(
                                        column(6,
                                               
                                        ),
                                        column(6,
                                               
                                        ),
                                      ),
                                      uiOutput("SliderTopX"),
                                      uiOutput("SliderTopY"),
                                      plotOutput("FullTopPlot", click = "TopPlot_click"),
                                      plotOutput("FullBottomPlot", click = "BottomPlot_click"),
                                      uiOutput("SliderBotX"),
                                      uiOutput("SliderBotY"),
                                      
                                      
                                      
                             )
                  )
  )
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  


#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'GUIMatchApplicationGolem'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

