cd ~/projects/epispores/results/rnaseq_govin_2023spo4tU
source config
echo $gse
echo $project
rsync -auvP ~/projects/${project}/results/${gse}/ cargo:~/projects/${project}/results/${gse}/








# from NCBI/GEO... 
# data description
echo https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=${gse}

## download fastq files from GEO/SRA
# wget https://ftp.ncbi.nlm.nih.gov/sra/reports/Metadata/SRA_Accessions.tab
sra=`cat ~/projects/datashare/platforms/SRA_Accessions.tab | grep ${gse} | cut -f1 | grep SRA`
echo $sra
srrs=`cat ~/projects/datashare/platforms/SRA_Accessions.tab | grep RUN | grep ${sra}| cut -f1 | grep SRR`
echo $srrs
echo $srrs | wc

mkdir -p ~/projects/datashare/${gse}/raw
cd ~/projects/datashare/${gse}/raw

# echo "checking" $srrs >> checking_srrs_report.txt
# for srr in $srrs
# do
#   FILE=${srr}_1.fastq.gz
#   if [ -f $FILE ]; then
#      echo "File $FILE exists."
#   else
#      echo "File $FILE does not exist."
#      prefetch $srr
#      vdb-validate $srr
#      status=$?
#      ## take some decision ##
#      [ $status -ne 0 ] && echo "$srr check failed" || echo "$srr ok" >> checking_srrs_report.txt
#      parallel-fastq-dump --threads 16 --tmpdir /dev/shm --gzip --split-files --outdir ./ --sra-id ${srr}
#   fi
# done
# cat checking_srrs_report.txt

source ~/conda_config.sh
conda activate sra_env
echo "checking" $srrs >> checking_srrs_report.txt
for srr in $srrs
do
  FILE=${srr}_1.fastq
  if [[ -f $FILE || -f $FILE.gz ]]; then
     echo "File $FILE exists."
  else
     echo "File $FILE does not exist."
     # prefetch $srr
     # vdb-validate $srr
     # status=$?
     # ## take some decision ##
     # [ $status -ne 0 ] && echo "$srr check failed" || echo "$srr ok" >> checking_srrs_report.txt
     # # parallel-fastq-dump --threads 16 --tmpdir /dev/shm --gzip --split-files --outdir ./ --sra-id ${srr}
     # # /summer/epistorage/fchuffar/miniconda3.save/envs/oct22_env/bin/parallel-fastq-dump --threads 16 --tmpdir /dev/shm --gzip --split-files --outdir ./ --sra-id ${srr}
     # # fastq-dump --gzip --split-files --outdir ./ --sra-id ${srr}
     # #
     # # fastq-dump --threads 16 --tmpdir /dev/shm --gzip --split-files --outdir ./ --sra-id ${srr}
     fasterq-dump --threads 16 -p --temp /dev/shm --split-files --outdir ./ ${srr}
  fi
done
cat checking_srrs_report.txt
gzip *.fastq

# SR or PE?
ls -lha ~/projects/datashare/${gse}/raw
sequencing_read_type=PE

## metadata linking sample and raw files
gsms=`cat ~/projects/datashare/platforms/SRA_Accessions.tab | grep RUN | grep ${sra} | cut -f10 | cut -f1 -d_ | uniq`
echo $gsms
echo $gsms | wc
cd ~/projects/datashare/${gse}/
for gsm in $gsms
do
  echo ${gsm}  
  srrs=`cat ~/projects/datashare/platforms/SRA_Accessions.tab | grep RUN | grep ${gsm} | cut -f1 | grep SRR | sort`
  echo ${srrs}    
  # PE
  echo raw/`echo $srrs | sed 's/ /_R1\.fastq\.gz,raw\//g'`_R1.fastq.gz raw/`echo $srrs | sed 's/ /_R2\.fastq\.gz,raw\//g'`_R2.fastq.gz > ${gsm}_notrim_fqgz.info
  # # SR
  # echo raw/`echo $srrs | sed 's/ /\.fastq\.gz,raw\//g'`.fastq.gz > ${gsm}_notrim_fqgz.info
done
cat *.info



## qc align count
# put wf on dahu and launch
rsync -auvP ~/projects/${project}/results/${gse}/ dahu:~/projects/${project}/results/${gse}/
source ~/conda_config.sh
conda activate rnaseq_env
cd ~/projects/${project}/results/${gse}/
snakemake -k -s ~/projects/${project}/results/${gse}/wf.py --cores 32 -pn
snakemake -k -s ~/projects/${project}/results/${gse}/wf.py --jobs 50 --cluster "oarsub --project epimed -l nodes=1/core={threads},walltime=6:00:00 "  --latency-wait 60 -pn

# Stranded or not?
RCODE="rmarkdown::render('02_stranded_or_not.Rmd')"
(echo $RCODE | Rscript - 2>&1) > 02_stranded_or_not.Rout

# DA reporting
cd 04_deseq2
mate ../design.R
RCODE="source('da_report.R')"
(echo $RCODE | Rscript - 2>&1) > da_report.Rout

## get results
mkdir -p ~/projects/datashare/${gse}/raw/
rsync -auvP dahu:~/projects/datashare/${gse}/*.txt ~/projects/datashare/${gse}/
rsync -auvP dahu:~/projects/datashare/${gse}/raw/*.html ~/projects/datashare/${gse}/raw/
rsync -auvP dahu:~/projects/datashare/${gse}/raw/multiqc_notrim* ~/projects/datashare/${gse}/raw/
open ~/projects/datashare/${gse}/raw/multiqc_notrim.html



