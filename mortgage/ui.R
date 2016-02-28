library(shiny)

# Define UI for application that draws a histogram
shinyUI(pageWithSidebar(
  headerPanel("Mortgage Calculator"),
  sidebarPanel(
    numericInput(inputId="mgAmount", label="Mortgage Amount ($)", value= 300000,min=0),
    numericInput(inputId="mgYears", label="Mortgage term in years", value= 15,min=0),
    numericInput(inputId="mgInterest", label="Interest rate per year (%)", value= 5,min=0),
    dateInput("mgStartDate", label = "Mortgage start date", value = "2016-03-01"),    
    actionButton("btnCalculate", "Calculate"),
    br(),
    p(strong(em("Documentation:",a("Mortgage Calculator: How to calculate",href="READMe.html")))),
    p(strong(em("Github repository:",a("Developing Data Products - Peer Assessment Project; Shiny App",href="https://github.com/CrazyFarang/DevelopingDataProducts"))))    
  ),
  mainPanel(
    tabsetPanel(
      tabPanel('Your results',
               h5('Total repayment'),
               verbatimTextOutput("TotalRepayment"),                
               h5('Total interest'),
               verbatimTextOutput("TotalInterest"),     
               h5('Monthly payments'),
               verbatimTextOutput("MonthlyPayment"),    
               h5('Estimated payment End Date'),
               verbatimTextOutput("EndDate"),                 
               p("Source: ", a("How to calculate mortgage", 
                               href = "http://www.bankrate.com/"))
      ),
      tabPanel('Data Summary',
               h5('Available data for'),
               h5('Recent BMI Indicators'),
               p("Source: ", a("KNOEMA-WHO Global Database on Body Mass Index (BMI)", 
                               href = "http://knoema.com/WHOGDOBMIMay/who-global-database-on-body-mass-index-bmi"))
      ),
      tabPanel('Plot: Interest Rates',
               h5('Recent BMI Indicators'),
               p("Plotted data are for your gender for your specific country"),
               p("If there are no data for your gender, plotted data are for adults for your specific country"),
               p("Worldwide Data: ", a("KNOEMA-WHO Global Database on Body Mass Index (BMI)", href = "http://knoema.com/WHOGDOBMIMay/who-global-database-on-body-mass-index-bmi"))
      ),
      tabPanel('Plot: Payments Schedule',
               h5('Recent BMI Indicators'),
               p("Plotted data are for your gender for your specific country"),
               p("If there are no data for your gender, plotted data are for adults for your specific country"),
               p("Worldwide Data: ", a("KNOEMA-WHO Global Database on Body Mass Index (BMI)", href = "http://knoema.com/WHOGDOBMIMay/who-global-database-on-body-mass-index-bmi"))
      )
    )
    #,
    #p(strong("All you need is love. But a little chocolate now and then doesn't hurt. Charles M. Schulz"))
  )
)
)