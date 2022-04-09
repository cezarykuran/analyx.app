server <- function(input, output, session) {
  LOG_PREFIX <- paste0("server(): ")
  logInfo(LOG_PREFIX, "starting")

  # data
  data <- reactiveVal(
    AnalyticsPackage::data
  )
  results <- reactive({
    logInfo(LOG_PREFIX, "recalculating data")
    AnalyticsPackage::calculate(
      debounce(data, 1000)()
    )
  })

  # modules
  logInfo(LOG_PREFIX, "loading modules..")
  moduleSettings("settings", data)
  moduleResults("results", results)
}
