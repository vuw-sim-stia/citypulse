#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(networkD3)

shinyUI(
  fluidPage(
    titlePanel("Wellington Twitter Dashboard"),
    #Title
    #textOutput("currentTime"),
    #Sidebar title
    sidebarLayout(
      sidebarPanel(
        #textInput("caption", "Caption:", "")
      ),
      mainPanel(
        dataTableOutput('tweets_table')
      )
    )
  )
)