moduleSettingsUI <- function(id) {
  # helpers
  ns <- shiny::NS(id)

  val_row <- function(id) {
    shiny::fluidRow(
      shiny::column(6,
        inputStateContainer(
          ns(paste0(id, 'Pct')),
          shiny::numericInput(
            ns(paste0(id, 'Pct')),
            paste('Percentage of', id),
            100
          )
        )
      ),
      shiny::column(2,
        shiny::actionButton(
          ns(paste0(id, 'Reset')),
          "Reset",
          icon = shiny::icon('sync'),
          class = "btn-pct-reset"
        )
      )
    )
  }

  # output
  panel(
    head = shiny::tagList(
      shiny::icon('cogs'), 'Settings'
    ),
    body = shiny::tagList(
      val_row("a"),
      val_row("b"),
      val_row("c"),
      val_row("d"),
      val_row("e")
    ),
    collapsible = TRUE
  )
}

moduleSettings <- function(id, data) {
  shiny::moduleServer(
    id,
    function(input, output, session) {
      # helpers
      pctEvent <- function(pctID) {
        if (is.numeric(input[[pctID]])) {
          setInputState(session, pctID)
          col <- substr(pctID, 1, 1)
          .data <- data()
          .data[col] <- AnalyticsPackage::data[col] * input[[pctID]] / 100
          data(.data)
        }
        else setInputState(session, pctID, "error")
      }

      # reset buttons
      shiny::observeEvent(input$aReset, shiny::updateNumericInput(inputId = "aPct", value = 100))
      shiny::observeEvent(input$bReset, shiny::updateNumericInput(inputId = "bPct", value = 100))
      shiny::observeEvent(input$cReset, shiny::updateNumericInput(inputId = "cPct", value = 100))
      shiny::observeEvent(input$dReset, shiny::updateNumericInput(inputId = "dPct", value = 100))
      shiny::observeEvent(input$eReset, shiny::updateNumericInput(inputId = "ePct", value = 100))

      # percentage inputs
      shiny::observeEvent(input$aPct, pctEvent("aPct"))
      shiny::observeEvent(input$bPct, pctEvent("bPct"))
      shiny::observeEvent(input$cPct, pctEvent("cPct"))
      shiny::observeEvent(input$dPct, pctEvent("dPct"))
      shiny::observeEvent(input$ePct, pctEvent("ePct"))
    }
  )
}
