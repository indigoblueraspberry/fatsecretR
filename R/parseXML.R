#' Parse XML
#'
#' Parse the \code{http GET} request from \code{XML} into a readable matrix
#'
#' @param URLreq the XML outout from a http GET requst
#'
#' @return parsed XML file
#'
#' @author Tom Wilson \code{tpw2@@aber.ac.uk}
#' @keywords internal

parseXML <- function(URLreq)
  {
  res_parse <- xmlTreeParse(URLreq)
  res_root <- xmlRoot(res_parse)
  res_values <- xmlSApply(res_root, function(x) xmlSApply(x, xmlValue))
  return(res_values)
  }
