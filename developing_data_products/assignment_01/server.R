shinyServer(
  function(input, output) {
    output$myImage <- renderImage({
      library(datasets)
      data("AirPassengers")
      library(forecast)
      fit <- HoltWinters(AirPassengers)
      h <- input$periodsToForecast
      height <- input$imageHeight
      width <- input$imageWidth
      level <- input$confidenceLevel
      f <- forecast(fit, h=h, level=level)
      
      # A temp file to save the output.
      # This file will be removed later by renderImage
      outfile <- tempfile(fileext='.png')
      
      # Generate the PNG
      png(outfile, width=width, height=height)
      plot(f)
      dev.off()
      
      # Return a list containing the filename
      list(src = outfile,
           contentType = 'image/png',
           width = width,
           height = height,
           alt = "This is alternate text")
    }, deleteFile = TRUE)
  }
)