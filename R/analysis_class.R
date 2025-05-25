#' Quick descriptives on graph metrics
#'
#' @param gmetric vector An element of a list object at `wikidata_analysis()$metrics` (see Details)
#' @details The first argument is expected to be a graph-theoretic metric of the nodes.
#' @return ord Which node is the largest with regard to the chosen metric
#' @return histo Histogram object of the chosen metric
#' @return pdesc Descriptive statistics using `psych` 
#' @return pdesc Descriptive statistics using `pastecs` 
#' @export
qkdesc <- function(gmetric, prank=FALSE){
	require(psych)
    if (prank) gmetric = 100*gmetric[['vector']]

    list(
    ord = which.max(gmetric),
    histo = ifelse(prank, hist(gmetric, breaks=30), hist(gmetric)),
    pdesc = psych::describe(gmetric),
    sdesc = pastecs::stat.desc(gmetric)
    )
}

#' Full analysis for Wikidata Project
#'
#' @param wg WikidataGraph Custom type, defined in `classes.R`
#' @return analysis_df data.frame of node coordinates in "map"
#' @return plots list of plots
#' @return metrics list of calculated metrics
#' @export
wikidata_analysis <- function(wg){
    if (class(wg) !="WikidataGraph") stop("WikidataGraph instance required as input.")
    g = wg@graph@g
    
    all_metrics <- list(
        g_deg = degree(g)
        ,
        g_betw = betweenness(g)
			# more graph metrics can be added below
    )


    # Graph in tree layout, but in ggplot
    tree_lay = layout_as_tree(g)
    # following https://chrischizinski.github.io/rstats/igraph-ggplotll/
    edge_df = get.data.frame(g)
    tdf = as.data.frame(tree_lay)
    tdf$deg=all_metrics$g_deg
    tdf$comp = factor(components(g)$membership)

    # edge coordinates (broken)
    from_ix = match(edge_df$from, rownames(tdf))
    to_ix = match(edge_df$from, rownames(tdf))
    coord_x_from <- tdf[from_ix,1]
    coord_y_from <- tdf[from_ix,2]
    coord_x_to <- tdf[to_ix, 1]
    coord_y_to <- tdf[to_ix, 2]
    e_coord = data.frame(coord_x_from, coord_y_from, coord_x_to, coord_y_to)
    p1= ggplot(tdf, aes(V1, V2, size=deg, color=comp))+geom_text(label=wg@nodes, position=position_jitter())
    p1 = p1 +
    geom_segment(data=e_coord, x=coord_x_from, y=coord_y_from, xend=coord_x_to, yend=coord_y_to, color='blue') +
    theme_bw() 
    #cl0 <- largest.cliques(g0@graph@g)
    #plot(induced.subgraph(graph=g0@graph@g, vids=cl0[[6]]))
    list(analysis_df=tdf, plots=list(p1), metrics=all_metrics)
}
