cd ~/projects/atacclock/results/GSE193141
source config
echo $gse
echo $project
rsync -auvP ~/projects/${project}/results/${gse}/ cargo:~/projects/${project}/results/${gse}/








# download fastq files NCBI/GEO... 
# data description
echo https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=${gse}
# ## download NCBI/SRA db
# wget https://ftp.ncbi.nlm.nih.gov/srp/reports/Metadata/SRA_Accessions.tab
# ## preprocessing it...
# cat ~/projects/datashare/platforms/SRA_Accessions.tab | grep SRA | grep RUN > ~/projects/datashare/platforms/SRA_Accessions_SRA_RUN.tab
# cat ~/projects/datashare/platforms/SRA_Accessions.tab | grep SRA | grep GSE > ~/projects/datashare/platforms/SRA_Accessions_SRA_GSE.tab
# cat ~/projects/datashare/platforms/SRA_Accessions.tab | grep SRP | grep GSE > ~/projects/datashare/platforms/SRA_Accessions_SRP_GSE.tab
# sra=`cat ~/projects/datashare/platforms/SRA_Accessions_SRA_GSE.tab | grep ${gse} | cut -f2 | grep SRA | uniq`
srp=`cat ~/projects/datashare/platforms/SRA_Accessions_SRP_GSE.tab | grep ${gse} | cut -f1 | grep SRP | uniq`
echo $srp
if [[ -f ~/projects/datashare/platforms/SRA_Accessions_${srp}.tab ]]; then
   echo "File ~/projects/datashare/platforms/SRA_Accessions_${srp}.tab exists."
else
  # cat ~/projects/datashare/platforms/SRA_Accessions_SRA_RUN.tab | grep ${sra} > ~/projects/datashare/platforms/SRA_Accessions_${sra}.tab
  cat ~/projects/datashare/platforms/SRA_Accessions_SRP_RUN.tab | grep ${srp} > ~/projects/datashare/platforms/SRA_Accessions_${srp}.tab
fi
srrs=`cat ~/projects/datashare/platforms/SRA_Accessions_${srp}.tab | grep RUN | grep ${srp} | cut -f1 | grep SRR`
echo $srrs
echo $srrs | wc

mkdir -p ~/projects/datashare/${gse}/raw
cd ~/projects/datashare/${gse}/raw

source ~/conda_config.sh
conda activate srp_env
echo "checking" $srrs >> checking_srrs_report.txt
for srr in $srrs
do
  if [[ -f ${srr}.fastq || -f ${srr}.fastq.gz || -f ${srr}_1.fastq || -f ${srr}_1.fastq.gz ]]; then
     echo "File ${srr}.fastq exists."
  else
     echo "File ${srr}.fastq does not exist."
     # prefetch $srr
     # vdb-validate $srr
     # status=$?
     # ## take some decision ##
     # [ $status -ne 0 ] && echo "$srr check failed" || echo "$srr ok" >> checking_srrs_report.txt
     # # parallel-fastq-dump --threads 16 --tmpdir /dev/shm --gzip --split-files --outdir ./ --srp-id ${srr}
     # # /summer/epistorage/fchuffar/miniconda3.save/envs/oct22_env/bin/parallel-fastq-dump --threads 16 --tmpdir /dev/shm --gzip --split-files --outdir ./ --srp-id ${srr}
     # # fastq-dump --gzip --split-files --outdir ./ --srp-id ${srr}
     # #
     # # fastq-dump --threads 16 --tmpdir /dev/shm --gzip --split-files --outdir ./ --srp-id ${srr}
    #  fasterq-dump --threads 16 -p --temp . --split-files --outdir ./ ${srr}
    url1=ftp://ftp.sra.ebi.ac.uk/vol1/fastq/`echo ${srr} | cut -c1-6`/0`echo ${srr} | rev | cut -c1-2 | rev`/${srr}/${srr}_1.fastq.gz
    url2=ftp://ftp.sra.ebi.ac.uk/vol1/fastq/`echo ${srr} | cut -c1-6`/0`echo ${srr} | rev | cut -c1-2 | rev`/${srr}/${srr}_2.fastq.gz
    wget -nc ${url1}
    wget -nc ${url2}
  fi
done
cat checking_srrs_report.txt
# for fq in `ls *.fastq`
# do
#   gzip ${fq} &
# done

# SR or PE?
ls -lha ~/projects/datashare/${gse}/raw
if [[ -f ${srr}_2.fastq || -f ${srr}_2.fastq.gz ]]; then
  sequencing_read_type=PE
else
  sequencing_read_type=SR
fi
echo $sequencing_read_type

## metadata linking sample and raw files
gsms=`cat ~/projects/datashare/platforms/SRA_Accessions_${srp}.tab | grep RUN | grep ${srp} | cut -f10 | cut -f1 -d_ | uniq`
echo $gsms
echo $gsms | wc
cd ~/projects/datashare/${gse}/
for gsm in $gsms
do
  echo ${gsm}  
  srrs=`cat ~/projects/datashare/platforms/SRA_Accessions_${srp}.tab | grep RUN | grep ${gsm} | cut -f1 | grep SRR | sort`
  echo ${srrs}    
  if [[ $sequencing_read_type == PE ]]; then
    # PE
    echo PE    
    echo raw/`echo $srrs | sed 's/ /_1\.fastq\.gz,raw\//g'`_1.fastq.gz raw/`echo $srrs | sed 's/ /_2\.fastq\.gz,raw\//g'`_2.fastq.gz > ${gsm}_notrim_fqgz.info
  else
    # # SR
    echo SR
    echo raw/`echo $srrs | sed 's/ /\.fastq\.gz,raw\//g'`.fastq.gz > ${gsm}_notrim_fqgz.info
  fi
done
cat *.info








# If not from NCCBI/GEO, organize your raw files in datashare
mkdir -p ~/projects/datashare/${gse}/raw
cd ~/projects/datashare/${gse}/raw
# ... edit and bash design.sh








## qc align count
# put wf on dahu and launch
rsync -auvP ~/projects/${project}/results/${gse}/ dahu:~/projects/${project}/results/${gse}/
source ~/conda_config.sh
conda activate rnaseq_env
cd ~/projects/${project}/results/${gse}/
snakemake -k -s ~/projects/${project}/results/${gse}/wf.py --cores 24 -pn
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



