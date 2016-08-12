#' Convert POSIX days to date
#'
#' Date outputs from signed delegated requests are retured as POSIX days (number of days since \code{01/01/1970}). This function
#' converts the date output to a human readable format; \code{YYYY-MM-DD}
#'
#' @param x a numeric vector of \code{POSIX} days
#' @return a character of date in the format \code{YYYY-MM-DD}
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @keywords internal

POSIXdays_to_date <- function(x)
  {
  if(!is.numeric(x)){stop("...POSIX day input must be numeric", call. = FALSE)}

  posix_time <- as.POSIXct(x * (24 * 60 * 60), origin = "1970-01-01", tz = "GMT")

  string_date <- as.Date(posix_time)

  return(string_date)
  }
