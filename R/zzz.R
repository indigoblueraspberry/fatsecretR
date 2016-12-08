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




.onLoad <- function(libname = find.package("fatsecretR"), pkgname = "fatsecretR")
{
  object <- new("fatsecret")

  object@RESTURL <- "http://platform.fatsecret.com/rest/server.api"
  object@httpMethod <- "GET"

  object@signatureMethod <- paste0("oauth_signature_method=HMAC-SHA1")
  object@oauthVersion <- paste0("oauth_version=1.0")

  method_file <- system.file("methods.RDS", package = "fatsecretR")

  object@methods <- readRDS(method_file)

  assign(eval(paste(text = "fatsecret")), object, envir = .GlobalEnv)

  return(invisible(NULL))
}
