#' Parse XML result
#'
#' Parse the XML result of a successful REST API request
#'
#' @param URLresult the character output of \code{RCurl::getURLContent}
#' @param method the REST API method used
#' @return a \code{data.frame} of parsed results
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}#'
#' @export
#' @importFrom xml2 read_xml xml_find_all as_list

xmlParser <- function(URLresult, method)
  {

  xml_raw <- read_xml(URLresult)

  if(method == "getFood"){

    xml_a <- xml_find_all(xml_raw, "//d1:food")
    xml_a_list <- lapply(xml_a, as_list)

    getFood_df <- data.frame(matrix(nrow = length(xml_a_list),ncol = 4))
    names(getFood_df) <- c("food_id", "name", "type", "brand")

    for(i in seq_along(xml_a_list)){
      getFood_df[i, "food_id"] <- xml_a_list[[i]][["food_id"]]
      getFood_df[i, "name"] <- xml_a_list[[i]][["food_name"]]
      getFood_df[i, "type"] <- xml_a_list[[i]][["food_type"]]

      if(getFood_df[i, "type"] == "Generic"){
          getFood_df[i, "brand"] <- "NA"}
      if(getFood_df[i, "type"] == "Brand"){
          getFood_df[i, "brand"] <- xml_a_list[[i]][["brand_name"]]}
    }

    if(nrow(getFood_df) == 0){
      stop("...no results for search", call. = FALSE)
    }

    if(nrow(getFood_df) >= 1){
      res_df <- getFood_df
    }

  }

  if(method == "getFoodID"){

    xml_a <- xml_find_all(xml_raw, "//d1:serving")

    if(length(xml_a) == 0){stop("...Food ID not found", call. = FALSE)}

    xml_a_list <- lapply(xml_a, as_list)
    xml_unlist <- lapply(xml_a_list, function(x)(lapply(x,unlist)))
    xml_matrix <-do.call("cbind", xml_unlist)
    col_names <- as.character(xml_matrix[which(rownames(xml_matrix) == "serving_id"),1:ncol(xml_matrix)])
    colnames(xml_matrix) <- col_names
    serving_list <- xml_matrix[-which(rownames(xml_matrix) == "serving_id" | rownames(xml_matrix) == "serving_url"),]
    serving_list <- data.frame(serving_list)
    names(serving_list) <- gsub("X", "id=", names(serving_list))

    res_df <- serving_list

  }

  return(res_df)
  }




