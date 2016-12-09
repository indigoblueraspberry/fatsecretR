#' oauth_timestamp
#' @rdname oauth_timestamp
#' @param object a \code{fatsecret} or \code{fatsecret3L} object
#' @return a \code{fatsecret} or \code{fatsecret3L} object
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

setGeneric(name = "TimeStamp",
           def = function(object)
           {standardGeneric("TimeStamp")}
)


#' oauth_nonce
#' @rdname oauth_nonce
#' @param object a \code{fatsecret} or \code{fatsecret3L} object
#' @return a \code{fatsecret} or \code{fatsecret3L} object
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

setGeneric(name = "OauthNonce",
           def = function(object)
           {standardGeneric("OauthNonce")}
)

#' RequestAuthorisation
#' @rdname requestAuthorisation
#' @param object a \code{fatsecret3L} object
#' @param params a character specifying the callback parameter. If you can not support a \code{url} callback, then
#' \code{params = "oob"}. If you have a valid \code{url} to act as a callback then \code{params} should be your absolute
#' \code{url} address
#' @return a \code{fatsecret3L} object
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

setGeneric(name = "RequestAuthorisation",
           def = function(object,params)
          {standardGeneric("RequestAuthorisation")}
)

#' Add API Keys
#' @rdname apiKeys
#' @param object a \code{fatsecret} or \code{fatsecret3L} object
#' @param ConsumerKey a character of your FatSecret REST API Consumer Key
#' @param SharedSecret a character of your FatSecret REST API Shared Secret
#' @return a \code{fatsecret} or \code{fatsecret3L} object
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

setGeneric(name = "APIkeys",
           def = function(object, ConsumerKey, SharedSecret)
           {standardGeneric("APIkeys")}
)


#' fatsecretR REST API
#' @rdname fatsecretRmethod
#' @param object a \code{fatsecret} object
#' @param method a character specifying a REST API method
#' @param params a character specifying parameters which correspond to the selected method
#' @return a \code{data.frame}
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

setGeneric(name = "fatsecretR",
           def = function(object,method,params)
           {standardGeneric("fatsecretR")}
)


#' Authorise User
#' @rdname authUser
#' @param object a \code{fatsecret3L} object
#' @param params a character of the verification code (\code{oauth_verifier})
#' @return a \code{fatsecret3L} object with a valid \code{oauth_token} and \code{oauth_secret} for the user
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

setGeneric(name = "fatsecretR",
           def = function(object,method,params)
           {standardGeneric("fatsecretR")}
)


