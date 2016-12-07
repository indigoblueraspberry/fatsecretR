#'
#'
#'
#'
#'
#'
#'
#'
#'
#'




.onLoad <- function()
{
  object <- new("fatsecret")

  object@RequestURL <- "http://www.fatsecret.com/oauth/request_token"
  object@AccessURL <- "http://www.fatsecret.com/oauth/access_token"
  object@AuthURL <- "http://www.fatsecret.com/oauth/authorize"
  object@RESTURL <- "http://platform.fatsecret.com/rest/server.api"
  object@httpMethod <- "GET"
  object@RESTURLenc <- paste0(object@httpMethod, "&",
                                 URLencode(object@RESTURL, reserved = TRUE))

  object@signatureMethod <- paste0("oauth_signature_method=HMAC-SHA1")
  object@oauthVersion <- paste0("oauth_version=1.0")

  object@methods <- readRDS("~/Desktop/methods.RDS")

  assign(eval(paste(text = "fatsecret")), object, envir = .GlobalEnv)

  return(invisible(NULL))
}
