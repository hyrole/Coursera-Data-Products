# Mortgage Functions - formula & calculation
CalculateTotalInterest<-function(getAmount, getInterest, getYears) {
  if (getAmount==0 | getAmount==0 | getYears==0) return(NA) 
  else return(round(getAmount*(getInterest/100)*getYears,2))
}

CalculateTotalRepayment<-function(getTotalInterest, getAmount) {
  if (is.na(getTotalInterest)) return ("")
  else return(round(getTotalInterest+getAmount,2))
}

CalculateMonthlyPayment<-function(getTotalInterest, getYears) {
  if (is.na(getTotalInterest)) return ("")
  else return(round(getTotalInterest/getYears/12,2))
}

CalculateEndDate<-function(getStartDate, getYears) {
  if (getStartDate==0 | getYears==0) return(NA) 
  else {
    #convertDate <- as.Date(getStartDate, format = "%m/%d/%Y")
    #return(getStartDate+(getYears*365))
    return(getStartDate)
  }
}

library(shiny)

# Sample Apps:
# Mortgage> http://www.bankrate.com/calculators/mortgages/mortgage-calculator.aspx
# Mortgage> https://www.zillow.com/mortgage-calculator/
# Fuel> http://journeyprice.co.uk/
# Fuel> http://www.fuel-economy.co.uk/calc.html


# Available datasets
# https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html
# Historical Exchange Rates: http://www.oanda.com/currency/historical-rates/

# Run option: runApp("myshinyapp", display.mode = "showcase")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Load dataset
  dataset <- read.csv("./data/currency.csv")
  
  # Show the first observations
  output$dataSurvey <- renderTable({
    head(dataset, 10)
  })  
  
  # Get input from UI
  amount <- reactive({as.numeric(input$mgAmount)})
  interest <- reactive({as.numeric(input$mgInterest)})
  years <- reactive({as.numeric(input$mgYears)})
  startdate <- renderPrint({input$mgStartDate})  
  
  
  # Show result on button pressed
  
  # 
  output$TotalRepayment <- renderText({
    input$btnCalculate
    isolate(CalculateTotalRepayment(CalculateTotalInterest(amount(), interest(), years()), amount()))
  })
  
  output$TotalPrincipal <- renderText({
    input$btnCalculate
    #isolate(CalculateMonthlyPayment(CalculateInterest(amount(), interest(), years()), years()))
  })  
  
  output$TotalInterest <- renderText({
    input$btnCalculate
    isolate(CalculateTotalInterest(amount(), interest(), years()))
  })
  
  output$MonthlyPayment <- renderText({
    input$btnCalculate
    isolate(CalculateMonthlyPayment(CalculateTotalRepayment(CalculateTotalInterest(amount(), interest(), years()), amount()), years()))
  }) 
  
  output$EndDate <- renderText({
    input$btnCalculate
    isolate(CalculateEndDate(startdate(), years()))
  })    
  
  # You can access the values of the widget (as a vector of Dates)
  # with input$dates, e.g.
  output$value <- renderPrint({ input$date })
  
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$distPlot <- renderPlot({
    x    <- faithful[, 2]  # Old Faithful Geyser data
    years <- seq(min(x), max(x), length.out = input$years + 1)
    
    # draw the histogram with the specified number of years
    hist(x, breaks = years, col = 'skyblue', border = 'white')
  })
})