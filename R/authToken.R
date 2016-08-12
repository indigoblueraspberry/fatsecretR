#' Get Authentication Token (3 Legged - Step 2)
#'
#' Generate the \code{URL} for User Authorization
#'
#' @param requestToken a string of the \code{oauth_token} generate in 3 Legged Authentication Step 1.
#' @return  a request \code{URL}
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

authToken <- function(requestToken)
  {
  token <- paste("oauth_token", requestToken, sep = "=")

  authURL <- paste("http://www.fatsecret.com/oauth/authorize", token, sep = "?")

  return(authURL)
  }

