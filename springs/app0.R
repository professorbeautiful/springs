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
   imageOutput("spring")
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
   
   output$spring <- renderImage({
     #width  <- session$clientData$output_image1_width
     #height <- session$clientData$output_image1_height
     
     # Return a list containing information about the image
     list(src = "spring-photo.gif",
          #contentType = "image/gif",
          width = 400,
          height = 400,
          alt = "This is alternate text")
   })
})

# Run the application 
shinyApp(ui = ui, server = server)

