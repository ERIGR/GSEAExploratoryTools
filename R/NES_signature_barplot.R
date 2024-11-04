#' @title NES_signature_barplot
#' @description Function that allows to represent the value of the NES of several signature
#'
#' @param signatures character vector. Names of the signature for which the user wants a representation of NES.
#'
#'
#' @param gsea_report_tsv_path R named list that gives the path associated of the GSEA results directory for each comparisons. 
#' The name of each element specifies the comparison associated with the path.
#'
#' @param col_signature named character vector specifying colors associated to each condition. The names of the elements corresponds to the names of comparisons.
#'
#' @importFrom ggplot2 ggplot geom_bar scale_x_discrete theme_classic coord_flip
#'
#' @importFrom readr read_tsv 
#'
#' @importFrom rlang .data
#'
#' @return a ggplot2 representation of the NES for each signature for each comparison.
#'
#' 
#' @export
#'
#' @examples
#'
#'pathresult1 <- GSEAExploratoryTools_example("GSEA_CB_vs_N")
#'pathresult2 <- GSEAExploratoryTools_example("GSEA_CC_vs_N")
#'
#' NES_signature_barplot(signatures = c("KEGG_CELL_CYCLE","KEGG_JAK_STAT_SIGNALING_PATHWAY"),
#' gsea_report_tsv_path = list("GSEA_CB_vs_N" = pathresult1,"GSEA_CC_vs_N" = pathresult2),
#' col_signature = c("GSEA_CB_vs_N"= "red" ,"GSEA_CC_vs_N" = "blue"))
#'





NES_signature_barplot <- function(signatures,col_signature,gsea_report_tsv_path){
#accolade ouvrante de la fonction



#identification of the path and the name of the tsv containing the GSEA results.
gsea_report_tsv_name <- lapply(gsea_report_tsv_path,
function(z){
grep(pattern = "*.tsv",list.files(path = z,pattern = "^gsea_report",full.names = TRUE),value = TRUE)
}
)

#generation of a list that contains the GSEA results
gsea_report_tsv <- lapply(gsea_report_tsv_name,function(z){

lapply(z,function(t){readr::read_tsv(t)})



})


#identification of the NES value in each pair of tsv files
interest_signature_NES <- lapply(signatures,function(t){ 

find_NES(gsea_report_tsv,t)

})




#Generation of the dataframe that will be use to make the ggplot representation.
signature_graphical_df <- data.frame(
"NES" = do.call(c,lapply(interest_signature_NES,function(t){do.call("c",t)})),
"compa" = do.call("c",lapply(interest_signature_NES,names)),
"signature" = rep(signatures,each = 2)
)


#generation of the ggplot2 representation
ggplot2::ggplot(signature_graphical_df,ggplot2::aes(x = .data$signature,y = .data$NES,fill = .data$compa))+
ggplot2::geom_bar(stat="identity", position= ggplot2::position_dodge())+
ggplot2::scale_x_discrete(limits = signatures)+
ggplot2::scale_fill_manual(values = col_signature)+
ggplot2::theme_classic()+
ggplot2::coord_flip()


#accolade fermante de la fonction
}


