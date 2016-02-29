#File name: ui.R
#Author: Hyrole SoASWT
#Title: Mortgage Calculator

library(shiny)

# Define UI for application
shinyUI(pageWithSidebar(
  headerPanel("Mortgage Calculator"),
  sidebarPanel(  
    numericInput(inputId="mgAmount", label="Mortgage Amount ($)", value= 450000,min=0),    
    sliderInput("mgYears",
                "Mortgage term in years",
                min = 5,
                max = 35,
                value = 15),      
    numericInput(inputId="mgInterest", label="Interest rate per year (%)", value= 5,min=1, max=10),
    dateInput("mgStartDate", label = "Mortgage start date", value = "2016-03-01"),    
    actionButton("btnCalculate", "Calculate"),      
    br(),br(),
    p(strong(em("Reference:",a("Mortgage Calculator: How to calculate",href="http://www.bankrate.com/")))),
    p(strong(em("Github repository:",a("Developing Data Products - Peer Assessment Project; Shiny App",href="https://github.com/hyrole/Coursera-Data-Products"))))    
  ),
  mainPanel(
    tabsetPanel(
      tabPanel('Your results',
               h5('Total repayment ($)'),
               verbatimTextOutput("TotalRepayment"),  
               h5('Total principal ($)'),
               verbatimTextOutput("TotalPrincipal"),                
               h5('Total interest ($)'),
               verbatimTextOutput("TotalInterest"),     
               h5('Monthly payments ($)'),
               verbatimTextOutput("MonthlyPayment"),    
               h5('Estimated payment End Date'),
               verbatimTextOutput("EndDate"),                                  
               p("Reference: ", a("How to calculate mortgage", 
                               href = "http://www.bankrate.com/")),
               p("Mortgage is a loan to finance the purchase of real property. 
                 It is used by purchasers of to raise funds to buy real estate like a house, 
                 apartment, or shoplot; or by existing property owners to raise funds for any 
                 purpose while putting a lien on the property being mortgage"),               
               p("A mortgage is actually made up of several parts - the collateral you used 
                  to secure the loan, your principal and interest payments, taxes and insurance.
                  In this assingment, I will demonstrate a simple calculator to calculate 
                  total repayment, total interest and monthly payments based on the loan amount
                  and estimated current interest rate as well as mortgage term in years. 
                  This information will be used to estimate your monthly payments and see the 
                  effect of adding extra payments."),               
               p(em("Fill up information on the left side to see the results. Don't forget to click
                    on 'Calculate' button to perform changes."))
      ),
      tabPanel('Plot: Summary',
               plotOutput("plotSummary"),               
               br(),
               p("Above barplots will illustrates total loan repayment, total principal and total 
                  interest based on estimated interest rate per year and total term in years. 
                 Slide the 'Mortgage term in years' to view the responsive results.")
      ),
      tabPanel('Plot: Mortgage Rates', 
               br(),
               p(strong("10-Year Fixed Rate Mortgage Average in the United States")), 
               br(),
               column(1, offset = 0,
                  br(),
                  tableOutput("dataMortgageRate")
               ),
               column(10, offset =1,
                  plotOutput("plotMortgageRate")       
               ),
               p("Original datasource:", a("Economic Research, Federal Reserve Bank of St. Louis", 
                                           href = "https://research.stlouisfed.org/fred2/series/MORTGAGE30US/downloaddata"))
      )
    )
  )
)
)