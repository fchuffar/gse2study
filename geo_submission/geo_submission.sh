cd ~/projects/nme2/results/highfatdiet
source config
ssh cargo

# cd ~/projects/nme2/results/highfatdiet/geo_submission
# wget https://www.ncbi.nlm.nih.gov/geo/info/examples/seq_template.xlsx

GSE_TARGET_NAME=GSE1full 

# Transfering files
cd /home/fchuffar/projects/${datashare}/${gse}/
ls -lha raw/*1.fastq.gz raw/*2.fastq.gz
cat raw/md5sum.summer.txt 
ls -lha *_${gtf_prefix}_stranded${strand}_classiccounts.txt
mkdir -p /bettik/chuffarf/geo_submission/${gse}/${GSE_TARGET_NAME}/fastq
mkdir -p /bettik/chuffarf/geo_submission/${gse}/${GSE_TARGET_NAME}/counts
rsync -cauvP --copy-links \
  /home/fchuffar/projects/${datashare}/${gse}/raw/*1.fastq.gz \
  /home/fchuffar/projects/${datashare}/${gse}/raw/*2.fastq.gz \
  /bettik/chuffarf/geo_submission/${gse}/${GSE_TARGET_NAME}/fastq/.
rsync -auvP --copy-links \
  /home/fchuffar/projects/${datashare}/${gse}/*_${gtf_prefix}_stranded${strand}_classiccounts.txt \
  /bettik/chuffarf/geo_submission/${gse}/${GSE_TARGET_NAME}/counts

ls -lha /bettik/chuffarf/geo_submission/${gse}/${GSE_TARGET_NAME}/*






mv S004242_1_nme2wt_normal_rep1_1.fastq.gz  nme2wt_normal_rep1_R1.fastq.gz
mv S004242_1_nme2wt_normal_rep1_2.fastq.gz  nme2wt_normal_rep1_R2.fastq.gz
mv S004243_2_nme2wt_normal_rep2_1.fastq.gz  nme2wt_normal_rep2_R1.fastq.gz
mv S004243_2_nme2wt_normal_rep2_2.fastq.gz  nme2wt_normal_rep2_R2.fastq.gz
mv S004244_3_nme2wt_normal_rep3_1.fastq.gz  nme2wt_normal_rep3_R1.fastq.gz
mv S004244_3_nme2wt_normal_rep3_2.fastq.gz  nme2wt_normal_rep3_R2.fastq.gz
mv S004245_4_nme2wt_normal_rep4_1.fastq.gz  nme2wt_normal_rep4_R1.fastq.gz
mv S004245_4_nme2wt_normal_rep4_2.fastq.gz  nme2wt_normal_rep4_R2.fastq.gz
mv S004246_5_nme2ko_normal_rep1_1.fastq.gz  nme2ko_normal_rep1_R1.fastq.gz
mv S004246_5_nme2ko_normal_rep1_2.fastq.gz  nme2ko_normal_rep1_R2.fastq.gz
mv S004247_6_nme2ko_normal_rep2_1.fastq.gz  nme2ko_normal_rep2_R1.fastq.gz
mv S004247_6_nme2ko_normal_rep2_2.fastq.gz  nme2ko_normal_rep2_R2.fastq.gz
mv S004248_7_nme2ko_normal_rep3_1.fastq.gz  nme2ko_normal_rep3_R1.fastq.gz
mv S004248_7_nme2ko_normal_rep3_2.fastq.gz  nme2ko_normal_rep3_R2.fastq.gz
mv S004249_8_nme2ko_normal_rep4_1.fastq.gz  nme2ko_normal_rep4_R1.fastq.gz
mv S004249_8_nme2ko_normal_rep4_2.fastq.gz  nme2ko_normal_rep4_R2.fastq.gz
mv S004250_9_nme2wt_hghfat_rep1_1.fastq.gz  nme2wt_hghfat_rep1_R1.fastq.gz
mv S004250_9_nme2wt_hghfat_rep1_2.fastq.gz  nme2wt_hghfat_rep1_R2.fastq.gz
mv S004251_10_nme2wt_hghfat_rep2_1.fastq.gz nme2wt_hghfat_rep2_R1.fastq.gz
mv S004251_10_nme2wt_hghfat_rep2_2.fastq.gz nme2wt_hghfat_rep2_R2.fastq.gz
mv S004252_11_nme2wt_hghfat_rep3_1.fastq.gz nme2wt_hghfat_rep3_R1.fastq.gz
mv S004252_11_nme2wt_hghfat_rep3_2.fastq.gz nme2wt_hghfat_rep3_R2.fastq.gz
mv S004253_12_nme2wt_hghfat_rep4_1.fastq.gz nme2wt_hghfat_rep4_R1.fastq.gz
mv S004253_12_nme2wt_hghfat_rep4_2.fastq.gz nme2wt_hghfat_rep4_R2.fastq.gz
mv S004254_13_nme2ko_hghfat_rep1_1.fastq.gz nme2ko_hghfat_rep1_R1.fastq.gz
mv S004254_13_nme2ko_hghfat_rep1_2.fastq.gz nme2ko_hghfat_rep1_R2.fastq.gz
mv S004255_14_nme2ko_hghfat_rep2_1.fastq.gz nme2ko_hghfat_rep2_R1.fastq.gz
mv S004255_14_nme2ko_hghfat_rep2_2.fastq.gz nme2ko_hghfat_rep2_R2.fastq.gz
mv S004256_15_nme2ko_hghfat_rep3_1.fastq.gz nme2ko_hghfat_rep3_R1.fastq.gz
mv S004256_15_nme2ko_hghfat_rep3_2.fastq.gz nme2ko_hghfat_rep3_R2.fastq.gz
mv S004257_16_nme2ko_hghfat_rep4_1.fastq.gz nme2ko_hghfat_rep4_R1.fastq.gz
mv S004257_16_nme2ko_hghfat_rep4_2.fastq.gz nme2ko_hghfat_rep4_R2.fastq.gz




# MD5
cd /bettik/chuffarf/geo_submission/${gse}/${GSE_TARGET_NAME}/fastq
md5sum *.fastq.gz > md5.geo.txt
cd /bettik/chuffarf/geo_submission/${gse}/${GSE_TARGET_NAME}/counts
md5sum *.txt > md5.geo.txt


# Put metadata
cd ~/projects/${project}/results/${gse}/geo_submission
Rscript generate_metadata.R 

cd ~/projects/${project}/results/${gse}/geo_submission
open seq_template.xlsx

rsync -auvP seq_template.xlsx cargo:/bettik/chuffarf/geo_submission/${gse}/${GSE_TARGET_NAME}/.

# Creating archive
cd /bettik/chuffarf/geo_submission/${gse}/
ls -lha ${GSE_TARGET_NAME}/*
 
tar -cvf ${GSE_TARGET_NAME}.tar ${GSE_TARGET_NAME}


# Put on GEO
ssh cargo
cd /bettik/chuffarf/geo_submission/${gse}/
lftp ftp-private.ncbi.nlm.nih.gov
# identification requiered...
put ${GSE_TARGET_NAME}.tar

