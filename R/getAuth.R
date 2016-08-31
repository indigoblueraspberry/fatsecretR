#' Get Authentication
#'
#' Retrive the \code{ouath_token} and \code{oauth_secret} for a profile created using \code{makeProfile}
#'
#' @param user_id the user_id for the profile to query
#' @return a \code{data.frame} containing the \code{ouath_token} and \code{oauth_secret} for the specified \code{user_id}
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#' @importFrom xml2 read_xml as_list xml_name xml_text xml_children

getAuth <- function(user_id)
  {
  if(!is.character(user_id)){stop("...user_id must be a character string", call. = FALSE)}
  qrbs <- root_base_string()

  method <- paste("method", "profile.get_auth", sep = "=")
  search_exp <- paste("user_id", user_id, sep = "=")

  query_string <- paste(method,qrbs$con_key,
                        qrbs$nonce, qrbs$sig_meth, qrbs$time_stamp,
                        qrbs$version,search_exp,sep = "&")

  en_query_string <- URLencode(query_string, reserved = TRUE)

  SIG_BASE_STR <- paste(qrbs$url, en_query_string, sep = "&")

  # now make signature value

  signature <- signatureValue(SIG_BASE_STR)

  query_url_a <- gsub("GET&", "",URLdecode(qrbs$url))
  query_url_b <- paste(query_string, signature, sep = "&")
  query_url_c <- paste(query_url_a, query_url_b, sep = "?")


  #submit to API

  qu_res <-  getURLContent(query_url_c)

  xml_tmp <- read_xml(qu_res)
  xml_list <- as_list(xml_children(xml_tmp))

  qu_name <- lapply(xml_list, xml_name)
  qu_value <- lapply(xml_list, xml_text)

  qu_df <- data.frame(name = unlist(qu_name), value = unlist(qu_value))
  qu_df[,"name"] <- as.character(qu_df[,"name"])
  qu_df[,"value"] <- as.character(qu_df[,"value"])

  qu_df[,"name"] <- gsub("auth_", "", qu_df[,"name"])
  qu_df[,"name"] <- paste("oath", qu_df[,"name"], sep = "_")

  return(qu_df)
  }
