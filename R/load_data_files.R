#' Replication companion functions 1
#' @export
load_query_template <- function(fn = 'query_template'){
	paste0(collapse='\n', readLines(fn))
}

#' Replication companion functions 2
#' @export
load_instruments_file <- function(fn = 'instruments.csv'){
	read.csv(fn, header=T, sep=',', stringsAsFactors=F)[1:3]
}

