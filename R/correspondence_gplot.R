#' Plot Correspondence Analysis
#'
#' @param unified_data_object The object created by `aggregate_path_metrics()`
#' @return data data.frame linking node names with wikidata codes and CA row coordinates
#' @return ca_obj The result of ca::ca()
#' @return ca_plot_obj The object created by ca::plot.ca()
#' @return index An index linking node names to wikidata codes, without the whole URI
#' @return ca_row_coord CA row coordinates
#' @return ca_col_coord CA col coordinates
#' @return plotly_rows Row coordinates used in plotly (labels, jittered)
#' @return plotly_cols Column coordinates used in plotly (labels, jittered)
#' @export
ca_gplot <- function(unified_data_obj){
	require(dplyr)
	require(magrittr)
	require(plotly)
	uri_code_only <- with(unified_data_obj, gsub("^.+/", "", data$URI))
	ca1 <- ca(with(unified_data_obj, table(uri_code_only, data$Level)))
	ca1pl <- plot(ca1) # thanks https://www.r-bloggers.com/2019/08/correspondence-analysis-visualization-using-ggplot/
	node_index <- with(unified_data_obj, data.frame(Node=data$Node, WdCode=gsub("^.+/", "", data$URI), Degree=data$Degree))
	node_index <- node_index[!duplicated(node_index$WdCode),]
	ca_row_coord_df <- data.frame(node1=rownames(ca1pl$rows), d1=ca1pl$rows[,1], d2=ca1pl$rows[,2])
	node_merge_rows <- merge(ca_row_coord_df, node_index, by.x="node1", by.y="WdCode")
	ca_col_coord_df <- data.frame(level_=rownames(ca1pl$cols), d1=ca1pl$cols[,1], d2=ca1pl$cols[,2])
	row_coords <- node_merge_rows
	col_coords <- ca_col_coord_df
	row_coords$hovertext <- paste(
	      "<b>Wikidata:</b>", row_coords$node1, "<br>",
	      "<b>Name:</b>",  row_coords$Node, "<br>"
	    )
	row_coords$d1 <- jitter(row_coords$d1, amount=0.5)
	row_coords$d2 <- jitter(row_coords$d2, amount=0.5)

	fig <- plot_ly() %>%
	  add_trace(
	    x = row_coords$d1, 
	    y = row_coords$d2, 
	    # text = row_coords$hovertext, 
	    hovertemplate = row_coords$hovertext,
	    mode = "markers+text",
	    type = "scatter",
	    name = "Row Points",
	    marker = list(size = 20*row_coords$Degree/max(row_coords$Degree), color = "blue"),
	    textposition = "none"
	  ) %>%
	  add_trace(
	    x = col_coords$d1, 
	    y = col_coords$d2, 
	    text = col_coords$level_, 
	    mode = "markers+text",
	    type = "scatter",
	    name = "Hierarchy Depth",
	    marker = list(size = 8, color = "red"),
	    textposition = "bottom left"
	  ) %>%
	  layout(
	    title = "Correspondence Analysis Plot",
	    xaxis = list(title = "Dimension 1"),
	    yaxis = list(title = "Dimension 2"),
	    legend = list(title = list(text = "Size maps to the Node's degree"))
	  )
	list(data=node_merge_rows, 
	     ca_obj=ca1, 
	     ca_plot_obj=ca1pl, 
	     index=node_index, 
	     ca_row_coord=ca_row_coord_df,
	     ca_col_coord=ca_col_coord_df,
	     plotly_rows=row_coords,
	     plotly_cols=col_coords,
	     plotly=fig)
}
