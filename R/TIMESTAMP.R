#' Time Stamp
#'
#' Create a POSIX timestamp which is used as the \code{oauth_timestamp} parameter during
#' \code{Oauth Core 1.0} authentication
#'
#' @return The current time and date in number of seconds since \code{January 1, 1970 00:00:00 GMT}
#'
#' @author Tom Wilson \email{tpw@@aber.ac.uk}
#' @export
#'
#' @examples
#' \dontrun{
#' a_time_stamp <- TIMESTAMP()
#' print(Sys.time())
#' > "2016-01-07 10:22:01 GMT"
#' print(a_time_stamp)
#' > 1452162121
#'
#' }
#'
TIMESTAMP <- function()
  {
  stamp <- as.integer(as.POSIXct(Sys.time()), "GMT")
  return(stamp)
  }
