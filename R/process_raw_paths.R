#' Process raw paths
#' @export
process_raw_paths <- function(fn="raw_paths.txt"){
    raw_paths = readLines(fn)

    process_line <- function(x){
        test = grepl("/", x)
        if (test){
            strsplit(x, split="/")
        }
    }

    lapply(raw_paths, process_line)
}
