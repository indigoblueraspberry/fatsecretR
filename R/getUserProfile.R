#' User Profile
#'
#' Retrieve profile information
#'
#' @param user_id the profile id used during \code{makeProfile}
#' @return the last recorded weight measure and current height measure
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

getUserProfile <- function(user_token, user_secret)
{
  qrbs <- root_base_string()

  method <- paste("method", "profile.get", sep = "=")
  search_exp <- paste("oauth_token", user_token, sep = "=")

  # build entire query string
  query_string <- paste(method,qrbs$con_key,
                        qrbs$nonce, qrbs$sig_meth, qrbs$time_stamp,
                        search_exp,qrbs$version,sep = "&")

  en_query_string <- URLencode(query_string, reserved = TRUE)

  SIG_BASE_STR <- paste(qrbs$url, en_query_string, sep = "&")

  # now make signature value

  signature <- signatureValueUser(SIG_BASE_STR, getOption("SHARED_SECRET"),user_secret)

  query_url_a <- gsub("GET&", "",URLdecode(qrbs$url))
  query_url_b <- paste(query_string, signature, sep = "&")
  query_url_c <- paste(query_url_a, query_url_b, sep = "?")

  prof_res = getURLContent(query_url_c)

  prof_res <- parseXML(prof_res)

  df <- data.frame(prof_res)

  last_weight <- paste(df$prof_res[3], df$prof_res[1], sep = " ")
  height <- paste(df$prof_res[6], df$prof_res[2], sep = " ")

  df_names <- c("last_weight", "current_height")
  df_value <- c(last_weight, height)
  prof_df <- data.frame(cbind(df_names,df_value))

  return(prof_df)
  }


