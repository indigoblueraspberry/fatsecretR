#' Query by Food ID
#'
#' Query the FatSecret database for a specific food item using the database ID.
#'
#' @param food_id a numeric value which corresponds to a valid FatSecret database entry
#' @return a list of two elements
#'  \itemize{
#'    \item{id} the food descriptor information
#'    \item{servings} the nutritional breakdown of the food by servings
#'  }
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

getFoodID <- function(food_id)
  {
  if(!is.numeric(food_id)){
    stop("...food_id must be numeric", call. = FALSE)
  }

  # make the query root base string (qrbs)
  qrbs <- root_base_string()

  # query string
  method <- paste("method", "food.get", sep = "=")
  search_exp <- paste("food_id", food_id, sep = "=")


  # build entire query string
  query_string <- paste(search_exp,method,qrbs$con_key,
                        qrbs$nonce, qrbs$sig_meth, qrbs$time_stamp,
                        qrbs$version,sep = "&")


  en_query_string <- URLencode(query_string, reserved = TRUE)

  SIG_BASE_STR <- paste(qrbs$url, en_query_string, sep = "&")

  # now make signature value

  signature <- signatureValue(SIG_BASE_STR)

  query_url_a <- gsub("GET&", "",URLdecode(qrbs$url))
  query_url_b <- paste(query_string, signature, sep = "&")
  query_url_c <- paste(query_url_a, query_url_b, sep = "?")

  #submit to API

  food_res = getURLContent(query_url_c)

  food_parse <- parseXML(food_res)

  food_mat <- t(as.matrix(food_parse))
  food_df <- data.frame(food_mat)

  food_df$food_url.text <- food_df$servings.serving <- NULL

  food_df <- t(food_df)

  nut_val <- parseXML2(food_res)

  food_list <- list(food_df, nut_val)
  names(food_list) <- c("id", "servings")

  return(food_list)
  }
