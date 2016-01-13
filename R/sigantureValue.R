#' Authentication Signature Value
#'
#' Create the signature value which encodes the signature base string and forms the \code{oauth_signature}
#' parameter
#'
#' @param SIG_BASE_STR A signature base string which has been \code{RFC 3968} encoded.
#' @param SHARED_SECRET A alphanumeric string of your REST API Shared Secret.
#' @param ACCESS_SECRET A alphanumeric string of a Access Secret Token. Default is \code{NULL}.
#' @return A \code{HMAC SHA1} encoded \code{oauth_signature}
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#'
signatureValue <- function(SIG_BASE_STR, SHARED_SECRET, ACCESS_SECRET = NULL)
  {

  SIG_VAL <- paste(SHARED_SECRET ,"", sep = "&")

  ## encode the signature base string
  SIG_VAL_EN <- httr::hmac_sha1(SIG_VAL, SIG_BASE_STR)

  ## escape the encoded signature value using RFC 3986
  SIG_VAL_EN2 <- URLencode(SIG_VAL_EN, reserved = TRUE)

  oauth_signature <- paste("oauth_signature", SIG_VAL_EN2, sep = "=")

  return(oauth_signature)

  }
