ui <- shiny::fluidPage(
  # resources
  shiny::tags$head(
    shiny::tags$script(src = "app.js"),
    shiny::tags$link(rel = "stylesheet", type = "text/css", href = "app.css")
  ),

  # modules
  moduleSettingsUI("settings"),
  moduleResultsUI("results"),
)
