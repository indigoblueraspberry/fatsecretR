#' getFoodParse
#'
#' Parse the \code{getFoodID} \code{http GET} request from \code{XML} into a readable matrix
#'
#' @param URLreq the XML output from a \code{getFoodID} http GET requst
#' @return a parsed XML file
#'
#' @author Tom Wilson \code{tpw2@@aber.ac.uk}
#' @export

getFoodParse <- function(URLreq)
  {
  res_parse <- xmlTreeParse(URLreq)
  res_root <- xmlRoot(res_parse)
  serving <- res_root["servings"]$servings
  res_values <- xmlSApply(serving, function(x) xmlSApply(x, xmlValue))
  return(res_values)
  }
