source("../config")

samples = read.table(paste0("/bettik/chuffarf/geo_submission/", gse, "/GSE1full/counts/md5.geo.txt"))
head(samples)
dim(samples)

<<<<<<< HEAD
samples$sample_name =         substr(samples[,2], 1, 18)
samples$title =               samples$sample_name
samples$source_name =         "liver"
samples$organism =            paste0(species, "_", version) 
samples$genetic_background =  substr(samples[,2], 1, 6)
samples$diet =                substr(samples[,2], 8, 13)
samples$replicate =           substr(samples[,2], 15, 18)
=======
samples$sample_name =         substr(samples[,2], 1, 10)
samples$title =               samples$sample_name
samples$source_name =         "liver"
samples$sorganism =           "Rattus_norvegicus"
samples$rat =                 substr(samples[,2], 1, 3)
samples$treatment =           substr(samples[,2], 4, 6)
samples$collection_week =     substr(samples[,2], 7, 8)
samples$tumor_status =      substr(samples[,2], 9, 10)
>>>>>>> 005487fc175ed2cf66788350e4d98c02013876cb
samples$processed_data_file = samples[,2]
samples$raw_file1 =           paste0(samples$sample_name, "_R1.fastq.gz")
samples$raw_file2 =           paste0(samples$sample_name, "_R2.fastq.gz")

samples = samples[,-(1:2)] 
head(samples)
WriteXLS::WriteXLS(samples, "01_samples.xlsx")







proc_data_files = read.table(paste0("/bettik/chuffarf/geo_submission/", gse, "/GSE1full/counts/md5.geo.txt"))
head(proc_data_files)
dim(proc_data_files)

proc_data_files$filename = proc_data_files[,2]
proc_data_files$filetype = "counts"
proc_data_files$checksum = proc_data_files[,1]

proc_data_files = proc_data_files[,-(1:2)] 
head(proc_data_files)
WriteXLS::WriteXLS(proc_data_files, "02_proc_data_files.xlsx")








raw_files = read.table(paste0("/bettik/chuffarf/geo_submission/", gse, "/GSE1full/fastq/md5.geo.txt"))
head(raw_files)
dim(raw_files)

raw_files$filename =         raw_files[,2]
raw_files$filetype =         "fastq"
raw_files$checksum =         raw_files[,1]
<<<<<<< HEAD
raw_files$instrument_model = "NextSeq500"
=======
raw_files$instrument_model = "Novaseq6000"
>>>>>>> 005487fc175ed2cf66788350e4d98c02013876cb
raw_files$single_or_paired = "paired-end"

raw_files = raw_files[,-(1:2)] 
head(raw_files)
WriteXLS::WriteXLS(raw_files, "03_raw_files.xlsx")








<<<<<<< HEAD

paired_end_experiments = data.frame(filename1=paste0(samples$sample_name, "_R1.fastq.gz"), filename2=paste0(samples$sample_name, "_R2.fastq.gz"))
=======
paired_end_experiments = read.table(paste0("/bettik/chuffarf/geo_submission/", gse, "/GSE1full/counts/md5.geo.txt"))
head(paired_end_experiments)
dim(paired_end_experiments)

paired_end_experiments$filename1 = paste0(substr(samples[,2], 1, 10), "_R1.fastq.gz")
paired_end_experiments$filename2 = paste0(substr(samples[,2], 1, 10), "_R2.fastq.gz")

paired_end_experiments = paired_end_experiments[,-(1:2)] 
>>>>>>> 005487fc175ed2cf66788350e4d98c02013876cb
head(paired_end_experiments)
WriteXLS::WriteXLS(paired_end_experiments, "04_paired_end_experiments.xlsx")



