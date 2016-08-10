#' Query database by Food ID
#'
#' Query the FatSecret database for a specific food item using the database ID.
#'
#' @param food_id a numeric value which corresponds to a valid FatSecret database entry
#' @return a matrix of nutritonal information for all of the available serving sizes

#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

getFoodID <- function(food_id)
  {
  if(!is.numeric(food_id)){stop("...food_id must be numeric", call. = FALSE)}

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

  food_res <-  getURLContent(query_url_c)

  xml_a <- read_xml(food_res)
  xml_b <- xml_find_all(xml_a, "//d1:serving")

  if(length(xml_b) == 0){stop("...Food ID not found", call. = FALSE)}

  xml_list <- lapply(xml_b, as_list)
  xml_unlist <- lapply(xml_list, function(x)(lapply(x,unlist)))
  xml_matrix <-do.call("cbind", xml_unlist)
  col_names <- as.character(xml_matrix[which(rownames(xml_matrix) == "serving_id"),1:ncol(xml_matrix)])
  colnames(xml_matrix) <- col_names
  serving_list <- xml_matrix[-which(rownames(xml_matrix) == "serving_id" | rownames(xml_matrix) == "serving_url"),]

  return(serving_list)
  }
