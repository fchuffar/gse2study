source("../config")

samples = read.table(paste0("/bettik/chuffarf/geo_submission/", project, "/md5.", gse, ".cnt.geo.txt"))
head(samples)
dim(samples)

splits = do.call(rbind, strsplit(samples[,2], "_"))
head(splits[,1:6])

tissue_dict=c(
  IN = "intestin",
  LG = "lung",
  LV = "liver",
  BN = "bone",
  MR = "bone marrow",
  MS = "muscle",
  SP = "spleen",
  NULL  
)
background_dict=c(
  g172 = "Trp53 R172H Mut", # (mutation sur le codon 172 de Trp53) (https://www.jax.org/strain/008183)
  g270 = "Trp53 R270H Mut", # (mutation sur le codon 270 de Trp53) (https://www.jax.org/strain/008182)
  NULL  
)
genotype_dict=c(
  WT = "Trp53 WT/WT",
  MU = "Trp53 WT/Mut",
  NULL  
)

samples$sample_name =         apply(splits[,1:4], 1, paste0, collapse="_") # substr(samples[,2], 1, 23)
samples$title =               samples$sample_name
samples$organism =            species
samples$tissue  =             tissue_dict[splits[,2]]
# samples$cell_line  =             splits[,3]
# samples$cell_type  =             splits[,3]
samples$genotype =            genotype_dict[splits[,3]]
# samples$treatment =           treatment_dict[splits[,1]]
samples$background =          background_dict[splits[,1]]
# samples$batch =             substr(samples[,2], 20, 23)
samples$replicate =           splits[,4]

samples$processed_data_file = samples[,2]
samples$raw_file1 =           paste0(samples$sample_name, "_R1.fastq.gz")
samples$raw_file2 =           paste0(samples$sample_name, "_R2.fastq.gz")

samples = samples[,-(1:2)] 
head(samples[,1:6])
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








paired_end_experiments = data.frame(filename1=samples$raw_file1, filename2=samples$raw_file2)
head(paired_end_experiments)
WriteXLS::WriteXLS(paired_end_experiments, "04_paired_end_experiments.xlsx")



