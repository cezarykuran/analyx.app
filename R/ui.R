#' Bootstrap panel
#'
#' Function that creates the UI of the bootstrap panel
#'
#' @seealso \href{https://getbootstrap.com/docs/3.3/components/#panels}{Bootstrap panels}
#' @param body string/shiny.tag, panel body content
#' @param head string/shiny.tag, panel header content
#' @param footer string/shiny.tag, panel footer content
#' @param collapsible flag to turn on/off collapsing functionality
#' @return shiny.tag of the panel
panel <- function(body, head = NULL, footer = NULL, collapsible = FALSE) {
  stopifnot(
    inherits(body, c("character", "shiny.tag", "shiny.tag.list")),
    inherits(head, c("character", "shiny.tag", "shiny.tag.list", "NULL")),
    inherits(footer, c("character", "shiny.tag", "shiny.tag.list", "NULL")),
    is.logical(collapsible) && length(collapsible) == 1
  )
  div(
    class = "panel panel-default open",
    if(!is.null(head) || collapsible) {
      div(
        class = "panel-heading",
        onclick = ifelse(collapsible, "panelCollapse(this)", ""),
        if (collapsible)
          span(
            class = "pull-right",
            icon('chevron-up'),
            icon('chevron-down')
          ),
        head
      )
    },
    div(
      class = "panel-body",
      body
    ),
    if(!is.null(footer)) div(class = "panel-footer", footer)
  )
}

#' Container to allow set state for inputs
#'
#' @param id string, id of the input
#' @param inputUI string/shiny.tag, input content
#' @return shiny.tag of the panel
inputStateContainer <- function(id, inputUI) {
  stopifnot(
    is.character(id) && length(id) == 1,
    inherits(inputUI, c("character", "shiny.tag", "shiny.tag.list"))
  )
  div(id = paste0(id, "State"), inputUI)
}

#' Set input state
#'
#' @param session shiny session object
#' @param id string, id of the input
#' @param state string/NULL, "success"|"warning"|"error"|NULL
setInputState <- function(session, id, state = NULL) {
  stopifnot(
    is.function(session$sendCustomMessage),
    is.character(id) && length(id) == 1,
    is.null(state) ||
      is.character(state) && state %in% c("success", "warning", "error")
  )
  session$sendCustomMessage(
    "setInputState",
    list(id = session$ns(paste0(id, "State")), state = state)
  )
}
