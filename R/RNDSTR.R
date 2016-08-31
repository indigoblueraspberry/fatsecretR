#' Random String
#'
#' Create a random alphanumeric string which can be used as the \code{oauth_nonce} parameter during
#' \code{Oauth Core 1.0} authentication
#'
#' @param len a numeric value for the length of the string
#' @return a random string of length \code{len}
#'
#' @author Tom Wislon \email{tpw2@@aber.ac.uk}
#' @keywords internal

#' @examples
#' \dontrun{
#' a_random_string <- RNDSTR(10)
#' print(a_random_string)
#' > "DJoyME7yaH"
#' }

RNDSTR <- function(len)
  {
  if(!is.numeric(len)){stop("...length parameter must be numeric", call. = FALSE)}

  rand_str <- paste(sample(c(0:9, letters, LETTERS),len, replace=TRUE),collapse="")
  return(rand_str)
  }

