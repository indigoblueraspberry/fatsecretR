#' Authorisation Signature
#'
#' Generate the \code{oauth_signature} parameter; which is used to sign all API requests
#'
#' @param object A \code{fatsecret} or \code{fatsecret3L} object
#' @param query_string a character of the REST API query
#' @param params any additional parameters (\code{default is NULL})
#'
#' @return a character of the \code{oauth_signature}
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

AuthSignature <- function(object, query_string, params = NULL)
{
  if(is.null(params)){
    secret_value <- paste0(object@SharedSecret, "&")

    signature_enc <- httr::hmac_sha1(secret_value, query_string)
    signature_esc <- URLencode(signature_enc, reserved = TRUE)

    signature_value <- paste0("oauth_signature=", signature_esc)
  }

  if(!is.null(params)){

    secret_value <- paste0(object@SharedSecret, "&", params)
    signature_enc <- httr::hmac_sha1(secret_value, query_string)
    signature_esc <- URLencode(signature_enc, reserved = TRUE)

    signature_value <- paste0("oauth_signature=", signature_esc)
  }
  return(as.character(signature_value))
}
