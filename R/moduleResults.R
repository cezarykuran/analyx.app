#
# Module results
#

# UI function
moduleResultsUI <- function(id) {
  # helpers
  ns <- NS(id)

  # output
  panel(
    head = tagList(
      icon('chart-pie'), 'Results'
    ),
    body = tagList(
      shinycssloaders::withSpinner(
        reactable::reactableOutput(ns("table"), width = "100%")
      ),
      hr(),
      shinycssloaders::withSpinner(
        plotly::plotlyOutput(ns("plot"))
      )
    )
  )
}

# server function
moduleResults <- function(id, results) {
  LOG_PREFIX <- paste0("moduleResults[", id, "]: ")
  logInfo(LOG_PREFIX, "starting")

  moduleServer(
    id,
    function(input, output, session) {
      # render reactable
      output$table <- reactable::renderReactable({
        logDebug(LOG_PREFIX, "refreshing reactable")
        reactable::reactable(
          results(),
          defaultColDef = reactable::colDef(
            format = reactable::colFormat(digits = 3)
          ),
          columns = list(
            res = reactable::colDef(name = "results")
          )
        )
      })
      # render plot
      output$plot <- plotly::renderPlotly({
        logDebug(LOG_PREFIX, "refreshing plot")
        plotly::plot_ly(
          data = results(),
          x = seq_len(NROW(results())),
          y = ~res,
          type = "bar"
        ) %>%
        plotly::layout(
          yaxis = list(title = 'results')
        )
      })
    }
  )
}
