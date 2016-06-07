#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
  actionButton("start", "start"),
  textOutput("dimensions"),
   imageOutput("spring")
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output, session) {
   rv = reactiveValues(width=400, height=400)
   output$dimensions <- renderText({
     paste("width=", rv$width, "  height=", rv$height)
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
   observe ({
    if(!is.null(input$start))
      if(input$start > 0) {
        isolate({rv$width = rv$width * 1.2})
      }
   })
})

# Run the application 
shinyApp(ui = ui, server = server)

