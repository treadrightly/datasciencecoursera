shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Air Passengers Prediction"),
    
    sidebarPanel(
      sliderInput('periodsToForecast', 'Number of periods for forecasting', 50, min=1, max=100),
      sliderInput('confidenceLevel', 'Confidence level', 90, min=1, max=99),
      numericInput('imageWidth', 'Width of output graph', 800),
      numericInput('imageHeight', 'Height of output graph', 600),
      submitButton('Submit')
    ),
    mainPanel(
      # Use imageOutput to place the image on the page
      imageOutput("myImage")
    )
  )
)