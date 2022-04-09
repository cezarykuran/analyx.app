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
    body = shiny::tagList(
      shinycssloaders::withSpinner(
        reactable::reactableOutput(ns("table"), width = "100%")
      ),
      shiny::hr(),
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

  shiny::moduleServer(
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
          yaxis = list(title = 'Results')
        )
      })
    }
  )
}
