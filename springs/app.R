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
#  actionButton("start", "start"),
   imageOutput("spring")
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
   rv = reactiveValues(width=40, height=400)
   output$spring <- renderImage({
     #width  <- session$clientData$output_image1_width
     #height <- session$clientData$output_image1_height
     
     # Return a list containing information about the image
     list(src = "spring-photo.gif",
          contentType = "image/gif",
          #width = rv$width,
          #height = rv$height,
          width = 40,
          height = 400,
          alt = "This is alternate text")
   })
   # observe ({
   #  if(!is.null(input$start))
   #    if(input$start > 0) {
   #      rv$width = rv$width * 1.2
   #    } 
   # })   
})

# Run the application 
shinyApp(ui = ui, server = server)

