#' New Authorised User
#'
#' Create an object for 3-Legged Authentication of an existing FatSecret user. The object is exported into
#' the global environment.
#'
#' @param name a character of the object name
#' @return NULL
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#' @examples
#' \dontrun{
#' newAuth(SteveFrench)
#' }

newAuth <- function(name = "")
  {
  object <- new("fatsecret3L")

  object@RequestURL <- "http://www.fatsecret.com/oauth/request_token"
  object@AccessURL <- "http://www.fatsecret.com/oauth/access_token"
  object@AuthURL <- "http://www.fatsecret.com/oauth/authorize"
  object@httpMethod <- "GET"
  object@signatureMethod <- paste0("oauth_signature_method=HMAC-SHA1")
  object@oauthVersion <- paste0("oauth_version=1.0")

  objectName <- as.list(match.call())$name

  assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)

  return(invisible(NULL))
  }
