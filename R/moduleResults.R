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

moduleResults <- function(id, results) {
  shiny::moduleServer(
    id,
    function(input, output, session) {
      # render results
      output$table <- reactable::renderReactable({
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
