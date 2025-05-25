#' Convert list of paths to graph
#' @export
paths_to_graph <- function(split_paths){
    require(stringr)
    require(igraph)
    if(class(split_paths) != "PathVector") stop("PathVector class is required as input.")

    nodes =  unique(str_trim(unlist(split_paths@paths)))
    graph_n <- length(nodes)

    edges = c()

    for (path_i in split_paths@paths){
        if (!is.null(path_i)){
            edges <- append(edges, find_edge(path_i[[1]], nodes=nodes))
        }
    }

    print(edges)

    g <- make_empty_graph()
    g <- make_graph(edges = edges, n = length(nodes), directed = TRUE)

    ret = new("WikidataGraph", nodes=nodes, edges=edges, paths=split_paths,
        graph=new("iGraph", g=g))
}
