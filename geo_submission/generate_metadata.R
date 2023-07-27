source("../config")
source("../config.R")

samples = read.table(paste0("/bettik/chuffarf/geo_submission/", gse, "/GSE1full/counts/md5.geo.txt"))
head(samples)
dim(samples)


samples$sample_name            = substr(samples[,2], 1, 11)
rownames(samples) = samples$sample_name
samples$title                  = samples$sample_name
samples$organism               = paste0(species, "_", version) 
samples$tissue                 = tissue
#_samples$cell_line              = ""
samples$cell_type              = "primary culture"
samples$genotype               = genotype[rownames(samples)]
samples$treatment              = dict_stress[substr(samples[,2], 1, 2)]
samples$molecule               = "RNA-seq"
samples$single_or_paired_end   = single_or_paired_end
samples$instrument_model       = "Novaseq6000"
samples$description            = paste0("mouse_", substr(samples[,2], 3, 4))
samples$processed_data_file    = samples[,2]
samples$raw_file1              = paste0(samples$sample_name, ".fastq.gz")


samples$batch_id     = batch_id    
samples$medium       = medium      
samples$transfection = transfection  
samples$vector       = vector      


samples = samples[,-(1:2)] 
samples
WriteXLS::WriteXLS(samples, "01_samples.xlsx")







proc_data_files = read.table(paste0("/bettik/chuffarf/geo_submission/", gse, "/GSE1full/counts/md5.geo.txt"))
head(proc_data_files)
dim(proc_data_files)

proc_data_files$filename = proc_data_files[,2]
proc_data_files$checksum = proc_data_files[,1]
proc_data_files$filetype = "counts"

proc_data_files = proc_data_files[,-(1:2)] 
proc_data_files
WriteXLS::WriteXLS(proc_data_files, "02_proc_data_files.xlsx")








raw_files = read.table(paste0("/bettik/chuffarf/geo_submission/", gse, "/GSE1full/fastq/md5.geo.txt"))
head(raw_files)
dim(raw_files)

raw_files$filename =         raw_files[,2]
raw_files$checksum =         raw_files[,1]
raw_files$filetype =         "fastq"

raw_files = raw_files[,-(1:2)] 
raw_files
WriteXLS::WriteXLS(raw_files, "03_raw_files.xlsx")




# <<<<<<< HEAD
#
# paired_end_experiments = data.frame(filename1=paste0(samples$sample_name, "_R1.fastq.gz"), filename2=paste0(samples$sample_name, "_R2.fastq.gz"))
# =======
# paired_end_experiments = read.table(paste0("/bettik/chuffarf/geo_submission/", gse, "/GSE1full/counts/md5.geo.txt"))
# head(paired_end_experiments)
# dim(paired_end_experiments)
#
# paired_end_experiments$filename1 = paste0(substr(samples[,2], 1, 10), "_R1.fastq.gz")
# paired_end_experiments$filename2 = paste0(substr(samples[,2], 1, 10), "_R2.fastq.gz")
#
# paired_end_experiments = paired_end_experiments[,-(1:2)]
# >>>>>>> 005487fc175ed2cf66788350e4d98c02013876cb
# head(paired_end_experiments)
# WriteXLS::WriteXLS(paired_end_experiments, "04_paired_end_experiments.xlsx")



