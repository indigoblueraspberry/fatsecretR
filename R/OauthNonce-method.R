#' oauth_nonce
#' @rdname oauth_nonce
#'
#' @description Assign a \code{oauth_nonce} parameter to the current \code{fatsecret} or \code{fatsecret3L}
#' object
#'
#' @include allGenerics.R
#' @include allClasses.R


setMethod(f = "OauthNonce", signature = "fatsecret",
          function(object){

            objectName <- as.list(match.call())$object

            rand_str <- paste(sample(c(0:9, letters, LETTERS),5, replace=TRUE),collapse="")

            object@nonce <- paste0("oauth_nonce=", rand_str)

            #assign(eval(paste(text = objectName)), object, envir = .GlobalEnv)

            return(object)

          }
)


setMethod(f = "OauthNonce", signature = "fatsecret3L",
          function(object){

            objectName <- as.list(match.call())$object

            rand_str <- paste(sample(c(0:9, letters, LETTERS),5, replace=TRUE),collapse="")

            object@nonce <- paste0("oauth_nonce=", rand_str)

            #assign(eval(paste(text = objectName)), object, envir = .GlobalEnv)

            return(object)

          }
)
