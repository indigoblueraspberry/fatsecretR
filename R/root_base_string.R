#' Make Root Base String
#'
#' Make the \code{root} of the requried signature base string. In this instance,  \code{root} referes to the required parameters
#' which are consisent for each API query. For example, \code{oauth_timestamp},\code{oauth_nonce},\code{oauth_consumer_key}, will
#' always be required, thus the \code{root} base string can be created independant of query paramerts and \code{oauth_signature}.
#'
#' @param CONSUMER_KEY This is your personal alphanumeric REST API key
#' @return A list of six elements
#' \itemize{
#'  \item{url} String of the HTTP method + the \code{RFC 3986} encoded API URL.
#'  \item{con_key} String of the user's \code{API Consumer Key}
#'  \item{sig_meth} Srting of the signature method
#'  \item{time_stamp} An interger
#'  \item{nonce} A string
#'  \item{version} A string
#' }
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#'
#'

root_base_string <- function(CONSUMER_KEY = getOption("CONSUMER_KEY"))
  {
  http_method <- "GET"
  rest_url <- "http://platform.fatsecret.com/rest/server.api"
  rest_url_en <- URLencode(rest_url, reserved = TRUE)

  url_string <- paste(http_method, rest_url_en, sep = "&")

  oauth_consumer_key <- paste("oauth_consumer_key", CONSUMER_KEY, sep = "=")

  oauth_signature_method <- paste("oauth_signature_method", "HMAC-SHA1", sep = "=")

  oauth_timestamp <- paste("oauth_timestamp", TIMESTAMP(), sep ="=")

  oauth_nonce <- paste("oauth_nonce", as.character(RNDSTR(len = 5)), sep = "=")

  oauth_version <- paste("oauth_version", "1.0", sep = "=")


  r_base_str <- list(url = url_string, con_key  = oauth_consumer_key,
                      sig_meth = oauth_signature_method, time_stamp = oauth_timestamp,
                      nonce = oauth_nonce, version = oauth_version)

  return(r_base_str)
  }

