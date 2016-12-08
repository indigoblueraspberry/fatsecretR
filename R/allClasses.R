#'
#'
#'
#'
#'
#'
#'
#'
#'
#'

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
        oauthSignature = "character",
        methods = "data.frame"
        )
)



setClass(Class = "fatsecret3L", representation = representation(
        ConsumerKey = "character",
        SharedSecret = "character",
        oauthConsumer = "character",
        RequestURL = "character",
        AccessURL = "character",
        AuthURL = "character",
        ReqURL = "character",
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
        user_secret = "character",
        callback_verifier = "character"
        )
)


