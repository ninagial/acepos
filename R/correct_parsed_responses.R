#' Remediate issue with Parsed Responses
#'
#' This fixes a bug, not yet located, that gives the URI's and Nodes the opposite orders,
#' so that, the first Node corresponds to the last URI, the second one to the penultimate, and so on.
#' @param parsed_responses The object resulting from list-applying `parse_json()` on endpoint's responses
#' @return data The corrected object
correct_parsed_responses <- function(parsed_responses){
	if (class(parsed_responses) != 'list') stop("Argument must be list.")
	reverse_order <- function(x_mx){
		cbind(rev(x_mx[,1]), x_mx[,2])
	}
	lapply(parsed_responses, function(x){
		       if(!length(x)) return(NA)
		       lapply(x, function(xii){
				      reverse_order(xii)
                       })
})
}
