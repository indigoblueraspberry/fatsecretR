#' get Food Entry Month
#'
#' Returns summary daily nutritional information for a user's food diary entries for the month specified.
#'
#' @param user_token the \code{ouath_token} for the user
#' @param user_secret the \code{oauth_secret} for the user
#' @param date the date to query. The date must be in the format \emph{YYYY-MM-DD}
#' @return a \code{data.frame} with calories, carbohydrate, protein and fat for each day in the month that there has
#' been a food entry
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

getFoodEntryMonth <- function(user_token, user_secret, date)
{
  if(!is.character(date)){stop("...date must be a character string", call. = FALSE)}

  qrbs <- root_base_string()

  method <- paste("method", "food_entries.get_month", sep = "=")

  date_posix <- as.numeric(as.Date(date))

  search_exp <- paste("date", date_posix, sep = "=")
  token <- paste("oauth_token", user_token, sep = "=")

  # build entire query string
  query_string <- paste(search_exp,method,qrbs$con_key,
                        qrbs$nonce, qrbs$sig_meth, qrbs$time_stamp,
                        token,qrbs$version,sep = "&")

  en_query_string <- URLencode(query_string, reserved = TRUE)

  SIG_BASE_STR <- paste(qrbs$url, en_query_string, sep = "&")

  # now make signature value

  signature <- signatureValueUser(SIG_BASE_STR, getOption("SHARED_SECRET"),user_secret)

  query_url_a <- gsub("GET&", "",URLdecode(qrbs$url))
  query_url_b <- paste(query_string, signature, sep = "&")
  query_url_c <- paste(query_url_a, query_url_b, sep = "?")

  prof_res = getURLContent(query_url_c)
  xml_tmp <- read_xml(prof_res)
  xml_a <- xml_find_all(xml_tmp, "//d1:day")
  xml_list <- lapply(xml_a, as_list)

  monthly_df <- data.frame(matrix(nrow = length(xml_list), ncol = 5))

  names(monthly_df) <- c("date", "calories", "carbohydrate", "protein", "fat")

  for(i in seq_along(xml_list)){
    monthly_df[i,"date"] <- as.numeric(xml_list[[i]][["date_int"]][[1]])
    monthly_df[i,"calories"] <- as.numeric(xml_list[[i]][["calories"]][[1]])
    monthly_df[i,"carbohydrate"] <- as.numeric(xml_list[[i]][["carbohydrate"]][[1]])
    monthly_df[i,"protein"] <- as.numeric(xml_list[[i]][["protein"]][[1]])
    monthly_df[i,"fat"] <- as.numeric(xml_list[[i]][["fat"]][[1]])
  }

  monthly_total <- apply(monthly_df,2,sum)
  monthly_total["date"] <- "total"
  monthly_df <- rbind(monthly_df,monthly_total)

  return(monthly_df)
  }
