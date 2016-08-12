#' User Profile
#'
#' Retrieve profile information
#'
#' @param user_token the \code{ouath_token} for the user
#' @param user_secret the \code{oauth_secret} for the user
#' @return a \code{data.frame} containing values for current weight and height measurments
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

  xml_tmp <- read_xml(prof_res)

  xml_node <- xml_find_all(xml_tmp, "//d1:profile")

  xml_a <- xml_children(xml_node)

  xml_list <- as_list(xml_a)

  xml_df <- data.frame(matrix(nrow = length(xml_list), ncol = 2))

  for(i in seq_along(xml_list)){
    xml_df[i,1] <- xml_name(xml_list[[i]])
    xml_df[i,2] <- xml_text(xml_list[[i]])
    }

  colnames(xml_df) <- c("name", "value")

  return(xml_df)
  }


