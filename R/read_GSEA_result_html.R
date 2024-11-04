#' @title read_GSEA_result_html
#'
#' @param path_html R character chain that specify the absolute path to a GSEA results file for a specific comparison, that is the html file 
#' that gives te top of the signature the most positively correlated to a condition vs another or the opposite depending on the file. 
#'
#' @return a R dataframe that gives the top correlated signature with all the associated statistics.
#'
#' @export
#'
#' @importFrom XML readHTMLTable
#'
#' @examples 
#' path_gsea_result_html <- GSEAExploratoryTools_example("gsea_report_for_CB_1725354001411.html")
#'
#' result <- read_GSEA_result_html(path_gsea_result_html)
#'

read_GSEA_result_html <- function(path_html){#accolade marquant le début de la fonction.
  
  
 
  
  #Importation du fichier de résultats de GSEA
  result <- XML::readHTMLTable(path_html,header = FALSE)[[1]][,-1]
  
  #On renomme les colonnes du premier tableau du ficheir de résutats de GSEA
  colnames(result) <- c("Gene_Set","GS DETAILS","SIZE","ES","NES","NOM_p_val","FDR_q_val","FWER_p_val","RANK_AT_MAX","LEADING_EDGE")
  
  
  #on change la class de certaines colonnes (de class character à class numeric)
  for(i in 1:ncol(result)){
  
  
  #condition pour transformer la colonne en vecteur numérique
  if(colnames(result)[i] %in% c("SIZE","ES","NES","NOM_p_val","FDR_q_val","FWER_p_val","RANK_AT_MAX")){
    
    result[[i]] <- as.numeric(result[[i]])
    
    }
  
}
  
  
  #On renvoie l"output de la fonction sos forme de dataframe.
  return(result) 
  
}#accolade marquant la fin de la fonction read_GSEA_result_html



