#' oauth_timestamp
#' @rdname oauth_timestamp
#'
#' @description Assign a \code{oauth_timestamp} parameter to the current \code{fatsecret} or \code{fatsecret3L}
#' object
#'
#' @include allGenerics.R
#' @include allClasses.R


setMethod(f = "TimeStamp", signature("fatsecret"),
          function(object){

            objectName <- as.list(match.call())$object

            object@timestamp <- paste0("oauth_timestamp=", as.integer(as.POSIXct(Sys.time()), "GMT"))

            #assign(eval(paste(text = objectName)), object, envir = .GlobalEnv)

            return(object)

          }
)

#' oauth_timestamp
#' @rdname oauth_timestamp
#'
#' @include allGenerics.R
#' @include allClasses.R


setMethod(f = "TimeStamp", signature("fatsecret3L"),
          function(object){

            objectName <- as.list(match.call())$object

            object@timestamp <- paste0("oauth_timestamp=", as.integer(as.POSIXct(Sys.time()), "GMT"))

            #assign(eval(paste(text = objectName)), object, envir = .GlobalEnv)

            return(object)

          }
)
