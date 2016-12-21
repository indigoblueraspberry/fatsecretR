#' fatsecretR REST API
#' @rdname fatsecretRmethod
#'
#' @description Main worker method for all REST API calls
#'
#' @include allGenerics.R
#' @include allClasses.R

setMethod(f = "fatsecretR", signature = "fatsecret",
          function(object, method, param, user_token = NULL, user_secret = NULL){

            methodName <- as.list(match.call())$method
            objectName <- as.list(match.call())$object

            object <- TimeStamp(object)
            object <- OauthNonce(object)

            methodInd <- match(methodName, object@methods[["RESTful"]])

            RESTmethod <- paste0("method=", object@methods[["method"]][methodInd])


            if(object@methods[["oauth_param"]][methodInd] == "date"){
              param <- paste0("date=", as.numeric(as.Date(param)))
            }else{
              param <- paste0(object@methods[["oauth_param"]][methodInd], "=", param)

            }

            if(!is.null(user_token)){

              user_token <- paste0("oauth_token=", user_token)

            }



            query_list <- c(RESTmethod, object@oauthConsumer,
                            object@nonce, object@signatureMethod,
                            object@timestamp, object@oauthVersion,
                            param, user_token)


            query_string <- URLencode(as.character(paste(sort(query_list), collapse = "&")), reserved = TRUE)
            query_string <- gsub("%2B", "%2520", query_string)

            base_string <- paste0(URLencode(object@RESTURL, reserved = TRUE), "&", query_string)
            base_string <- paste0(object@httpMethod, "&", base_string)



            if(object@methods[["signature"]][methodInd] == 1){
              signature_value <- AuthSignature(object, base_string)
            }

            if(object@methods[["signature"]][methodInd] == 2){
              signature_value <- AuthSignature(object, base_string, params = user_secret)
            }

            pattern_repl <- paste0(object@httpMethod, "&", URLencode(object@RESTURL, reserved = TRUE),"&")

            baseURL <- gsub(pattern_repl, "", base_string)

            requestURL <- paste0(
              object@RESTURL, "?",URLdecode(baseURL), "&", signature_value)

            URLresult <- getURLContent(requestURL)

            URLclean <- xmlParser(URLresult, method = methodName)

          return(URLclean)

          }

)

