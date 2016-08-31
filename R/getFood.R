#' Query by Food item
#'
#' Query the FatSecret database for a specific food item. The main use of this function, is to to retrieve \code{food_ids} of
#' specific foods, which can then be passed back to the API to retrive compostional information.
#'
#' @param food a string of the food item to search
#' @return a \code{data.frame} of food items and their corresponding ID's.
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export
#' @importFrom xml2 read_xml xml_find_all
#' @importFrom utils URLdecode URLencode


getFood <- function(food)
  {

  if(!is.character(food)){
    stop("...food must be a character string", call. = FALSE)
  }

  # make the query root base string (qrbs)
  qrbs <- root_base_string()


  # query string
  method <- paste("method", "foods.search", sep = "=")

  query_string2 <- paste(method,qrbs$con_key,
                        qrbs$nonce, qrbs$sig_meth, qrbs$time_stamp,
                        qrbs$version,sep = "&")

  food_item <- URLencode(food, reserved = TRUE)
  food_esc <- curlEscape(food_item)
  search_exp <- paste("search_expression", food_esc, sep = "%3D")

  en_query_string <- URLencode(query_string2, reserved = TRUE)

  en_query_string <- paste(en_query_string, search_exp, sep = "%26")

  SIG_BASE_STR <- paste(qrbs$url, en_query_string, sep = "&")

  food_param <- paste("search_expression", food_item, sep = "=")
  query_string <- paste(food_param,method,qrbs$con_key,
                        qrbs$nonce, qrbs$sig_meth, qrbs$time_stamp,
                        qrbs$version,sep = "&")

  signature <- signatureValue(SIG_BASE_STR)

  query_url_a <- gsub("GET&", "",URLdecode(qrbs$url))
  query_url_b <- paste(query_string, signature, sep = "&")
  query_url_c <- paste(query_url_a, query_url_b, sep = "?")

  #submit to API
  food_res = getURLContent(query_url_c)

  xml_a <- read_xml(food_res)

  xml_b <- xml_find_all(xml_a, "//d1:food")

  xml_list <- lapply(xml_b, as_list)

  food_df <- data.frame(matrix(nrow = length(xml_list), ncol = 4))
  names(food_df) <- c("id", "name", "type", "brand")

  for(i in seq_along(xml_list)){
    food_df[i,"id"] <- xml_list[[i]][["food_id"]]
    food_df[i,"name"] <- xml_list[[i]][["food_name"]]
    food_df[i,"type"] <- xml_list[[i]][["food_type"]]

    if(food_df[i,"type"] == "Generic"){
      food_df[i,"brand"] <- "NA"}
    if(food_df[i,"type"] == "Brand"){
      food_df[i,"brand"] <- xml_list[[i]][["brand_name"]]
    }
  }
  if(nrow(food_df) == 0){stop("...no results for search", call. = FALSE)}

  if(nrow(food_df) >= 1){
    return(food_df)
  }
}
