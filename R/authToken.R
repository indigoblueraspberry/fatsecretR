#' Get Authentication Token (3 Legged - Step 2)
#'
#'
#'
#'
#'
#'
#'


authToken <- function(requestToken)
{
  token <- paste("oauth_token", requestToken, sep = "=")

  authURL <- paste("http://www.fatsecret.com/oauth/authorize", token, sep = "?")

  return(authURL)
}


