#' show-fatsecret
#' @rdname show
#'
#' @param object a fatsecret object
#' @return NULL
#'
#' @author Tom Wilsn \email{tpw2@@aber.ac.uk}
#' @export
#' @importFrom methods show
#'

setMethod("show", signature = "fatsecret",
            function(object){

          cat("fatsecret S4 object", "\n", "\n")
          cat("For more details, please visit https://github.com/wilsontom/fatsecretR/wiki", "\n", "\n")

          if(length(object@ConsumerKey) == 0){
            cat("No API ConsumerKey has been added yet")
          }else{
            cat("API ConsumerKey available")
          }
          cat("\n","\n")

          if(length(object@SharedSecret) == 0){
            cat("No API SharedSecret has been added yet")
          }else{
            cat("API SharedSecret available")
          }
          cat("\n","\n")

          cat("Last timestamp:", "\n")
          if(length(object@timestamp) == 0){
            cat("no timestamp available")
          }else{
            tx <- as.numeric(gsub("oauth_timestamp=", "", object@timestamp))
            ts <- as.POSIXct(tx, origin = "1970-01-01")
            cat(as.character(ts), "\n")
          }

    }
)


