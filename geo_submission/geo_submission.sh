source("../config")
source("../design.R")

samples = read.table(paste0("/bettik/chuffarf/geo_submission/", project, "/", gse, "/counts/md5.geo.txt"))
head(samples)
dim(samples)


dict_genotype = c(
  h2al2WT="H2al2 WT", 
  h2al2KO="H2al2 KO" 
)


dict_cell_type = c(
  P="Pachytene spermatocyte",
  R="Round spermatid",
  C="Condensed spermatid",
  S="Spermatozoa"
)



samples$sample_name            = substr(samples[,2], 1, 14)
rownames(samples) = samples$sample_name
samples$title                  = samples$sample_name
samples$library_strategy       = "RNA-Seq"
samples$organism               = "Mus musculus"
samples$tissue                 = "testis"
samples$cell_line              = ""
samples$cell_type              = dict_cell_type[substr(rownames(samples), 1, 1)]
samples$genotype               = dict_genotype  [substr(rownames(samples), 3, 9)]
samples$treatment              = ""
samples$batch                  = ""
samples$molecule               = c("polyA RNA", "total RNA", "genomic DNA")[1]
samples$genotype               = c("single", "paired-end")[1]
samples$instrument_model       = c("Illumina NextSeq 500", "Illumina NovaSeq 6000")[2]
samples$description            = ""

samples$processed_data_file    = samples[,2]
samples$processed_data_file    = ""
samples$raw_file1              = paste0(samples$sample_name, "_R1.fastq.gz")
samples$raw_file2              = ""
samples$raw_file3              = ""
samples$raw_file4              = ""

samples = samples[,-(1:2)] 
samples
head(samples)
WriteXLS::WriteXLS(samples, "01_samples.xlsx")







proc_data_files = read.table(paste0("/bettik/chuffarf/geo_submission/", project, "/", gse, "/counts/md5.geo.txt"))
head(proc_data_files)
dim(proc_data_files)

proc_data_files$filename = proc_data_files[,2]
proc_data_files$checksum = proc_data_files[,1]
proc_data_files$filetype = "counts"

proc_data_files = proc_data_files[,-(1:2)] 
proc_data_files
WriteXLS::WriteXLS(proc_data_files, "02_proc_data_files.xlsx")








raw_files = read.table(paste0("/bettik/chuffarf/geo_submission/", project, "/", gse, "/fastq/md5.geo.txt"))
head(raw_files)
dim(raw_files)

raw_files$filename =         raw_files[,2]
raw_files$checksum =         raw_files[,1]
raw_files$filetype =         "fastq"

raw_files = raw_files[,-(1:2)] 
raw_files
WriteXLS::WriteXLS(raw_files, "03_raw_files.xlsx")













paired_end_experiments = rbind(
  data.frame(filename1=paste0(substr(rownames(samples), 1, 1), "_", substr(rownames(samples), 8, 14), "_L1_R1.fastq.gz"), filename2=paste0(substr(rownames(samples), 1, 1), "_", substr(rownames(samples), 8, 14), "_L1_R2.fastq.gz")),
  data.frame(filename1=paste0(substr(rownames(samples), 1, 1), "_", substr(rownames(samples), 8, 14), "_L2_R1.fastq.gz"), filename2=paste0(substr(rownames(samples), 1, 1), "_", substr(rownames(samples), 8, 14), "_L2_R2.fastq.gz")),
  data.frame(filename1=paste0(substr(rownames(samples), 1, 1), "_", substr(rownames(samples), 8, 14), "_L3_R1.fastq.gz"), filename2=paste0(substr(rownames(samples), 1, 1), "_", substr(rownames(samples), 8, 14), "_L3_R2.fastq.gz")),
  data.frame(filename1=paste0(substr(rownames(samples), 1, 1), "_", substr(rownames(samples), 8, 14), "_L4_R1.fastq.gz"), filename2=paste0(substr(rownames(samples), 1, 1), "_", substr(rownames(samples), 8, 14), "_L4_R2.fastq.gz"))
)

head(paired_end_experiments)
WriteXLS::WriteXLS(paired_end_experiments, "04_paired_end_experiments.xlsx")





