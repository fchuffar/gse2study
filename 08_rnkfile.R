# dafiles = unlist(sapply(list.files(pattern="04_deseq2"), function(dir) {paste0(dir, "/tables/", list.files(paste0(dir, "/tables"), pattern="*.complete.txt"))}))

dafiles = unlist(sapply(list.files(pattern="04_deseq2"), 
  function(dir) {
    paste0(dir, "/tables/", list.files(paste0(dir, "/tables"), pattern="*.complete.txt"))
  }
))

if (!exists("mread.table")) mread.table = memoise::memoise(read.table)


prefixes = substr(dafiles, 1, nchar(dafiles) - 4)
prefixes
#
#
# ("DEN14NTvsDEN08NT", "DEN20NTvsDEN08NT")
# fc_thresh = 2
# padj_thresh = 0.05
# gsymb_up = "Bex1"
# gsymb_dw = "Adam2"
# ```
#
# # Question
#
#
# # Materials and methods
#
# **Differential analysis** we performed using DESeq2.
#
# We selected up and down genes according to foldchange threshold of `r fc_thresh` and adjusted p-value using Benjamini Hochberg of `r padj_thresh`.
# We exported up regulated genes in files `r paste0(prefixes, "_up_genes.txt")` and down regulated genes in `r paste0(prefixes, "_dw_genes.txt")`
#
# `r gsymb_up` is shown as exemple of an up regulated gene.
# `r gsymb_dw` is shown as exemple of an down regulated gene.
#
# **Pathway analysis** Resulting gene lists where analysed using `AmiGO 2/PANTHER` (http://amigo.geneontology.org) for *biological process* unsing *Rattus norvegicus* transcriptome with default option.
# Results are shown for up regulated genes in `r paste0(prefixes, "_up_genes.pdf")` documents and for down regulated genes in `r paste0(prefixes, "_dw_genes.pdf")` document.
#
# # Volcano plots
#
# ```{r results="verbatim"}
g = list()
das = list()
# layout(matrix(1:10, 2, byrow=FALSE), respect=TRUE)
for (prefix in prefixes) {
  table_file = paste0(prefix, ".txt")
  print(paste("differential analysis results were exported in", table_file, "file."))
  # res = mread.table(table_file, header=TRUE)
  res = read.table(table_file, header=TRUE)
  rownames(res) = res$Id
  head(res)
  dim(res)
  das[[prefix]] = res

  # main = paste0(substr(prefix, 1, 7), " vs. ", substr(prefix, 10, 16)," (ref.)")
  # layout(matrix(1:2,1), respect=TRUE)
  # plot(res$log2FoldChange, -log10(res$pvalue), xlab="log2(foldchange)", ylab="-log10(pval)", main=main, pch=".")
  # abline(h=-log10(padj_thresh), col=2)
  # abline(v=c(-1,1)*log2(fc_thresh), col=2, lty=2)
  # legend("topright", lty=1:2, col=2, legend=c(paste0("pval<", padj_thresh), paste0("|fc|>", fc_thresh)))
  # plot(res$log2FoldChange, -log10(res$padj), xlab="log2(foldchange)", ylab="-log10(padj) (BH)", main=main, pch=".")
  # abline(h=-log10(padj_thresh), col=2)
  # abline(v=c(-1,1)*log2(fc_thresh), col=2, lty=2)
  # legend("topright", lty=1:2, col=2, legend=c(paste0("pval<", padj_thresh), paste0("|fc|>", fc_thresh)))
  # # text(-res[common_up,]$log2FoldChange, -log10(res[common_up,]$padj), common_up, col=4)
  # # text(-res[common_dw,]$log2FoldChange, -log10(res[common_dw,]$padj), common_dw, col=4)
  # text(res[gsymb_up,]$log2FoldChange, -log10(res[gsymb_up,]$padj), gsymb_up, col=2)
  # text(res[gsymb_dw,]$log2FoldChange, -log10(res[gsymb_dw,]$padj), gsymb_dw, col=4)
  #
  # up_genes = rownames(res)[!is.na(res$padj) & res$log2FoldChange > log2(fc_thresh) & res$padj < padj_thresh]
  # dw_genes = rownames(res)[!is.na(res$padj) & res$log2FoldChange < -log2(fc_thresh) & res$padj < padj_thresh]
  #
  # up_genes_filename = paste0(prefix, "_up_genes.txt")
  # dw_genes_filename = paste0(prefix, "_dw_genes.txt")
  #
  # g[[substr(up_genes_filename, 1,19)]] = up_genes
  # g[[substr(dw_genes_filename, 1,19)]] = dw_genes
  # print(paste(length(up_genes), "up regulated genes were exported in", up_genes_filename, "file."))
  # write.table(up_genes, up_genes_filename, quote=FALSE, row.names=FALSE, col.names=FALSE)
  # print(paste(length(dw_genes), "down regulated genes were exported in", dw_genes_filename, "file."))
  # write.table(dw_genes, dw_genes_filename, quote=FALSE, row.names=FALSE, col.names=FALSE)



  gsea_input = cbind(rownames(res[!is.na(res$log2FoldChange),]), res[!is.na(res$log2FoldChange),]$log2FoldChange)
  homogdb = homologene::homologene(unique(unlist(gsea_input[,1])), inTax=10116, outTax=9606)
  head(homogdb)
  dim(homogdb)  
  homogdb = homogdb[!duplicated(homogdb[,1]),]
  dim(homogdb)  
  rownames(homogdb) = homogdb[,1]
  dim(gsea_input)
  gsea_input = gsea_input[gsea_input[,1] %in% rownames(homogdb),]
  dim(gsea_input)
  gsea_input[,1] = homogdb[gsea_input[,1],2]
  head(gsea_input)
  dim(gsea_input)

  gsea_input_filename = paste0(prefix, ".gsea_input.rnk")
  print(paste("gsea_input were exported in", gsea_input_filename, "file."))
  write.table(gsea_input, gsea_input_filename, sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

}
# ```
#
# GSEA details here, section "Gene Set Enrichment Analysis (GSEA)":
#
#   https://github.com/fchuffar/practicle_sessions/blob/master/rnaseq_analysis/00_presa.Rmd
#
#
# # Correlation
#
# ```{r fi.width=9, fig.height=9}
# pairs(sapply(das, "[[", "log2FoldChange"))
# ```
#
# # Venn diagrams
#
# ```{r}
# venn_up = VennDiagram::venn.diagram(g[c(1,3)], "venn_up_genes.png", imagetype="png", height=600, width=600, cex=0.3, cat.cex=0.3)
# venn_dw = VennDiagram::venn.diagram(g[c(2,4)], "venn_dw_genes.png", imagetype="png", height=600, width=600, cex=0.3, cat.cex=0.3)
# ```
#
# ![](venn_up_genes.png){ width=50% }
# ![](venn_dw_genes.png){ width=50% }
#
# # Exemple of deregulated genes
#
# ```{r}
#
# layout(matrix(1:2,1), respect=TRUE)
# n = colnames(res)[grep("norm",colnames(res))]
# substr(n, 5, 11)
# boxplot(log2(unlist(res[gsymb_up,n]))~substr(n, 9, 15), las=2, xlab="", ylab="log2(expr+1)", main=gsymb_up)
# boxplot(log2(unlist(res[gsymb_dw,n]))~substr(n, 9, 15), las=2, xlab="", ylab="log2(expr+1)", main=gsymb_dw)
#
# up_genes_filename = paste0("COMMOM", "_up_genes.txt")
# dw_genes_filename = paste0("COMMOM", "_dw_genes.txt")
# common_up = epimedtools::intersect_rec(g[[1]], g[[3]])
# common_dw = epimedtools::intersect_rec(g[[2]], g[[4]])
# write.table(common_up, up_genes_filename, quote=FALSE, row.names=FALSE, col.names=FALSE)
# write.table(common_dw, dw_genes_filename, quote=FALSE, row.names=FALSE, col.names=FALSE)
# ```
#
#
#
# # Session Information
#
# ```{r, results="verbatim"}
# sessionInfo()
# ```



