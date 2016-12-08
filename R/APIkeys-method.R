#' Add API Keys
#' @rdname apiKeys
#'
#' @description Add your private API keys to the \code{fatsecret} object
#'
#' @include allGenerics.R
#' @include allClasses.R



setMethod(f = "APIkeys", signature = "fatsecret",
          function(object, ConsumerKey, SharedSecret){

            objectName <- as.list(match.call())$object

            if(!is.character(ConsumerKey)){
              stop("...API ConsumerKey must be a character")
            }
            if(!is.character(SharedSecret)){
              stop("...API SharedSecret must be a character")
            }
            object@ConsumerKey <- ConsumerKey
            object@SharedSecret <- SharedSecret

            object@oauthConsumer <- paste0("oauth_consumer_key=", ConsumerKey)

            assign(eval(paste(text = objectName)), object, envir = .GlobalEnv)

            return(invisible(NULL))

          }
)
