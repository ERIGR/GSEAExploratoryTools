#' @title GSEAExploratoryTools_example
#'
#' @description Get path to GSEAExploratoryTools_example examples
#'
#' GSEAExploratoryTools comes bundled with some example files in its `inst/extdata`
#' directory. This function make them easy to access.
#'
#' @param path Name of file. If `NULL`, the example files will be listed.
#' @export
#' @examples
#' 
#' GSEAExploratoryTools_example("gsea_report_for_CB_1725354001411.html")
#'

GSEAExploratoryTools_example <- function(path = NULL) {
  if (is.null(path)) {
    dir(system.file("extdata", package = "GSEAExploratoryTools"))
  } else {
    system.file("extdata", path, package = "GSEAExploratoryTools", mustWork = TRUE)
  }
}




