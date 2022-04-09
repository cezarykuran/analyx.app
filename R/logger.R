LOGGER <- NULL


#' Init logger
#'
#' @seealso \link[log4r]{logger}
#' @inheritParams log4r::logger
#'
initLogger <- function(threshold = "DEBUG") {
  assign("LOGGER", log4r::logger(threshold), envir = parent.env(environment()))
  logDebug("Logger initialized with '", threshold, "' level")
}

#' Log debug message
#'
#' @seealso \link[log4r]{debug}
#' @inheritParams log4r::debug
#'
logDebug <- function(...) {
  stopifnot(is.list(LOGGER))
  log4r::debug(LOGGER, ...)
}

#' Log info message
#'
#' @seealso \link[log4r]{info}
#' @inheritParams log4r::debug
#'
logInfo <- function(...) {
  stopifnot(is.list(LOGGER))
  log4r::info(LOGGER, ...)
}

#' Log warning message
#'
#' @seealso \link[log4r]{warn}
#' @inheritParams log4r::warn
#'
logWarn <- function(...) {
  stopifnot(is.list(LOGGER))
  log4r::warn(LOGGER, ...)
}

#' Log error message
#'
#' @seealso \link[log4r]{error}
#' @inheritParams log4r::error
#'
logError <- function(...) {
  stopifnot(is.list(LOGGER))
  log4r::error(LOGGER, ...)
}
