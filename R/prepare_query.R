#' URL-encode queries to pass to Wikidata endpoint
#' @param instruments_chr character A vector of input strings
#' @param q_temp SPARQL query template
#' @return A single item's query
#' @details It is assumed the items here are scientific methods of investigation
#' @export
prepare_query <- function(instruments_chr, q_temp=QUERYTEMPLATE){
	end = URLencode(sprintf(q_temp, instruments_chr), reserved=T)
	end
}
