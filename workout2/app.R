# Example discussed in lecture April-08-2019


library(shiny)
library(ggplot2)
library(reshape)
library(reshape2)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Savings Simulation"),
  
  # Sidebar with a slider input for number of bins 

      fluidRow(
        column(4,
      
      sliderInput("amount",
                  "Initial Amount:",
                  min = 0,
                  max = 100000,
                  value = 1000,
                  step = 500)),
      
      column(4,
      sliderInput("contrib",
                  "Annual Contribution:",
                  min = 0,
                  max = 50000,
                  value = 2000,
                  step = 500)),
      
      column(4,
      sliderInput("r_rate",
                  "Return Rate",
                  min = 0,
                  max = 0.2,
                  value = 0.05,
                  step = 0.001)),
      
      column(4,
      sliderInput("growth",
                  "rowth Rate:",
                  min = 0,
                  max = 0.2,
                  value = 0.02,
                  step = 0.001)),
      
      column(4,
      sliderInput("years",
                  "Years:",
                  min = 0,
                  max = 50,
                  value = 20,
                  step = 1)),
      
      column(4,
      selectInput("facet",
                  "Facet:",
                  choices = c("yes","no"))),
      
    
     mainPanel(  
        h4("Timelines"),
      plotOutput("distPlot"),
      h4("Balance"),
      tableOutput("ttable")
                  
      )))
    
    
    # Show a plot of the generated distribution
    
      
    
  


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  modalities <- reactive({
    future_value <- function(amount,r_rate,years)
    {
      ans=amount*((1+r_rate)^years)
      return(ans)
    }
    
    annuity <- function(contrib,r_rate,years)
    {
      part1=(1+r_rate)^years
      part2=(part1-1)/r_rate
      ans=contrib*part2
      return(ans)
    }
    
    growing_annuity <- function(contrib,r_rate,growth,years)
    {
      part1=(1+r_rate)^years-(1+growth)^years
      part2=part1/(r_rate-growth)
      ans=contrib*part2
      return(ans)
    }
    
    yearss=seq(1,input$years,1)
    modalities <- data.frame(year=yearss,no_contrib=yearss,fix_contrib=yearss,growing_contrib=yearss)
    
    for (i in 1:input$years){
      modalities$no_contrib[i]=future_value(input$amount,input$r_rate,i)
      modalities$fix_contrib[i]=annuity(200,input$r_rate,i)+future_value(input$amount,input$r_rate,i)
      modalities$growing_contrib[i]=future_value(input$amount,input$r_rate,i)+growing_annuity(200,input$r_rate,input$growth,i)
    }
    
    table(modalities)
    
  
    
    melt_data <- melt(modalities,id.vars="year")
    return(modalities)
  })
  
  

  
  output$distPlot <- renderPlot({
    
    if (input$facet=="no")
    {
    melt_data <- melt(modalities(),id.vars="year")
    ggplot(data=melt_data,aes(x=year,y=value))+geom_line(aes(color=variable))+ggtitle("The comparison of earnings bewteen different ways of saving")
    }
    else 
    {
      melt_data <- melt(modalities(),id.vars="year")
      ggplot(data=melt_data,aes(x=year,y=value))+geom_line(aes(color=variable))+ggtitle("The comparison of earnings bewteen different ways of saving")+facet_wrap(.~variable)
    }
    
  })
  
  output$ttable <- renderTable({
    modalities()
  })
  
  

  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

