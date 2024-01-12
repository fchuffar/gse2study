cd ~/projects/breast/results/rnaseq_dnmt_bgi
source config
echo $gse
echo $project
rsync -auvP ~/projects/${project}/results/${gse}/ cargo:~/projects/${project}/results/${gse}/
## data description
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
conda activatesra_env
echo "checking" $srrs >> checking_srrs_report.txt
for srr in $srrs
do
  FILE=${srr}.fastq
  if [ -f $FILE ]; then
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
  # # PE
  # # echo raw/`echo $srrs | sed 's/ /_1\.fastq\.gz,raw\//g'`_1.fastq.gz raw/`echo $srrs | sed 's/ /_2\.fastq\.gz,raw\//g'`_2.fastq.gz > ${gsm}_notrim_fqgz.info
  # # SR
  echo raw/`echo $srrs | sed 's/ /\.fastq\.gz,raw\//g'`.fastq.gz > ${gsm}_notrim_fqgz.info
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


## get results
mkdir -p ~/projects/datashare/${gse}/raw/
rsync -auvP dahu:~/projects/datashare/${gse}/*.txt ~/projects/datashare/${gse}/
rsync -auvP dahu:~/projects/datashare/${gse}/raw/*.html ~/projects/datashare/${gse}/raw/
rsync -auvP dahu:~/projects/datashare/${gse}/raw/multiqc_notrim* ~/projects/datashare/${gse}/raw/
open ~/projects/datashare/${gse}/raw/multiqc_notrim.html




#Q1 : cond1 vs. cond2             => **genotype** HE vs. WT (ref.) | BF, notransf, novect, single_layer
#Q2 : cond3 vs. cond4 vs. cond5   => **vector** novect vs. scrumb vs. vecph1 | BF, ASOtrans, WT, single_layer
#           Q2.1 scrumb vs. novect (ref.) => control negatif
#           Q2.2 vecph1 vs. scrumb (ref.) (ctrl ph1, Htt--)

#Q3 : cond6 vs. cond7 vs. cond8   => **genotype** HE vs. HO vs. WT | EF, notransf, novect, spheroid
#           Q3.1 HO vs. WT (ref.)
#           Q3.2 HE vs. WT (ref.)
#           Q3.3 HO vs. HE (ref.)

# volcano plot par question
# boxplot par gene
# GSEA sur une question

cd 04_deseq2_q1   ; echo "source('da_report.R');" | Rscript - ; cd ..
cd 04_deseq2_q2.1 ; echo "source('da_report.R');" | Rscript - ; cd ..
cd 04_deseq2_q2.2 ; echo "source('da_report.R');" | Rscript - ; cd ..
cd 04_deseq2_q3.1 ; echo "source('da_report.R');" | Rscript - ; cd ..
cd 04_deseq2_q3.2 ; echo "source('da_report.R');" | Rscript - ; cd ..
cd 04_deseq2_q3.3 ; echo "source('da_report.R');" | Rscript - ; cd ..


cd 04_deseq2_q1   ; echo "rmarkdown::render('volcano.Rmd')" | Rscript - ; cd ..
cd 04_deseq2_q2.1 ; echo "rmarkdown::render('volcano.Rmd')" | Rscript - ; cd ..
cd 04_deseq2_q2.2 ; echo "rmarkdown::render('volcano.Rmd')" | Rscript - ; cd ..
cd 04_deseq2_q3.1 ; echo "rmarkdown::render('volcano.Rmd')" | Rscript - ; cd ..
cd 04_deseq2_q3.2 ; echo "rmarkdown::render('volcano.Rmd')" | Rscript - ; cd ..
cd 04_deseq2_q3.3 ; echo "rmarkdown::render('volcano.Rmd')" | Rscript - ; cd ..




mkdir ~/projects/datashare/rnaseq_lafage_icm/
rsync -auvP luke:~/projects/datashare/rnaseq_lafage_icm/*_notrim_star_Mus_musculus_mm10_geneswchrm_strandedreverse_classiccounts.txt ~/projects/datashare/rnaseq_lafage_icm/.

