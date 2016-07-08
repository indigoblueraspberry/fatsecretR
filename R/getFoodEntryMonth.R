#' get Food Entry Month
#'
#' Returns summary daily nutritional information for a user's food diary entries for the month specified.
#'
#' @param user_toker the \code{ouath_token} for the user
#' @param user_secret the \code{oauth_secret} for the user
#' @param date the date to query. The date must be in the format \emph{YYYY-MM-DD}
#' @return a list of two elements
#'  \itemize{
#'    \item {dates} the start and end date of the search
#'    \item {summary} a \code{data.frame} summary of nutritional intake for the month
#'  }
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

  prof_res <- parseXML(prof_res)

  start_date <- as.numeric(prof_res$from_date_int)
  end_date <- as.numeric(prof_res$to_date_int)

  prof_tmp <- prof_res
  prof_tmp$from_date_int <- NULL
  prof_tmp$to_date_int <- NULL

  res_day <- plyr::ldply(prof_tmp, id = date_int)
  res_day$.id <- NULL

  res_all <- list()
  res_all$dates <- c(start_date,end_date)
  res_all$summary <- res_day
  return(res_all)
  }


