#' Construct a data.frame with aggregate study data
#'
#' @param graph_obj iGraph The object returned in `paths_to_graph(...)@graph@g`)
#' @param analysis_obj The object returned by `wikidata_analysis()`
#' @param parsed_responses The result of `parse_json()` list-applied to all responses
#' @param instruments_df data.frame of seed terms and Wikidata codes, like RAWINSTRUMENTS
#' @export
aggregate_path_metrics <- function(graph_obj, analysis_obj, parsed_responses, instruments_df){
	# Construct a df which later to easily merge over a lapply loop
	wd_metrics <- data.frame(Node=graph_obj@nodes, 
				 Degree=analysis_obj$metrics$g_deg, 
				 Betweenness=analysis_obj$metrics$g_betw)
	paths_ls <- lapply(
			   # Use data from each of the seed terms (each might have 0 or > 1 paths)
			   seq_along(parsed_responses), 
			   function(x) {
				   lapply(seq_along(parsed_responses[[x]]), 
					  function(xii){
						  # Use data from each one of the possible paths
						  if(length(parsed_responses[[x]][[xii]]) < 2) return(NA)
						  try({
							  # data frame helps add columns succintly
							  y=data.frame(parsed_responses[[x]][[xii]])
							  colnames(y)=c('URI', 'Node')
							  # track which term and which path we're in
							  y$Path=xii
							  y$Term=x
							  # tether the metrics to original dataset
							  y$TermWD=instruments_df[x,3]
							  y$TermStr=instruments_df[x,1]
							  # order is reversed
							  y$Level=seq(11,1)
							  # actual merge with node's graph-wide metrics
							  merge(y, wd_metrics)
					  }) # try
					  }) # inner lapply
			   }) 
	# Flatten the nested data into a big matrix
	ret_data <- Reduce(rbind, lapply(seq_along(paths_ls), function(ii) Reduce(rbind, paths_ls[[ii]])))
	# Sort by degree and flatten into matrix, as above (just an example)
	top_degree <- Reduce(rbind, lapply(split(ret_data, list(ret_data$Term, ret_data$Level)), function(x) x[which.max(x$Degree),]))
	# return
	list(data = ret_data, 
	     metrics_df = wd_metrics, 
	     top = top_degree, 
	     paths_ls=paths_ls, 
	     instruments_df=instruments_df, 
	     graph=graph_obj, 
	     analysis=analysis_obj)
}
