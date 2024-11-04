#'@title import_GSEA_tsv_report
#'
#'@description Function that allows to import the tsv gsea report from several GSEA output directory in a R list (each element of the list corresponds to a specified comparison, that is a specific GSEA output directory). 
#'
#'@param list_path_gsea_output_directory a R list (named R list). Each element of this list is a character chain specifying the absolute path to a GSEA output directory.
#'Ideally the name of each element of the list gives the comparison associated to the GSEA output directory.
#'
#'@importFrom readr read_tsv
#'
#'@return a R list. Each element of this list is also a list of 2 dataframes (one for the signature enriched in the first condition and 
#'one for the signature enriched in the second condition)
#'
#'@export
#'
#'@examples
#'pathresult1 <- GSEAExploratoryTools_example("GSEA_CB_vs_N")
#'pathresult2 <- GSEAExploratoryTools_example("GSEA_CC_vs_N")
#'
#' toimport <- list(
#' "CB_vs_N" = pathresult1,
#' "CC_vs_N" = pathresult2
#'  )
#' results_tsv <- import_GSEA_tsv_report(toimport) 
#'  
#' results_tsv
#'
#'
#'

import_GSEA_tsv_report <- function(list_path_gsea_output_directory){#accolade ouvrante de la fonction import_GSEA_tsv_report

gsea_report_tsv_name <- lapply(
list_path_gsea_output_directory  
,function(z){#accolade ouvrante de la fonction du lapply

             grep(pattern = "*.tsv",list.files(path = z,pattern = "^gsea_report",full.names = TRUE),value = TRUE)

#accolade fermante de la fonction du lapply
}
)

gsea_report_tsv_toreturn <- lapply(gsea_report_tsv_name
,function(z){#accolade ouvrante de la fonction du lapply

             lapply(z,function(t){readr::read_tsv(t)})


#accolade fermante de la fonction du lapply
}
)

return(gsea_report_tsv_toreturn)

#accolade fermante de la fonction import_GSEA_tsv_report
}


