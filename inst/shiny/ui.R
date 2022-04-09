ui <- fluidPage(
  # resources
  tags$head(
    tags$script(src = "app.js"),
    tags$link(rel = "stylesheet", type = "text/css", href = "app.css")
  ),

  # title
  titlePanel('Analyx demo application'),

  # modules
  moduleSettingsUI("settings"),
  moduleResultsUI("results"),
)
