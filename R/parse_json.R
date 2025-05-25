#' Parse the JSON response of the Wikidata request
#' @export
parse_json <- function(res){
	res = fromJSON(res)$results$bindings
	lapply(res, function(x) matrix(ncol=2, byrow=F, sapply(x, function(z) z['value'])))
}

