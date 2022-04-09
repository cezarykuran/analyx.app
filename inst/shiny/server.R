server <- function(input, output, session) {
  LOG_PREFIX <- paste0("server(): ")
  logInfo(LOG_PREFIX, "starting")

  # data
  data <- shiny::reactiveVal(
    AnalyticsPackage::data
  )
  results <- shiny::reactive({
    logInfo(LOG_PREFIX, "recalculating data")
    AnalyticsPackage::calculate(
      shiny::debounce(data, 1000)()
    )
  })

  # modules
  logInfo(LOG_PREFIX, "loading modules..")
  moduleSettings("settings", data)
  moduleResults("results", results)
}
