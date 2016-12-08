#' fatsecretR REST API
#' @rdname fatsecretRmethod
#'
#' @description Main worker method for all REST API calls
#'
#' @include allGenerics.R
#' @include allClasses.R

setMethod(f = "fatsecretR", signature = "fatsecret",
          function(object, method, params){

            methodName <- as.list(match.call())$method
            objectName <- as.list(match.call())$object

            object <- TimeStamp(object)
            object <- OauthNonce(object)

            methodInd <- match(methodName, object@methods[["RESTful"]])

            RESTmethod <- paste0("method=", object@methods[["method"]][methodInd])

            params_esc <- curlEscape(URLencode(params, reserved = TRUE))

            oauth_param_sign <- paste0(object@methods[["oauth_param"]][methodInd], "%3D", params_esc)

            oauth_param_holder <- object@methods[["oauth_param"]][methodInd]

            # query string list

            query_list <- c(RESTmethod, object@oauthConsumer,
                            object@nonce, object@signatureMethod,
                            object@timestamp, object@oauthVersion,
                            oauth_param_holder)


            query_string <- URLencode(as.character(paste(sort(query_list), collapse = "&")), reserved = TRUE)


            query_string <- gsub(oauth_param_holder, oauth_param_sign, query_string)
            base_string <- paste0(object@RESTURLenc, "&", query_string)
            signature_value <- AuthSignature(object, base_string)
            oauth_param <- paste0(object@methods[["oauth_param"]][methodInd], "%3D", URLencode(params, reserved = TRUE))

            base_string <- gsub(oauth_param_sign, oauth_param, base_string)
            baseURL <- gsub(paste0(object@RESTURLenc,"&"), "", base_string)

            baseURL <- gsub(paste0("%26", oauth_param),"", baseURL)
            baseURL <- gsub(paste0(oauth_param,"%26"),"", baseURL)

            param_final <- paste0(oauth_param_holder, "=", strsplit(oauth_param, "%3D")[[1]][2])

            requestURL <- paste0(
              object@RESTURL, "?", param_final, "&", URLdecode(baseURL), "&", signature_value)

            URLresult <- getURLContent(requestURL)

          }

)

