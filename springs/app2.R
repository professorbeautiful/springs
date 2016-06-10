library(shiny)
library(shinyDebuggingPanel)


ui <- shinyUI(pageWithSidebar(
  headerPanel(div(
    "Springs",
              shinyDebuggingPanel:::withDebuggingPanel()
    ) 
  ),
  sidebarPanel(
    actionButton("start", "start"),
    textInput("K1", "K1", value = "2e-2" ),
    textInput("initPos", "initial displacement", 
              value = "400" ),
    textInput("initMom", "initial momentum", 
              value = "0" ),
    textInput("gravity", "gravity", 
              value = "1" ),
    textInput("period", "period", 
              value = "20" ),
    textInput("delta_T", "delta_T", 
              value = "0.2" ),
    textInput("refresh", "refresh", 
              value = "10" ),
    textOutput("dimensions")
  ),
  mainPanel( imageOutput("spring"))
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output, session) {
  shinyDebuggingPanel::makeDebuggingPanelOutput(session) 
   rv = reactiveValues(width=40, 
                       height=0, 
                       momentum=0, 
                       slackHeight=300,
                       time=0)
   delta_T = 1
   output$dimensions <- renderText({
     paste("width=", round(rv$width),
           "  height=", round(rv$height))
   })
   output$spring <- renderImage(
     deleteFile=FALSE,
     {
     #width  <- session$clientData$output_image1_width
     #height <- session$clientData$output_image1_height
     width = rv$width
     height = rv$height
     #width=50
     #height=400
     # Return a list containing information about the image
     list(src = "spring-photo.gif",
          # contentType = "image/gif",
          width = width,
          height = height,  
          alt = "This is alternate text")
   })
   
   observe (priority=1, {
     #autoInvalidate()
     if(!is.null(input$start))
       if(input$start > 0) {
         isolate({
           rv$time = 0 
           rv$height = as.numeric(input$initPos)
           rv$momentum = as.numeric(input$initMom)
         })
       }
   })
   observe ({
     period = 20
     invalidateLater(as.numeric(input$refresh))
    if(!is.null(input$start))
      if(input$start > 0) {
        isolate({
            delta_T = as.numeric(input$delta_T)
            K1 = as.numeric(input$K1)
            gravity = as.numeric(input$gravity)
            if(all(!is.na(c(delta_T, K1, gravity)))) {
              rv$height = rv$height + rv$momentum * delta_T
              force = K1 * (rv$height - rv$slackHeight) +
                gravity
              rv$momentum = rv$momentum - force * delta_T
            }
          rv$time = rv$time+1
        })
      }
   })
})

# Run the application 
shinyApp(ui = ui, server = server)

