setOldClass('igraph')
setOldClass("ggplot")

#' A vector of Wikidata paths
#' @export
setClass('PathVector', representation=list(paths="list"))

#' Use iGraph objects
#' @export
setClass("iGraph", representation=list(g="igraph"))

#' [Provisional] Hold Graph-Theory metrics
#' @export
setClass("WikidataMetricsList", representation=list(deg="integer", betw="integer", pr="list", pow="integer"))
setClass("WikidataPlotsList", representation=list(tree="ggplot"))

#' Contextualize iGraph with Wikidata-specific info
#' @export
setClass("WikidataGraph", representation=list(nodes="character", edges="integer",
    graph="iGraph", paths="PathVector"))


#' [Provisional] Hold the Output of a Wikidata analysis
#' @export
setClass("WikidataAnalysis", representation=list(graph_stuff="WikidataGraph", metrics="WikidataMetricsList", plots="WikidataPlotsList"))
