#' @title common_enriched_signature_GSEA
#'
#' @description Function that allow to identify molecular signatures that are enriched in several differential. Of course, the set of signatures tested should be the #' same for each signature. 
#'     
#'
#' @param data_GSEA A named list of dataframes coming from the output of the function read_GSEA_result
#'
#' @param fdr_threshold The fdr threshold used to decide which molecular signature is correlated with a differential.
#' @return A vector of class character (empty or not) that contain the name of all molecular signatures that are supposed to be enriched in all expression differential.
#'
#' @export
#'
#' @importFrom purrr reduce
#'
#' @examples 
#' 
#'  path_result1 <- GSEAExploratoryTools_example("gsea_report_for_CB_1725354001411.html")
#'  path_result2 <- GSEAExploratoryTools_example("gsea_report_for_CC_1725353944800.html")
#'  result1 <- read_GSEA_result_html(path_result1)
#'  result2 <- read_GSEA_result_html(path_result2) 
#'  several_signatures <-  list("CB_vs_N" = result1,"CC_vs_N" = result2 )
#'
#'  common_enriched_signature_GSEA(data_GSEA = several_signatures,fdr_threshold = 0.25)
#'

 
common_enriched_signature_GSEA <- function(data_GSEA,fdr_threshold= 0.25){#accolade ouvrante de la fonction
  

  
  #Identification des signatures moléculaires qui sont toujours enrichies
  common_enriched_signature_step1 <-  lapply(data_GSEA,function(z){return(z[which(z$FDR_q_val<fdr_threshold),])}) 
  common_enriched_signature_step2 <-  lapply(common_enriched_signature_step1,function(z){return(z$Gene_Set)})
  common_enriched_signature <- purrr::reduce(.x = common_enriched_signature_step2,intersect)
  
  
  return(common_enriched_signature)
  
}#accolade fermante delafonction


