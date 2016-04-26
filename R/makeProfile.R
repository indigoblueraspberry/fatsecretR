#' Create a user profile
#'
#' Create a user profile which a specific user ID and retrieve the \code{oauth_token} and \code{access_secret}
#' for the user. The tokens do not need to be saved, as providing a user_id string is specified,
#' then tokens can be retrieved at any time using \code{getAuth}
#'
#' @param user_id a unique identifier for the new profile
#' @return the user token and access secret for the new profile
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

makeProfile <- function(user_id)
  {
  # make the query root base string (qrbs)
  qrbs <- root_base_string()

  # query string
  method <- paste("method", "profile.create", sep = "=")
  uid <- paste("user_id", user_id, sep = "=")

  query_string <- paste(method,qrbs$con_key,
                       qrbs$nonce, qrbs$sig_meth, qrbs$time_stamp,
                       qrbs$version,uid,sep = "&")


  en_query_string <- URLencode(query_string, reserved = TRUE)

  SIG_BASE_STR <- paste(qrbs$url, en_query_string, sep = "&")

  # now make signature value

  signature <- signatureValue(SIG_BASE_STR)

  query_url_a <- gsub("GET&", "",URLdecode(qrbs$url))

  query_url_b <- paste(query_string, signature, sep = "&")

  query_url_c <- paste(query_url_a, query_url_b, sep = "?")

  #submit to API

  profile_res <-  getURLContent(query_url_c)

  profile_res2 <- parseXML(profile_res)

  profile_res3 <- data.frame(profile_res2)
  names(profile_res3) <- "value"
  rownames(profile_res3) <- c("token", "secret")

  return(profile_res3)
  }
