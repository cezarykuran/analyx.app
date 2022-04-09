#
# Module settings
#

# UI function
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

# server function
moduleSettings <- function(id, data) {
  LOG_PREFIX <- paste0("moduleSettings[", id, "]: ")
  logInfo(LOG_PREFIX, "starting")

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
      shiny::observeEvent(input$aReset, {
        logDebug(LOG_PREFIX, "button input$aReset event")
        shiny::updateNumericInput(inputId = "aPct", value = 100)
      })
      shiny::observeEvent(input$bReset, {
        logDebug(LOG_PREFIX, "button input$bReset event")
        shiny::updateNumericInput(inputId = "bPct", value = 100)
      })
      shiny::observeEvent(input$cReset, {
        logDebug(LOG_PREFIX, "button input$cReset event")
        shiny::updateNumericInput(inputId = "cPct", value = 100)
      })
      shiny::observeEvent(input$dReset, {
        logDebug(LOG_PREFIX, "button input$dReset event")
        shiny::updateNumericInput(inputId = "dPct", value = 100)
      })
      shiny::observeEvent(input$eReset, {
        logDebug(LOG_PREFIX, "button input$eReset event")
        shiny::updateNumericInput(inputId = "ePct", value = 100)
      })

      # percentage inputs
      shiny::observeEvent(input$aPct, {
        logDebug(LOG_PREFIX, "numeric input input$aPct event")
        pctEvent("aPct")
      })
      shiny::observeEvent(input$bPct, {
        logDebug(LOG_PREFIX, "numeric input input$bPct event")
        pctEvent("bPct")
      })
      shiny::observeEvent(input$cPct, {
        logDebug(LOG_PREFIX, "numeric input input$cPct event")
        pctEvent("cPct")
      })
      shiny::observeEvent(input$dPct, {
        logDebug(LOG_PREFIX, "numeric input input$dPct event")
        pctEvent("dPct")
      })
      shiny::observeEvent(input$ePct, {
        logDebug(LOG_PREFIX, "numeric input input$ePct event")
        pctEvent("ePct")
      })
    }
  )
}
