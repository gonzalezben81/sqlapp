server <- function(input, output, session) {
  
  
  # site <- reactive({
  #   
  #   input$host
  # })
  # 
  # user <- reactive({
  #   input$user
  # })
  
  
  
  table <- eventReactive(input$connecter,{
    conn <- dbConnect(
      drv = RMySQL::MySQL(),
      dbname = input$database,
      host = input$host,
      username = input$user,
      password = input$password)
    on.exit(dbDisconnect(conn), add = TRUE)
    dbGetQuery(conn,paste0(input$texting,";"))
  })
  
  # eventReactive(input$disconnect,{
  #   all_cons <- dbListConnections(MySQL())
  #   for(con in cons)
  #     dbDisconnect(con)
  # })
  
  output$tbl<-renderTable(table())
  
  output$connectionlist <- eventReactive(input$list,{dbGetQuery(conn, "show processlist")})
  
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }"
  )
  
  output$downloadtwo <- downloadHandler(
    filename = function() { paste(input$queryname,input$filetype,sep = "") },
    content = function(file) {
      write.csv(table(), file)
      
    })
}
