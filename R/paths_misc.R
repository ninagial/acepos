#' path helper functions (1)
#' @export
	# Follow the path from each seed 
parent_term <- function(parsed_responses, level=11){
	lapply(all_parsed_responses, function(x) sapply(x, function(y) y[level,2]))
}

#' Replication companion functions 2
#' @export
superclass_distribution <- function(parsed_responses, level=11){
	# this tabulates the result of `parent_from_seed` to see from each seed word which is the most common superclass and gives an idea of where it is better to class it
	ret0 = lapply(parent_term(parsed_responses, level), function(x) try(table(x)))
	ret0[sapply(ret0, class)!="try-error"]
}

#' Replication companion functions 3
#' @export
term_hierarchy <- function(parsed_responses){
	lapply(seq_len(11), function(lvl_i) parent_term(parsed_responses, level=lvl_i))
}

