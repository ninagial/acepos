% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/correct_parsed_responses.R
\name{correct_parsed_responses}
\alias{correct_parsed_responses}
\title{Remediate issue with Parsed Responses}
\usage{
correct_parsed_responses(parsed_responses)
}
\arguments{
\item{parsed_responses}{The object resulting from list-applying \code{parse_json()} on endpoint's responses}
}
\value{
data The corrected object
}
\description{
This fixes a bug, not yet located, that gives the URI's and Nodes the opposite orders,
so that, the first Node corresponds to the last URI, the second one to the penultimate, and so on.
}
