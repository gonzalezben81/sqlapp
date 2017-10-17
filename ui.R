library(shiny)
library(DBI)

ui <- fluidPage(
  headerPanel("SQL Connection:"),
  sidebarPanel(
  textInput("database",label = "Enter Database Name Here:",value = ""),
  textInput("host",label = "Enter hostname/url here:",value = ""),
  textInput("user",label = "Enter user name here:",value = ""),
  passwordInput("password",label = "Password",value = ""),
  textInput( "texting",label = "Enter SQL Query Here:",placeholder = "SELECT * FROM boston;"),
  actionButton("connecter",label = "Connect"),
  actionButton("disconnect",label = "Disconnect"),
  textInput("queryname",label = "Enter file name here:"),
  radioButtons("filetype",label = "File Extension Type",choices = c(".txt",".csv",".xls"),selected = ".csv"),
  downloadButton("downloadtwo", label="Download SQL Data", class = "butt")
  #actionButton("list", label="Connection List", class = "butt")
  ),
  mainPanel(
  tableOutput("tbl"),
  tableOutput("connectionlist"),
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }"
  ))
)
