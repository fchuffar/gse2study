# source ../01_preprocessing.sh first lines...
ssh cargo

# Transfering files
cd ~/projects/datashare/${gse}/
ls -lha raw/*1.fastq.gz raw/*2.fastq.gz
cat raw/md5.bettik.txt 
ls -lha *_${gtf_prefix}_stranded${strand}_classiccounts.txt
mkdir -p /bettik/chuffarf/geo_submission/${project}/${gse}/fastq
mkdir -p /bettik/chuffarf/geo_submission/${project}/${gse}/counts
rsync -auvP --copy-links \
  ~/projects/datashare/${gse}/raw/*1.fastq.gz \
  ~/projects/datashare/${gse}/raw/*2.fastq.gz \
  /bettik/chuffarf/geo_submission/${project}/${gse}/fastq/.
rsync -auvP --copy-links \
  ~/projects/datashare/${gse}/*_${gtf_prefix}_stranded${strand}_classiccounts.txt \
  /bettik/chuffarf/geo_submission/${project}/${gse}/counts

ls -lha /bettik/chuffarf/geo_submission/${project}/${gse}/*
ls -lha /bettik/chuffarf/geo_submission/${project}/${gse}/fastq/
ls -lha /bettik/chuffarf/geo_submission/${project}/${gse}/counts/

# MD5
cd /bettik/chuffarf/geo_submission/${project}/${gse}/fastq
md5sum *.fastq.gz > md5.geo.txt
cat md5.geo.txt | cut -f1 -d" " | sort > /tmp/tmp.md5.geo.txt
cat ~/projects/datashare/${gse}/raw/md5.bettik.txt  | cut -f1 -d" " | sort > /tmp/tmp.md5.bettik.txt
diff /tmp/tmp.md5.geo.txt /tmp/tmp.md5.bettik.txt
cd /bettik/chuffarf/geo_submission/${project}/${gse}/counts
md5sum *.txt > md5.geo.txt

ls -lha /bettik/chuffarf/geo_submission/${project}/${gse}/*
ls -lha /bettik/chuffarf/geo_submission/${project}/${gse}/fastq/
ls -lha /bettik/chuffarf/geo_submission/${project}/${gse}/counts/

# Put metadata
source ~/conda_config.sh 
conda activate rnaseq_env
cd ~/projects/${project}/results/${gse}/geo_submission
Rscript generate_metadata.R 

rsync -auvP cargo:~/projects/${project}/results/${gse}/geo_submission/0*_*.xlsx ~/projects/${project}/results/${gse}/geo_submission/.


# localy 
cd ~/projects/${project}/results/${gse}/geo_submission
# wget https://www.ncbi.nlm.nih.gov/geo/info/examples/seq_template.xlsx
open seq_template.xlsx

rsync -auvP seq_template.xlsx cargo:/bettik/chuffarf/geo_submission/${project}/${gse}/.

# Creating archive
cd /bettik/chuffarf/geo_submission/${gse}/
ls -lha ${GSE_TARGET_NAME}/*
 
tar -cvf ${GSE_TARGET_NAME}.tar ${GSE_TARGET_NAME}


# Put on GEO
ssh cargo
cd /bettik/chuffarf/geo_submission/${gse}/
lftp -e "mirror -R archive4geo uploads/florent.chuffart@univ-grenoble-alpes.fr_XXXHASHXXX " -u geoftp,XXXpasswrdXXX ftp-private.ncbi.nlm.nih.gov

