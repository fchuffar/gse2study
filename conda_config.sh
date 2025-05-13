conda create -n rnaseq_env
conda activate rnaseq_env
mamba install -c anaconda -c bioconda -c conda-forge -c r r-base libopenblas bioconductor-geoquery bioconductor-affy bioconductor-biobase r-seqinr r-rcpparmadillo r-devtools r-fastmap r-matrix r-kernsmooth r-catools r-gtools r-nortest r-survival r-beanplot r-gplots \
  r-sartools r-openxlsx  snakemake=7.32.4 python=3.9
# under R
# devtools::install_github("fchuffar/epimedtools")
