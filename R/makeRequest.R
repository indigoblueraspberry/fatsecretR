#' Make Authorisation Request (3LeggedAuth - Step 1)
#'
#' Retrive the \code{ouath_token} and \code{oauth_secret} from Step 1 of 3 Legged OAuth1.0 Authentication and create a \code{Authorisation URL} which can
#' be forwarded to a active user.
#'
#' @param callback a charatcer string for the `oauth_callback`. If unable to recieve a callback, then \code{callback} must be
#' set to \emph{oob}, otherwise \code{callback} should equal the absolute url (\code{protocol://domain/path}) of your callback
#' @return a list of two elements
#'  \itemize{
#'    \item {tokens} a vector containing the \code{oauth_token}(request_token) and the \code{oauth_secret}(request _secret) of the authorisation request
#'    \item {authorisation_url} a character string of the Authorisaton URL which should be forward to a user in order to grant authorisation
#'  }
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#' @importFrom RCurl curlEscape getURLContent url.exists
#'

makeRequest <- function(callback = "oob")
  {

  qrbs <- root_base_string3L(CONSUMER_KEY = getOption("CONSUMER_KEY"), url = "http://www.fatsecret.com/oauth/request_token",
                             params = paste("oauth_callback", callback, sep = "="))


  if(callback == "oob"){
  query_string <- paste(qrbs$params,qrbs$con_key,qrbs$nonce,qrbs$sig_meth,
                        qrbs$time_stamp,qrbs$version, sep = "&")

  en_query_string <- URLencode(query_string, reserved = TRUE)
  }

  if(callback != "oob"){

    if(url.exists(callback) == FALSE){
      stop("...the callback URL does not exisit, please supply a valid absolute URL", call. = FALSE)
    }

    query_string2 <- paste(qrbs$con_key,qrbs$nonce,qrbs$sig_meth,
                          qrbs$time_stamp,qrbs$version, sep = "&")

    query_string <- paste(qrbs$params,qrbs$con_key,qrbs$nonce,qrbs$sig_meth,
                           qrbs$time_stamp,qrbs$version, sep = "&")

    en_query_string <- URLencode(query_string2, reserved = TRUE)

    # escape the encoded callback url
    callback_url <- curlEscape(URLencode(callback, reserved = TRUE))
    oauth_callback <- paste("oauth_callback", callback_url, sep = "%3D")
    en_query_string  <- paste(oauth_callback, en_query_string, sep = "%26")
  }

  SIG_BASE_STR <- paste(qrbs$url, en_query_string, sep = "&")

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

  oauth_token <- paste("oauth_token", as.character(response[2,1]), sep = "=")
  authURL <- paste("http://www.fatsecret.com/oauth/authorize", as.character(oauth_token), sep = "?")
  response_list <- list(tokens = c(request_token = as.character(response[2,1]), request_secret = as.character(response[3,1])), authorisation_url = authURL)

  return(response_list)
  }
