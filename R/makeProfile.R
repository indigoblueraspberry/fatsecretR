#' Create a user profile
#'
#' Create a user profile which a specific user ID and retrieve the \code{oauth_token} and \code{access_secret}
#' for the user. The tokens do not need to be saved, as providing a user_id string is specified,
#' then tokens can be retrieved at any time using \code{getAuth}
#'
#' @param user_id a unique identifier for the new profile
#' @return a \code{data.frame} cotnaining the user token and access secret for the created profile
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

  xml_tmp <- read_xml(profile_res)
  xml_list <- as_list(xml_children(xml_tmp))

  prof_name <- lapply(xml_list, xml_name)
  prof_value <- lapply(xml_list, xml_text)

  prof_df <- data.frame(name = unlist(prof_name), value = unlist(prof_value))
  prof_df[,"name"] <- gsub("auth_", "", prof_df[,"name"])

  return(prof_df)
  }
