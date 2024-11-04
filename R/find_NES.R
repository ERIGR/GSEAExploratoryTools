#' @title find_NES
#'
#' @description Function that allows to retrieve NES for a specific gene signature in GSEA results directory.
#'     
#'
#' @param gsea_report_list a  R named list that contains one list of 2 dataframes for each comparison (corresponding to the 2 tsv files that give the enrichment in a condition vs another and the reciprocal). The name of each element correspond to the name of the comparison associated to the path.
#'
#' @param signature a R character element that contains the name of the signature for which the user wants an NES value for example "HALLMARK_E2F_TARGETS".
#'
#' @importFrom purrr keep
#'
#' @importFrom rlang is_empty
#'
#' @return A R named list. Each element of the R list corresponds the NES associated to a comparison between two conditions.
#'
#' @export
#' @examples
#'pathresult1 <- GSEAExploratoryTools_example("GSEA_CB_vs_N")
#'pathresult2 <- GSEAExploratoryTools_example("GSEA_CC_vs_N")
#'
#' toimport <- list(
#' "CB_vs_N" = pathresult1,
#' "CC_vs_N" = pathresult2
#'  )
#' results_tsv <- import_GSEA_tsv_report(toimport) 
#'  
#' find_NES(results_tsv,"KEGG_CELL_CYCLE")
#'
#'

find_NES <- function(gsea_report_list,signature){#accolade ouvrante de find_NES

toret_step1 <- lapply(gsea_report_list,function(z){lapply(z,function(t){t[grep(signature,t[["NAME"]]),]})})

### small test to check if the signature given corresponds to a tested signature (should be in at least one GSEA results directory)
logictest1 <- lapply(toret_step1,function(z){lapply(z,function(t){rlang::is_empty(t)==TRUE})})

lapply(logictest1,function(t){if(all(do.call(c,t))==TRUE){stop("It does not correspond to any signature even in one of the GSEA results directory.")}})


toret_step2 <-  lapply(toret_step1,function(z){purrr::keep(z,.p = function(x){nrow(x)>0})})
toret_step3 <- lapply(toret_step2,function(z){return(z[[1]])})
toret <- lapply(toret_step3,function(z){return(z[["NES"]])})
return(toret)


#accolade fermante de find_NES
 }


