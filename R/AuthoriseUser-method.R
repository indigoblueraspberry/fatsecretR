#' Authorise User
#' @rdname authUser
#'
#' @description Retrieve the \code{oauth_token} and \code{oauth_secret} following a successful 3-Legged Authentication request
#'
#' @include allGenerics.R
#' @include allClasses.R

setMethod(f = "AuthoriseUser", signature = "fatsecret3L",
          function(object, params){

            object <- TimeStamp(object)
            object <- OauthNonce(object)

            params_esc <- curlEscape(URLencode(params, reserved = TRUE))

            oauth_param_sign <- paste0("oauth_verifier", "%3D", params_esc)

            oauth_param_holder <- "oauth_verifier"

            # query string list

            query_list <- c(object@oauthConsumer,object@request_token,
                            object@nonce, object@signatureMethod,
                            object@timestamp, object@oauthVersion,
                            oauth_param_holder)

            query_string <- URLencode(as.character(paste(sort(query_list), collapse = "&")), reserved = TRUE)

            query_string <- gsub(oauth_param_holder, oauth_param_sign, query_string)

            base_string <- paste0(URLencode(object@AccessURL, reserved = TRUE), "&", query_string)
            base_string <- paste0(object@httpMethod, "&", base_string)

            signature_value <- AuthSignature(object, base_string, params = gsub("oauth_token_secret=", "", object@request_secret))

            oauth_param <- paste0("oauth_verifier", "%3D", URLencode(params, reserved = TRUE))

            base_string <- gsub(oauth_param_sign, oauth_param, base_string)

            pattern_repl <- paste0(object@httpMethod, "&", URLencode(object@AccessURL, reserved = TRUE),"&")

            baseURL <- gsub(pattern_repl, "", base_string)
            requestURL <- paste0(object@AccessURL, "?", URLdecode(baseURL), "&", signature_value)

            URLresult <- getURLContent(requestURL)

            object@user_token <- strsplit(URLresult, "&")[[1]][1]
            object@user_secret <- strsplit(URLresult, "&")[[1]][2]

            return(object)
          }
)

