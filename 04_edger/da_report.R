################################################################################
### R script to compare several conditions with the SARTools and DESeq2 packages
### Hugo Varet
### April 20th, 2015
### designed to be executed with SARTools 1.2.0
################################################################################

################################################################################
###                parameters: to be modified by the user                    ###
################################################################################
rm(list=ls())                                        # remove all the objects from the R session
source("../config")
source("../design.R")

workDir <- "."      # working directory for the R session

projectName <- paste(project, gse, "DESeq2", sep="_")                         # name of the project
author <- "Florent Chuffart"                                # author of the statistical analysis/report

targetFile <- "design.txt"                           # path to the design/target file

write.table(
  cbind(data.frame(
          label = design$gsm,
          files = paste0(design$gsm, "_notrim_star_", species, "_", annotation, "_", genome_version , "_", gtf_prefix, "_stranded", strand, "_classiccounts.txt"),
          stringsAsFactors=FALSE
        ), design), 
  targetFile,sep=" ", quote=FALSE, row.names=FALSE
)


rawDir <- paste0("~/projects/datashare/", gse)                                      # path to the directory containing raw counts files
featuresToRemove <- c("alignment_not_unique",        # names of the features to be removed
                      "ambiguous", "no_feature",     # (specific HTSeq-count information and rRNA for example)
                      "not_aligned", "too_low_aQual")# NULL if no feature to remove

varInt <- "cond"                                     # factor of interest
condRef <- as.character(levels(design[,varInt])[1])                                       # reference biological condition
batch <- NULL                                        # blocking factor: NULL (default) or "batch" for example

alpha <- 0.05                                        # threshold of statistical significance
pAdjustMethod <- "BH"                                # p-value adjustment method: "BH" (default) or "BY"

cpmCutoff <- 1                                       # counts-per-million cut-off to filter low counts
gene.selection <- "pairwise"                         # selection of the features in MDSPlot
normalizationMethod <- "TMM"                         # normalization method: "TMM" (default), "RLE" (DESeq) or "upperquartile"

colors <- c("#f3c300", "#875692", "#f38400",         # vector of colors of each biological condition on the plots
            "#a1caf1", "#be0032", "#c2b280",
            "#848482", "#008856", "#e68fac",
            "#0067a5", "#f99379", "#604e97")

forceCairoGraph <- FALSE
################################################################################
###                             running script                               ###
################################################################################
setwd(workDir)
library(SARTools)
if (forceCairoGraph) options(bitmapType="cairo")

# checking parameters
checkParameters.edgeR(projectName=projectName,author=author,targetFile=targetFile,
                      rawDir=rawDir,featuresToRemove=featuresToRemove,varInt=varInt,
                      condRef=condRef,batch=batch,alpha=alpha,pAdjustMethod=pAdjustMethod,
                      cpmCutoff=cpmCutoff,gene.selection=gene.selection,
                      normalizationMethod=normalizationMethod,colors=colors)

# loading target file
loadTargetFile = function (targetFile, varInt, condRef, batch) 
{
    target <- read.table(targetFile, header = TRUE, sep = " ")
    if (!I(varInt %in% names(target))) 
        stop(paste("The factor of interest", varInt, "is not in the target file"))
    if (!is.null(batch) && !I(batch %in% names(target))) 
        stop(paste("The batch effect", batch, "is not in the target file"))
    target[, varInt] <- as.factor(target[, varInt])
    if (!I(condRef %in% as.character(target[, varInt]))) 
        stop(paste("The reference level", condRef, "is not a level of the factor of interest"))
    target[, varInt] <- relevel(target[, varInt], ref = condRef)
    target <- target[order(target[, varInt]), ]
    rownames(target) <- as.character(target[, 1])
    # if (min(table(target[, varInt])) < 2)
    #     stop(paste("The factor of interest", varInt, "has a level without replicates"))
    if (!is.null(batch) && is.numeric(target[, batch])) 
        warning(paste("The", batch, "variable is numeric. Use factor() or rename the levels with letters to convert it into a factor"))
    cat("Target file:\n")
    print(target)
    return(target)
}
target <- loadTargetFile(targetFile=targetFile, varInt=varInt, condRef=condRef, batch=batch)

# loading counts
counts <- loadCountData(target=target, rawDir=rawDir, featuresToRemove=featuresToRemove)

# description plots
majSequences <- descriptionPlots(counts=counts, group=target[,varInt], col=colors)

# edgeR analysis
out.edgeR <- run.edgeR(counts=counts, target=target, varInt=varInt, condRef=condRef,
                       batch=batch, cpmCutoff=cpmCutoff, normalizationMethod=normalizationMethod,
                       pAdjustMethod=pAdjustMethod)

# MDS + clustering
exploreCounts(object=out.edgeR$dge, group=target[,varInt], gene.selection=gene.selection, col=colors)

# summary of the analysis (boxplots, dispersions, export table, nDiffTotal, histograms, MA plot)
summaryResults <- summarizeResults.edgeR(out.edgeR, group=target[,varInt], counts=counts, alpha=alpha, col=colors)

# save image of the R session
save.image(file=paste0(projectName, ".RData"))

# generating HTML report
writeReport.edgeR(target=target, counts=counts, out.edgeR=out.edgeR, summaryResults=summaryResults,
                  majSequences=majSequences, workDir=workDir, projectName=projectName, author=author,
                  targetFile=targetFile, rawDir=rawDir, featuresToRemove=featuresToRemove, varInt=varInt,
                  condRef=condRef, batch=batch, alpha=alpha, pAdjustMethod=pAdjustMethod, cpmCutoff=cpmCutoff,
                  colors=colors, gene.selection=gene.selection, normalizationMethod=normalizationMethod)