#' Get Request Token (3 Legged - Step 1)
#'
#' Retrive the \code{ouath_token} and \code{oauth_secret} from Step 1 of 3 Legged OAuth1.0 Authentication
#'
#' @param callback a charatcer string for the `oauth_callback`. If unable to recieve a callback, then `callback` must be
#' set to `oob`, otherwise `callback` should equal the absolute url of your callback
#' @return a \code{data.frame} containing the following four values;
#'  \itemize{
#'    \item callback
#'    \item request_token
#'    \item token_secret
#'    \item request_url
#'  }
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

makeRequest <- function(callback)
  {


  if(callback == "oob"){

    qrbs <- root_base_string3L(CONSUMER_KEY = getOption("CONSUMER_KEY"), url = "http://www.fatsecret.com/oauth/request_token",
                             params = paste("oauth_callback", "oob", sep = "="))

    }

  query_string <- paste(qrbs$params,qrbs$con_key,qrbs$nonce,qrbs$sig_meth,
                        qrbs$time_stamp,qrbs$version, sep = "&")

  en_query_string <- URLencode(query_string, reserved = TRUE)

  SIG_BASE_STR <- paste(qrbs$url, en_query_string, sep = "&")

  # now make signature value

  signature <- signatureValue(SIG_BASE_STR)

  query_url_a <- gsub("GET&", "",URLdecode(qrbs$url))
  query_url_b <- paste(query_string, signature, sep = "&")
  query_url_c <- paste(query_url_a, query_url_b, sep = "?")

  #submit to API

  qu_res <-  getURLContent(query_url_c)

  qu_res2 <- strsplit(qu_res[1], "&")[[1]]

  splitResponse <- strsplit(qu_res2, "=")

  response <- matrix(nrow = 3, ncol = 2)
  for(i in 1:length(splitResponse)){
    response[i,1] <- splitResponse[[i]][1]
    response[i,2] <- splitResponse[[i]][[2]]
  }

  response <- data.frame(response)
  rownames(response) <- response[,1]
  response[,1] <- NULL
  names(response) <- "value"
  response$value <- as.character(response$value)
  token <- paste("oauth_token", response["oauth_token",], sep = "=")

  authURL <- paste("http://www.fatsecret.com/oauth/authorize", token, sep = "?")

  response[4,1] <- NA
  response[4,1] <- authURL
  rownames(response) <- c("callback", "request_token", "token_secret", "request_url")

  return(response)
  }
