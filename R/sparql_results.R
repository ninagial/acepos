
wikidata_sparql_query <- function(wd_codes_chr, base_url, user_agent, query_template){
	inst_l = sapply(wd_codes_chr, prepare_query, q_temp = query_template)

	ret_fetched_responses = lapply(inst_l, function(qr_i) {
				      do.call(getURL,
					      append(list(url = paste(base_url, '?', 'query', '=', gsub('\\+','%2B',qr_i), "", sep=""),
					       httpheader = c(Accept="application/json")),
					  list(useragent=user_agent))
	)
	})

	ret_parsed_responses = lapply(ret_fetched_responses, parse_json)
	ret_parsed_responses = correct_parsed_responses(ret_parsed_responses)
	ret_paths = unlist(recursive=F, sapply(ret_parsed_responses, function(x) lapply(x, function(z) z[,2])))
	list(fetched=ret_fetched_responses, parsed=ret_parsed_responses, paths=ret_paths, query = list(input_data=wd_codes_chr, base_url=base_url, query_template=query_template, user_agent=user_agent))
}

