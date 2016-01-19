#' Query by Food item
#'
#' Query the FatSecret database for a specific food item. The main use of this function, is to to retrieve \code{food_ids} of
#' specific foods, which can then be passed back to the API to retrive compostional information.
#'
#' @param food A string of the food item to search
#' @return A \code{data.frame} of food items and their corresponding ID's.
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

getFood <- function(food)
  {

  if(!is.character(food)){
    stop("...food must be a character string", call. = FALSE)
  }

  # make the query root base string (qrbs)
  qrbs <- root_base_string()


  # query string
  method <- paste("method", "foods.search", sep = "=")
  search_exp <- paste("search_expression", food, sep = "=")


  # build entire query string
  query_string <- paste(method,qrbs$con_key,
                        qrbs$nonce, qrbs$sig_meth, qrbs$time_stamp,
                        qrbs$version, search_exp,sep = "&")


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

  idx <- which(names(food_parse) == "food")

  food_list <- food_parse[idx]

  food_list <- lapply(food_list, t)
  food_list <- lapply(food_list, data.frame)

  food_matrix <- data.frame(matrix(nrow = length(food_list), ncol = 4))
  for(i in 1:length(food_list)){
    food_matrix[i,1] <- as.character(food_list[[i]]$food_id)
    food_matrix[i,2] <- as.character(food_list[[i]]$food_name)
    food_matrix[i,3] <- as.character(food_list[[i]]$food_type)
    if(food_matrix[i,3] == "Brand"){
        food_matrix[i,4] <- as.character(food_list[[i]]$brand_name)
    }
  }
  colnames(food_matrix) <- c("ID", "Name", "Type", "Brand")

  return(food_matrix)
  }










