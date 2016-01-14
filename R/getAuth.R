#' getAuth
#'
#' Retrive the \code{ouath_token} and \code{oauth_secret} for a profile created using \code{makeProfile}
#'
#' @param user The user_id for the profile to query
#' @return A \code{data.frame} containing the \code{ouath_token} and \code{oauth_secret} for the specified \code{user_id}
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#'

getAuth <- function(user_id)
  {
  qrbs <- root_base_string()

  method <- paste("method", "profile.get_auth", sep = "=")
  search_exp <- paste("user_id", user_id, sep = "=")

  query_string <- paste(method,qrbs$con_key,
                        qrbs$nonce, qrbs$sig_meth, qrbs$time_stamp,
                        qrbs$version,search_exp,sep = "&")

  en_query_string <- URLencode(query_string, reserved = TRUE)

  SIG_BASE_STR <- paste(qrbs$url, en_query_string, sep = "&")

  # now make signature value

  signature <- signatureValue(SIG_BASE_STR, ACCESS_SECRET = NULL)

  query_url_a <- gsub("GET&", "",URLdecode(qrbs$url))
  query_url_b <- paste(query_string, signature, sep = "&")
  query_url_c <- paste(query_url_a, query_url_b, sep = "?")


  #submit to API

  qu_res <-  getURLContent(query_url_c)

  qu_res2 <- parseXML(qu_res)
  qu_res2 <- data.frame(qu_res2)
  names(qu_res2) <- "value"
  rownames(qu_res2) <- c("token", "secret")

  return(qu_res2)
  }
