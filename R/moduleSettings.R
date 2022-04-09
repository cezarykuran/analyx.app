#
# Module settings
#

# UI function
moduleSettingsUI <- function(id) {
  # helpers
  ns <- NS(id)

  val_row <- function(id) {
    fluidRow(
      column(6,
        inputStateContainer(
          ns(paste0(id, 'Pct')),
          numericInput(
            ns(paste0(id, 'Pct')),
            paste('Percentage of', id),
            100
          )
        )
      ),
      column(2,
        actionButton(
          ns(paste0(id, 'Reset')),
          "Reset",
          icon = icon('sync'),
          class = "btn-pct-reset"
        )
      )
    )
  }

  # output
  panel(
    head = tagList(
      icon('cogs'), 'Settings'
    ),
    body = tagList(
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

  moduleServer(
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
      observeEvent(input$aReset, {
        logDebug(LOG_PREFIX, "button input$aReset event")
        updateNumericInput(inputId = "aPct", value = 100)
      })
      observeEvent(input$bReset, {
        logDebug(LOG_PREFIX, "button input$bReset event")
        updateNumericInput(inputId = "bPct", value = 100)
      })
      observeEvent(input$cReset, {
        logDebug(LOG_PREFIX, "button input$cReset event")
        updateNumericInput(inputId = "cPct", value = 100)
      })
      observeEvent(input$dReset, {
        logDebug(LOG_PREFIX, "button input$dReset event")
        updateNumericInput(inputId = "dPct", value = 100)
      })
      observeEvent(input$eReset, {
        logDebug(LOG_PREFIX, "button input$eReset event")
        updateNumericInput(inputId = "ePct", value = 100)
      })

      # percentage inputs
      observeEvent(input$aPct, {
        logDebug(LOG_PREFIX, "numeric input input$aPct event")
        pctEvent("aPct")
      })
      observeEvent(input$bPct, {
        logDebug(LOG_PREFIX, "numeric input input$bPct event")
        pctEvent("bPct")
      })
      observeEvent(input$cPct, {
        logDebug(LOG_PREFIX, "numeric input input$cPct event")
        pctEvent("cPct")
      })
      observeEvent(input$dPct, {
        logDebug(LOG_PREFIX, "numeric input input$dPct event")
        pctEvent("dPct")
      })
      observeEvent(input$ePct, {
        logDebug(LOG_PREFIX, "numeric input input$ePct event")
        pctEvent("ePct")
      })
    }
  )
}
