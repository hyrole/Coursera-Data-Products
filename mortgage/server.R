#File name: server.R
#Author: Hyrole SoASWT
#Title: Mortgage Calculator

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


library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Load dataset
  dataset <- read.csv("./data/mortgageus10yrs.csv")
  
  # Show the first observations
  output$dataSurvey <- renderTable({
    head(dataset, 10)
  })  
  
  # Get inputs from UI screen
  amount <- reactive({as.numeric(input$mgAmount)})
  interest <- reactive({as.numeric(input$mgInterest)})
  years <- reactive({as.numeric(input$mgYears)})
  enddate <- renderPrint({(input$mgStartDate)+(years()*365)})
    
  # Show output/results
  output$TotalRepayment <- renderText({
    input$btnCalculate
    isolate(CalculateTotalRepayment(CalculateTotalInterest(amount(), interest(), years()), amount()))
  })
  
  output$TotalPrincipal <- renderText({
    input$btnCalculate
    isolate(amount())
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
    isolate(enddate())
  })    
  
  # Generate bar plot
  output$plotSummary <- renderPlot({
    datam <- c(CalculateTotalRepayment(CalculateTotalInterest(amount(), interest(), years()), amount()),
           amount(), 
           CalculateTotalInterest(amount(), interest(), years()))
    color <- c('skyblue', 'red1', 'green')
    bp <- barplot(datam, col = color, border = 'white', main="Mortgage Distribution", horiz=TRUE,
            names.arg=c("Repayment", "Principal", "Interest"))  
    ## Add text at top of bars
    text(y = bp, x = datam, label = datam, pos = 2, cex = 1.2, col = "white")    
  })
  
  rates <- aggregate(. ~ YEAR, dataset[-1], mean)
  
  # Show the dataset observations
  output$dataMortgageRate <- renderTable({
    head(rates, 10)
  })  
  
  # Generate line plot
  output$plotMortgageRate <- renderPlot({
    ggplot(rates, aes(x=YEAR, y=VALUE, colour="red")) + geom_line(stat="identity", color = "red", lwd = 1) + 
      labs(x="Years", y="Interes Rates") 
  })  
})

# Sample Apps:
# Mortgage> http://www.bankrate.com/calculators/mortgages/mortgage-calculator.aspx
# Mortgage> https://www.zillow.com/mortgage-calculator/
# Fuel> http://journeyprice.co.uk/
# Fuel> http://www.fuel-economy.co.uk/calc.html

# Available datasets
# https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html
# Historical Exchange Rates: http://www.oanda.com/currency/historical-rates/
# Run option: runApp("myshinyapp", display.mode = "showcase")