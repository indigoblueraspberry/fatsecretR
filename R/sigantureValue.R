#' Authentication Signature Value
#'
#' Create the signature value which encodes the signature base string and forms the \code{oauth_signature}
#' parameter
#'
#' @param SIG_BASE_STR A signature base string which has been \code{RFC 3968} encoded.
#' @param CONSUMER SECRET A alphanumeric string of your REST API Consumer Key
#' @param Access SECRET A alphanumeric string of your REST API Shared Secret. Default is \code{NULL}
#'
#' @return A \code{HMAC SHA1} encoded \code{oauth_signature}
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#'
signatureValue <- function(SIG_BASE_STR, CONSUMER_SECRET, ACCESS_SECRET = NULL)
  {

  if(is.null(ACCESS_SECRET)){
    SIG_VAL <- paste(CONSUMER_SECRET, "&", sep = "")
  }

  if(!is.null(ACCESS_SECRET)){
    SIG_VAL <- paste(CONSUMER_SECRET, ACCESS_SECRET ,sep = "&")
  }

  ## encode the signature base string
  SIG_VAL_EN <- httr::hmac_sha1(SIG_VAL, SIG_BASE_STR)

  ## escape the encoded signature value using RFC 3986
  SIG_VAL_EN2 <- URLencode(SIG_VAL_EN, reserved = TRUE)

  oauth_signature <- paste("oauth_signature", SIG_VAL_EN2, sep = "=")

  return(oauth_signature)

  }
