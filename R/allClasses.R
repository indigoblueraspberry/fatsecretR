#' fatsecret
#'
#' A class to store essential variables needed for making successful request to the FatSecret RESTful API
#'
#' @slot ConsumerKey character string of your FatSecret REST API Comsumer Key
#' @slot SharedSecret character string of your FatSecret REST API Shared Secret
#' @slot oauth_consumer character of the \code{oauth_consumer} parameter
#' @slot RESTURL \code{http://platform.fatsecret.com/rest/server.api}
#' @slot httpMethod \code{GET}
#' @slot signatureMethod \code{oauth_signature_method=HMAC-SHA1}
#' @slot oauthVersion \code{oauth_version=1.0}
#' @slot timestamp a character of POSIX timestamp
#' @slot nonce a randomly generated 6-digit alpha-numeric string
#' @slot methods a \code{data.frame} of currently available methods in \code{fatsecretR}
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}

setClass(Class = "fatsecret", representation = representation(
        ConsumerKey = "character",
        SharedSecret = "character",
        oauthConsumer = "character",
        RESTURL = "character",
        httpMethod = "character",
        signatureMethod = "character",
        oauthVersion = "character",
        timestamp = "character",
        nonce = "character",
        methods = "data.frame"
        )
)

#' fatsecret3L
#'
#' A class to store essential variables needed for making successful 3-Legged Authorisation requests to
#' existing FatSecret users
#'
#' @slot ConsumerKey character string of your FatSecret REST API Comsumer Key
#' @slot SharedSecret character string of your FatSecret REST API Shared Secret
#' @slot oauth_consumer character of the \code{oauth_consumer} parameter
#' @slot RequestURL \code{http://www.fatsecret.com/oauth/request_token}
#' @slot AccessURL \code{http://www.fatsecret.com/oauth/access_token}
#' @slot AuthURL \code{http://www.fatsecret.com/oauth/authorize}
#' @slot httpMethod \code{GET}
#' @slot signatureMethod \code{oauth_signature_method=HMAC-SHA1}
#' @slot oauthVersion \code{oauth_version=1.0}
#' @slot timestamp a character of POSIX timestamp
#' @slot nonce a randomly generated 6-digit alpha-numeric string
#' @slot oauth_callback the method for authentication callback. If unable to recieve URL callbacks, set to oob. Otherwise
#' \code{oauth_callback} should be the absolute URL of your callback url
#' @slot request_token a character string of the user request token generated in Step-1 of the 3-Legged Authentication process
#' @slot request_secret a character string of the user request secret generated in Step-1 of the 3-Legged Authentication process
#' @slot user_request_url an authorisation request URL
#' @slot user_token the \code{oauth_token} parameter for a user
#' @slot user_secret the \code{oauth_secret} parameter for a user
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}

setClass(Class = "fatsecret3L", representation = representation(
        ConsumerKey = "character",
        SharedSecret = "character",
        oauthConsumer = "character",
        RequestURL = "character",
        AccessURL = "character",
        AuthURL = "character",
        httpMethod = "character",
        signatureMethod = "character",
        oauthVersion = "character",
        timestamp = "character",
        nonce = "character",
        oauth_callback = "character",
        request_token = "character",
        request_secret = "character",
        user_request_url = "character",
        user_token = "character",
        user_secret = "character"
        )
)


