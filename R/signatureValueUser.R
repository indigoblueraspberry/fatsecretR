#' Authentication Signature Value using a User Secret
#'
#' Create the signature value which encodes the signature base string and forms the \code{oauth_signature}
#' parameter. \code{signatureValue2} should be used when a \code{oauth_token} has been passed in the signature base string,
#' and thus the signature value must be encoded with the concatenated shared secret and user secret.
#'
#' @param SIG_BASE_STR a signature base string which has been \code{RFC 3968} encoded.
#' @param SHARED_SECRET a alphanumeric string of your REST API Shared Secret.
#' @param userSecret a alphanumeric string of a Access Secret Token.
#' @return a \code{HMAC SHA1} encoded \code{oauth_signature}
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

signatureValueUser <- function(SIG_BASE_STR, SHARED_SECRET = getOption("SHARED_SECRET"), userSecret)
{

  SIG_VAL <- paste(SHARED_SECRET,userSecret, sep = "&")

  ## encode the signature base string
  SIG_VAL_EN <- httr::hmac_sha1(SIG_VAL, SIG_BASE_STR)

  ## escape the encoded signature value using RFC 3986
  SIG_VAL_EN2 <- URLencode(SIG_VAL_EN, reserved = TRUE)

  oauth_signature <- paste("oauth_signature", SIG_VAL_EN2, sep = "=")

  return(oauth_signature)

}
