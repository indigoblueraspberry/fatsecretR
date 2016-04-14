#' Make Root Base String for 3-Legged Authentication
#'
#' Make the \code{root} of the requried signature base string. In this instance,  \code{root} referes to the required parameters
#' which are consisent for each API query. For example, \code{oauth_timestamp},\code{oauth_nonce},\code{oauth_consumer_key}, will
#' always be required, thus the \code{root} base string can be created independant of query paramerts and \code{oauth_signature}.
#'
#' @param CONSUMER_KEY This is your personal alphanumeric REST API key
#' @param url the \code{API URL} for the specified request
#' @param params additional paramaters which are not included in non-signed requests
#' @return a list of six elements
#' \itemize{
#'  \item{url} string of the HTTP method + the \code{RFC 3986} encoded API URL.
#'  \item{con_key} string of the user's \code{API Consumer Key}
#'  \item{sig_meth} srting of the signature method
#'  \item{time_stamp} an interger
#'  \item{nonce} a string
#'  \item{version} a string
#'  \item{callback} a string (\code{oob}) indicating \code{out-of-band configuration} callback
#' }
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

root_base_string3L <- function(CONSUMER_KEY = getOption("CONSUMER_KEY"), url, params)
{
  http_method <- "GET"

  rest_url_en <- URLencode(url, reserved = TRUE)

  url_string <- paste(http_method, rest_url_en, sep = "&")

  oauth_consumer_key <- paste("oauth_consumer_key", CONSUMER_KEY, sep = "=")

  oauth_signature_method <- paste("oauth_signature_method", "HMAC-SHA1", sep = "=")

  oauth_timestamp <- paste("oauth_timestamp", TIMESTAMP(), sep ="=")

  oauth_nonce <- paste("oauth_nonce", as.character(RNDSTR(len = 5)), sep = "=")

  oauth_version <- paste("oauth_version", "1.0", sep = "=")

  #oauth_callback <- paste("oauth_callback", "oob", sep = "=")

  r_base_str <- list(url = url_string, con_key  = oauth_consumer_key,
                     sig_meth = oauth_signature_method, time_stamp = oauth_timestamp,
                     nonce = oauth_nonce, version = oauth_version, params = params)

  return(r_base_str)
}

