#' Find edges from list of paths
#'
#' @param target_path character A vector of node names
#' @return edges integer of even length (see Details)
#' @details The integer vector of even length holds pairs of nodes that are linked by an edge. This form is required by `igraph`. The function is expected to be slow with larger data.
#' @export
find_edge <- function(target_path, nodes=NULL, edges=c()){
    if (is.null(nodes)) stop("Won't work without node data!")
    if (!length(target_path) || length(target_path)==1){
        return(edges);
    }
    x =  target_path[1]
    y = target_path[2]
    x_ix <- which(nodes==str_trim(x))
    y_ix <- which(nodes==str_trim(y))

    edges = c(edges, x_ix, y_ix)
    new_target_path = target_path[-1]

    find_edge(new_target_path, nodes, edges)
}
