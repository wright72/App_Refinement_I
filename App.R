library(shiny)
library(vroom)
library(tidyverse)
library(bslib)
library(cowplot)
library(DT)

Food_Impacts <- read.csv("C:\\Users\\ua417e\\Desktop\\(1) Trevor Wright\\( 0 ) Learning and Ref\\( 2 ) School stuff\\( 3 ) WWU Course\\5Q) Data Sci\\App and Dashboard Dev\\06) App Development\\Food_Production_Impacts\\Food_Production.csv")
summary(Food_Impacts)

ggplot(Food_Impacts, aes(x=Food.product, y=Total_emissions, group = 1)) +  geom_line()

ggplot(Food_Impacts, aes(x=Food.product, y=Land.use.per.1000kcal..m..per.1000kcal., group = 1)) +  geom_line()

ggplot(Food_Impacts, aes(x=Food.product, y=Eutrophying.emissions.per.1000kcal..gPO.eq.per.1000kcal., group = 1)) +  geom_line()

ggplot(Food_Impacts, aes(x=Food.product, y=Scarcity.weighted.water.use.per.1000kcal..liters.per.1000.kilocalories., group = 1)) +  geom_line()


# Define UI for application that draws a histogram
ui <- fluidPage(theme = bs_theme(),
                
                fluidRow(
                  column(4, DTOutput("Food_Impacts_Table"))
               
                ),
                fluidRow(
                  column(12, plotOutput("Total_emissions"))
                ),
                fluidRow(
                  column(12, plotOutput("Land.use"))
                ),
                fluidRow(
                  column(12, plotOutput("Eutrophying.emissions"))
                ),
                fluidRow(
                  column(12, plotOutput("Scarcity.weighted"))
                )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) { 
  
  df <- Food_Impacts %>% select(c(Food.product,Land.use.change,Animal.Feed,Farm,Processing,Transport,Packging,Retail))
  
  output$Food_Impacts_Table <- renderDT(df, options = list(lengthChange = TRUE))
  
  output$Total_emissions <- renderPlot(
      ggplot(Food_Impacts, aes(x=Food.product, y=Total_emissions, group = 1)) +
      geom_line() +
      labs(y = "Total Emissions"))
  
  output$Land.use <- renderPlot(
      ggplot(Food_Impacts, aes(x=Food.product, y=Land.use.per.1000kcal..m..per.1000kcal., group = 1)) +
      geom_line() +
      labs(y = "Land Use per 1000 K Cal"))
  
  output$Scarcity.weighted <- renderPlot(
    ggplot(Food_Impacts, aes(x=Food.product, y=Scarcity.weighted.water.use.per.1000kcal..liters.per.1000.kilocalories., group = 1))+
      geom_line() +
      labs(y= "Scarcity Weighted Water User per 1000 K Cal"))
  
  output$Eutrophying.emissions <- renderPlot(
      ggplot(Food_Impacts, aes(x=Food.product, y=Eutrophying.emissions.per.1000kcal..gPO.eq.per.1000kcal., group = 1))+
      geom_line() +
      labs(y= "Eutropying Emissions"))
  
  
  
 
  
  
  
}

# Run the application 
shinyApp(ui, server)
