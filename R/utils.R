#' Run shiny app
#' @export
run <- function() {
  shiny::runApp(system.file('shiny', package = 'analyx.app'))
}
