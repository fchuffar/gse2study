source("../config")

samples = read.table(paste0("/bettik/chuffarf/geo_submission/", project, "/md5.", gse, ".cnt.geo.txt"))
head(samples)
dim(samples)

splits = do.call(rbind, strsplit(samples[,2], "_"))
head(splits[,1:6])

tissue_dict=c(
  NULL  
)
genotype_dict=c(
  NULL  
)
treatment_dict=c(
  NULL  
)

samples$sample_name =         apply(splits[,1:4], 1, paste0, collapse="_") # substr(samples[,2], 1, 23)
samples$title =               samples$sample_name
samples$organism =            species
samples$tissue  =             split[,1]
# samples$cell_line  =             split[,3]
# samples$cell_type  =             split[,3]
samples$genotype =            split[,2]
samples$treatment =           split[,3]
# samples$batch =             substr(samples[,2], 20, 23)
samples$replicate =           split[,4]

samples$processed_data_file = samples[,2]
samples$raw_file1 =           paste0(samples$sample_name, "_1.fastq.gz")
samples$raw_file2 =           paste0(samples$sample_name, "_2.fastq.gz")

samples = samples[,-(1:2)] 
head(samples)
WriteXLS::WriteXLS(samples, "01_samples.xlsx")





proc_data_files = read.table(paste0("/bettik/chuffarf/geo_submission/", project, "/md5.", gse, ".cnt.geo.txt"))
head(proc_data_files)
dim(proc_data_files)

proc_data_files$filename = proc_data_files[,2]
proc_data_files$checksum = proc_data_files[,1]
proc_data_files$filetype = "cnt"

proc_data_files = proc_data_files[,-(1:2)] 
head(proc_data_files)
WriteXLS::WriteXLS(proc_data_files, "02_proc_data_files.xlsx")








raw_files = read.table(paste0("/bettik/chuffarf/geo_submission/", project, "/md5.", gse, ".fq.geo.txt"))
head(raw_files)
dim(raw_files)

raw_files$filename =         raw_files[,2]
raw_files$checksum =         raw_files[,1]
raw_files$filetype =         "fastq"

raw_files = raw_files[,-(1:2)] 
head(raw_files)
WriteXLS::WriteXLS(raw_files, "03_raw_files.xlsx")








paired_end_experiments = data.frame(filename1=paste0(samples$sample_name, "_R1.fastq.gz"), filename2=paste0(samples$sample_name, "_R2.fastq.gz"))
head(paired_end_experiments)
WriteXLS::WriteXLS(paired_end_experiments, "04_paired_end_experiments.xlsx")



