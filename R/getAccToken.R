#' Get Access Token (3 Legged - Step 3)
#'
#' Retrive the \code{ouath_token} and \code{oauth_secret} from Step 3 of 3 Legged OAuth1.0 Authentication
#'
#' @param verifierCode
#' @param userToken
#' @param tokenSecret
#' @return a \code{data.frame} containing the \code{ouath_token} and \code{oauth_secret} for the request.
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

getAccToken <- function(verifierCode, userToken, tokenSecret)
  {
  qrbs <- root_base_string3L(CONSUMER_KEY = getOption("CONSUMER_KEY"), url = "http://www.fatsecret.com/oauth/access_token",
                             params = c(paste("oauth_verifier", verifierCode, sep = "="),paste("oauth_token", userToken, sep 						= "=") ))

  query_string <- paste(qrbs$con_key,qrbs$nonce,qrbs$sig_meth,
                        qrbs$time_stamp,qrbs$params[2],qrbs$params[1],qrbs$version,sep = "&")

  en_query_string <- URLencode(query_string, reserved = TRUE)

  SIG_BASE_STR <- paste(qrbs$url, en_query_string, sep = "&")

  # now make signature value

  signature <- signatureValueUser(SIG_BASE_STR,SHARED_SECRET = getOption("SHARED_SECRET"),tokenSecret)

  query_url_a <- gsub("GET&", "",URLdecode(qrbs$url))
  query_url_b <- paste(query_string, signature, sep = "&")
  query_url_c <- paste(query_url_a, query_url_b, sep = "?")

  #submit to API

  qu_res <-  getURLContent(query_url_c)

  qu_res2 <- strsplit(qu_res[1], "&")[[1]]

  splitResponse <- strsplit(qu_res2, "=")

  response <- matrix(nrow = 2, ncol = 2)
  for(i in 1:length(splitResponse)){
    response[i,1] <- splitResponse[[i]][1]
    response[i,2] <- splitResponse[[i]][[2]]
  }
  return(response)
  }
