shinyServer(function(input, output) {
  
  output$Help <- renderPrint({
    cat("This application forecasts airline passengers using the Box & Jenkins airline data (monthly totals of airline passengers in thousands from 1949 to 1960).\n")
    cat("\n")
    cat("There are 4 input parameters that can be manipulated:\n")
    cat("1. Number of periods for forecasting: Vary this parameter to change the number of periods for which forecast data is desired.\n")
    cat("2. Confidence level: Vary this parameter to alter the confidence level of the forecast.\n")
    cat("3. Width of output graph: Vary this parameter to modify the width of the output graph.\n")
    cat("4. Height of output graph: Vary this parameter to modify the height of the output graph.\n")
    cat("\nClick the Submit button to see the graph updated according to the input parameter values.\n")
  })
  
  output$myImage <- renderImage({
    library(datasets)
    data("AirPassengers")
    library(forecast)
    fit <- HoltWinters(AirPassengers)
    h <- input$periodsToForecast
    height <- input$imageHeight
    width <- input$imageWidth
    level <- input$confidenceLevel
    f <- forecast(fit, h = h, level = level)
    
    # A temp file to save the output.
    # This file will be removed later by renderImage
    outfile <- tempfile(fileext = '.png')
    
    # Generate the PNG
    png(outfile, width = width, height = height)
    plot(f, ylab="Number of passengers in thousands", xlab="Year")
    dev.off()
    
    # Return a list containing the filename
    list(
      src = outfile,
      contentType = 'image/png',
      width = width,
      height = height,
      alt = "Forecast graph"
    )
  }, deleteFile = TRUE)
})