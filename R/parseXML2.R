#' Parse XML
#'
#' Parse the \code{getFoodID} \code{http GET} request from \code{XML} into a readable matrix
#'
#' @param URLreq The XML outout from a \code{getFoodID} http GET requst
#'
#' @return Parsed XML file
#'
#' @author Tom Wilson \code{tpw2@@aber.ac.uk}
#' @export

parseXML2 <- function(URLreq)
  {
  res_parse <- xmlTreeParse(URLreq)
  res_root <- xmlRoot(res_parse)
  serving <- res_root["servings"]$servings
  res_values <- xmlSApply(serving, function(x) xmlSApply(x, xmlValue))
  return(res_values)
  }
