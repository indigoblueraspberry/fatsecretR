% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/allGenerics.R, R/RequestAuthorisation-method.R
\docType{methods}
\name{RequestAuthorisation}
\alias{RequestAuthorisation}
\alias{RequestAuthorisation,fatsecret3L-method}
\title{RequestAuthorisation}
\usage{
RequestAuthorisation(object, params)

\S4method{RequestAuthorisation}{fatsecret3L}(object, params)
}
\arguments{
\item{object}{a \code{fatsecret3L} object}

\item{params}{a character specifying the callback parameter. If you can not support a \code{url} callback, then
\code{params = "oob"}. If you have a valid \code{url} to act as a callback then \code{params} should be your absolute
\code{url} address}
}
\value{
a \code{fatsecret3L} object
}
\description{
RequestAuthorisation

Generate a \code{authorisation_request_url} for a current \code{FatSecret} user, via the
3-Legged Oauth Authentication Protocol
}
\author{
Tom Wilson \email{tpw2@aber.ac.uk}
}
