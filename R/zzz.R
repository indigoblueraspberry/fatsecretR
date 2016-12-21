
#' @importFrom methods new

.onLoad <- function(libname = find.package("fatsecretR"), pkgname = "fatsecretR")
{
  object <- new("fatsecret")

  object@RESTURL <- "http://platform.fatsecret.com/rest/server.api"
  object@httpMethod <- "GET"

  object@signatureMethod <- paste0("oauth_signature_method=HMAC-SHA1")
  object@oauthVersion <- paste0("oauth_version=1.0")

  load(system.file("extdata/methods.rda", package = "fatsecretR"))
  object@methods <- methods

  assign(eval(paste(text = "fatsecret")), object, envir = .GlobalEnv)

  return(invisible(NULL))
}
