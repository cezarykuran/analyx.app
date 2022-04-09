server <- function(input, output) {
  # data
  data <- shiny::reactiveVal(
    AnalyticsPackage::data
  )
  results <- shiny::reactive({
    AnalyticsPackage::calculate(
      shiny::debounce(data, 1000)()
    )
  })

  # modules
  moduleSettings("settings", data)
  moduleResults("results", results)
}
