# conda deactivate
# rm -Rf /summer/epistorage/miniconda3/*
# ~/Miniconda3-latest-Linux-x86_64.sh -u -p /summer/epistorage/miniconda3 -b
# conda update -n base -c defaults conda

__conda_setup="$('/summer/epistorage/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
   eval "$__conda_setup"
else
   if [ -f "/summer/epistorage/miniconda3/etc/profile.d/conda.sh" ]; then
       . "/summer/epistorage/miniconda3/etc/profile.d/conda.sh"
   else
       export PATH="/summer/epistorage/miniconda3/bin:$PATH"
   fi
fi
unset __conda_setup


# conda create --name rnaseq_env
conda activate rnaseq_env


conda install  -c bioconda snakemake fastqc samtools star htseq deeptools
pip install --upgrade snakemake
conda install -c bioconda -c conda-forge multiqc

# conda install  -c anaconda libopenblas
#
# conda install -c r \
#   r-base=3.6.1     \
#   r-rmarkdown      \
#   r-devtools       \
#   r r-xml
#
#   install.package("https://cran.r-project.org/src/contrib/Archive/locfit/locfit_1.5-9.tar.gz")
#
#
# # conda install --no-update-deps -c r r-xml
#
# conda install -c bioconda \
#   bioconductor-Biobase    \
#   bioconductor-affy       \
#   bioconductor-GEOquery
#
# # conda install --no-update-deps -c bioconda            \
# #   bioconductor-illuminahumanmethylation27kanno.ilmn12.hg19    \
# #   bioconductor-illuminahumanmethylation450kanno.ilmn12.hg19   \
# #   bioconductor-illuminahumanmethylationepicanno.ilm10b4.hg19
#
#
# #conda install -c r r-locfit
# conda install -c r r-glmnet
#
#
#
# conda install -c bioconda bioconductor-rhdf5lib
# conda install -c bioconda bioconductor-rhdf5
# conda install -c bioconda bioconductor-hdf5array
# conda install -c bioconda snakemake
#
#
# BiocManager::install("HDF5Array")
# BiocManager::install("minfi")
# BiocManager::install("IlluminaHumanMethylation27kanno.ilmn12.hg19")
# BiocManager::install("IlluminaHumanMethylation450kanno.ilmn12.hg19")
# BiocManager::install("IlluminaHumanMethylationEPICanno.ilm10b4.hg19")
# BiocManager::install("EpiDISH")
#
#
#
#
# # https://github.com/fchuffar/epimedtools
# Sys.setenv(TAR = "/bin/tar") ; devtools::install_github("fchuffar/epimedtools")
# Sys.setenv(TAR = "/bin/tar") ; devtools::install_github("fchuffar/dnamaging")

# BiocManager::install("impute")


# install.packages("dbplyr")
# install.packages("tidyr")
# install.packages("memoise")
# install.packages("glmnet")
# install.packages("glmnetUtils")
# install.packages("beeswarm")
#
#
#
#
# # bioconductor-methylclockdata                                \
# # bioconductor-methylclock                                    \
#
#
#
#
