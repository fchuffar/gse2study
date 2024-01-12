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
source("../config.R")

workDir <- "."      # working directory for the R session

projectName <- paste(project, gse, "DESeq2", sep="_")                         # name of the project
author <- "Florent Chuffart"                                # author of the statistical analysis/report

targetFile <- "design.txt"                           # path to the design/target file

write.table(
  cbind(data.frame(
          label = design$gsm,
          files = paste0(design$gsm, "_notrim_star_", species, "_", annotation, "_", version , "_", gtf_prefix, "_stranded", strand, "_classiccounts.txt"),
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

fitType <- "parametric"                              # mean-variance relationship: "parametric" (default) or "local"
cooksCutoff <- TRUE                                  # TRUE/FALSE to perform the outliers detection (default is TRUE)
independentFiltering <- TRUE                         # TRUE/FALSE to perform independent filtering (default is TRUE)
alpha <- 0.05                                        # threshold of statistical significance
pAdjustMethod <- "BH"                                # p-value adjustment method: "BH" (default) or "BY"

typeTrans <- "VST"                                   # transformation for PCA/clustering: "VST" or "rlog"
locfunc <- "median"                                  # "median" (default) or "shorth" to estimate the size factors

colors <- 1:8                                       # vector of colors of each biological condition on the plots
            

################################################################################
###                             running script                               ###
################################################################################
setwd(workDir)
library(SARTools)

# checking parameters
checkParameters.DESeq2(projectName=projectName,author=author,targetFile=targetFile,
                       rawDir=rawDir,featuresToRemove=featuresToRemove,varInt=varInt,
                       condRef=condRef,batch=batch,fitType=fitType,cooksCutoff=cooksCutoff,
                       independentFiltering=independentFiltering,alpha=alpha,pAdjustMethod=pAdjustMethod,
                       typeTrans=typeTrans,locfunc=locfunc,colors=colors)

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

# analysis with DESeq2
out.DESeq2 <- run.DESeq2(counts=counts, target=target, varInt=varInt, batch=batch,
                         locfunc=locfunc, fitType=fitType, pAdjustMethod=pAdjustMethod,
                         cooksCutoff=cooksCutoff, independentFiltering=independentFiltering, alpha=alpha)

# PCA + clustering
exploreCounts(object=out.DESeq2$dds, group=target[,varInt], typeTrans=typeTrans, col=colors)

# summary of the analysis (boxplots, dispersions, diag size factors, export table, nDiffTotal, histograms, MA plot)
summaryResults <- summarizeResults.DESeq2(out.DESeq2, group=target[,varInt], col=colors,
                                          independentFiltering=independentFiltering,
                                          cooksCutoff=cooksCutoff, alpha=alpha)

# save image of the R session
save.image(file=paste0(projectName, ".RData"))

# generating HTML report
writeReport.DESeq2(target=target, counts=counts, out.DESeq2=out.DESeq2, summaryResults=summaryResults,
                   majSequences=majSequences, workDir=workDir, projectName=projectName, author=author,
                   targetFile=targetFile, rawDir=rawDir, featuresToRemove=featuresToRemove, varInt=varInt,
                   condRef=condRef, batch=batch, fitType=fitType, cooksCutoff=cooksCutoff,
                   independentFiltering=independentFiltering, alpha=alpha, pAdjustMethod=pAdjustMethod,
                   typeTrans=typeTrans, locfunc=locfunc, colors=colors)

