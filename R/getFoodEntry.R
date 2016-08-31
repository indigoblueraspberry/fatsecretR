#' get Food Entry
#'
#' Retrieve all food diary entries on a given date for a specified user
#'
#' @param user_token the \code{ouath_token} for the user
#' @param user_secret the \code{oauth_secret} for the user
#' @param date the date to query. The date must be in the format \emph{YYYY-MM-DD}
#' @return a list of \code{data.frames}. Each food entry is a separate element in the list; with the following \code{data.frame}
#' cotaining the serving size, description information and the nutritional breakdown of the food entry.
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#' @importFrom xml2 read_xml xml_find_all

getFoodEntry <- function(user_token, user_secret, date)
  {
  if(!is.character(date)){stop("...date must be a character string", call. = FALSE)}

  qrbs <- root_base_string()

  method <- paste("method", "food_entries.get", sep = "=")

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
  xml_a <- xml_find_all(xml_tmp, "//d1:food_entry")
  xml_list <- lapply(xml_a, as_list)
  xml_unlist <- lapply(xml_list, function(x)(lapply(x,unlist)))

  xml_dfs <- lapply(xml_unlist, data.frame)
  xml_dfs <- lapply(xml_dfs, t)

  for(i in seq_along(xml_dfs)){
    names(xml_dfs)[i] <- as.character(xml_dfs[[i]]["food_entry_id",])
  }

  if(length(xml_dfs) ==1 ){
    xml_dfs <- data.frame(xml_dfs)
    xml_dfs[,1] <- as.character(xml_dfs[,1])
    names(xml_dfs) <- gsub("X", "", names(xml_dfs))
    new_date <- POSIXdays_to_date(as.numeric(xml_dfs["date_int",1]))
    xml_dfs["date_int",1] <- gsub(xml_dfs["date_int",1], new_date, xml_dfs["date_int",1])
  }

  if(length(xml_dfs) > 1){

    new_dates <- NULL
    for(i in seq_along(xml_dfs)){
      new_dates[[i]] <- POSIXdays_to_date(as.numeric(xml_dfs[[i]]["date_int",][[1]]))
    }

    new_dates <- as.character(lapply(xml_dfs, function(x){
      POSIXdays_to_date(as.numeric(x["date_int",][[1]]))
    }))

    for(i in seq_along(xml_dfs)){
      xml_dfs[[i]][["date_int",1]] <- gsub(xml_dfs[[i]][["date_int",1]], new_dates[i], xml_dfs[[i]][["date_int",1]])
    }
  }

  return(xml_dfs)
  }
