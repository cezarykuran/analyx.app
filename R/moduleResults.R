#
# Module results
#

# UI function
moduleResultsUI <- function(id) {
  # helpers
  ns <- shiny::NS(id)

  # output
  panel(
    head = shiny::tagList(
      shiny::icon('chart-pie'), 'Results'
    ),
    body = shinycssloaders::withSpinner(
      reactable::reactableOutput(ns("table"), width = "100%")
    )
  )
}

# server function
moduleResults <- function(id, results) {
  LOG_PREFIX <- paste0("moduleResults[", id, "]: ")
  logInfo(LOG_PREFIX, "starting")

  shiny::moduleServer(
    id,
    function(input, output, session) {
      # render results
      output$table <- reactable::renderReactable({
        logDebug(LOG_PREFIX, "refreshing reactable")
        reactable::reactable(
          results(),
          defaultColDef = reactable::colDef(
            format = reactable::colFormat(digits = 3)
          )
        )
      })
    }
  )
}
