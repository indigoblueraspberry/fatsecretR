#' Request Authorisation
#' @rdname requestAuthorisation
#'
#' @description Generate a \code{authorisation_request_url} for a current \code{FatSecret} user, via the
#' 3-Legged Oauth Authentication Protocol
#'
#' @include allGenerics.R
#' @include allClasses.R


setMethod(f = "RequestAuthorisation", signature = "fatsecret3L",
          function(object, params){

            object <- TimeStamp(object)
            object <- OauthNonce(object)

            params_esc <- curlEscape(URLencode(params, reserved = TRUE))

            oauth_param_sign <- paste0("oauth_callback", "%3D", params_esc)

            oauth_param_holder <- "oauth_callback"

            # query string list

            query_list <- c(object@ConsumerKey,
                            object@nonce, object@signatureMethod,
                            object@timestamp, object@oauthVersion,
                            oauth_param_holder)

            query_string <- URLencode(as.character(paste(sort(query_list), collapse = "&")), reserved = TRUE)

            query_string <- gsub(oauth_param_holder, oauth_param_sign, query_string)

            base_string <- paste0(URLencode(object@RequestURL, reserved = TRUE), "&", query_string)
            base_string <- paste0(object@httpMethod, "&", base_string)

            signature_value <- AuthSignature(object, base_string)

            oauth_param <- paste0("oauth_callback", "%3D", URLencode(params, reserved = TRUE))

            base_string <- gsub(oauth_param_sign, oauth_param, base_string)

            pattern_repl <- paste0(object@httpMethod, "&", URLencode(object@RequestURL, reserved = TRUE),"&")

            baseURL <- gsub(pattern_repl, "", base_string)
            baseURL <- gsub(paste0("%26", oauth_param),"", baseURL)
            baseURL <- gsub(paste0(oauth_param,"%26"),"", baseURL)

            param_final <- paste0(oauth_param_holder, "=", strsplit(oauth_param, "%3D")[[1]][2])

            requestURL <- paste0(
              object@RequestURL, "?", param_final, "&", URLdecode(baseURL), "&", signature_value)

            URLresult <- getURLContent(requestURL)

            object@request_token <- strsplit(URLresult, "&")[[1]][2]
            object@request_secret <- strsplit(URLresult, "&")[[1]][3]

            object@user_request_url <- paste0(object@AuthURL,"?", object@request_token)


            return(object)
          }

)

