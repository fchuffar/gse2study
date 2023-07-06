cd ~/projects/nme2/results/GSE101657
source config
echo $gse
echo $project
rsync -auvP ~/projects/${project}/results/${gse}/ cargo:~/projects/${project}/results/${gse}/
## data description
echo https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=${gse}

# GSM2711588  Liver_Control_Diet0
# GSM2711589  Liver_Control_Diet1
# GSM2711590  Liver_Control_Diet2
# GSM2711591  Liver_Control_Diet3
# GSM2711592  Liver_Control_Diet4
# GSM2711593  Liver_HF_High_Fat0
# GSM2711594  Liver_HF_High_Fat1
# GSM2711595  Liver_HF_High_Fat2
# GSM2711596  Liver_HF_High_Fat3
# GSM2711597  Liver_HF_High_Fat4
# GSM2711598  Liver_HF_High_Fat5
# GSM2711599  Liver_KD_Ketogenic0
# GSM2711600  Liver_KD_Ketogenic1
# GSM2711601  Liver_KD_Ketogenic2
# GSM2711602  Liver_KD_Ketogenic3
# GSM2711603  Liver_KD_Ketogenic4
# GSM2711604  Liver_KD_Ketogenic5
# GSM2711605  Liver_KD_Ketogenic6
# GSM2711606  Kidney_Control_Diet0
# GSM2711607  Kidney_Control_Diet1
# GSM2711608  Kidney_Control_Diet2
# GSM2711609  Kidney_Control_Diet3
# GSM2711610  Kidney_Control_Diet4
# GSM2711611  Kidney_HF_High_Fat0
# GSM2711612  Kidney_HF_High_Fat1
# GSM2711613  Kidney_HF_High_Fat2
# GSM2711614  Kidney_HF_High_Fat3
# GSM2711615  Kidney_HF_High_Fat4
# GSM2711616  Kidney_HF_High_Fat5
# GSM2711617  Kidney_KD_Ketogenic0
# GSM2711618  Kidney_KD_Ketogenic1
# GSM2711619  Kidney_KD_Ketogenic2
# GSM2711620  Kidney_KD_Ketogenic3
# GSM2711621  Kidney_KD_Ketogenic4
# GSM2711622  Kidney_KD_Ketogenic5
# GSM2711623  Kidney_KD_Ketogenic6




## download fastq files
# wget https://ftp.ncbi.nlm.nih.gov/sra/reports/Metadata/SRA_Accessions.tab
sra=`cat ~/projects/${datashare}/platforms/SRA_Accessions.tab | grep ${gse} | cut -f1 | grep SRA`
echo $sra
srrs=`cat ~/projects/${datashare}/platforms/SRA_Accessions.tab | grep RUN | grep ${sra}| cut -f1 | grep SRR`
echo $srrs
echo $srrs | wc

mkdir -p ~/projects/${datashare}/${gse}/raw
cd ~/projects/${datashare}/${gse}/raw

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



conda activatesra_env
echo "checking" $srrs >> checking_srrs_report.txt
for srr in $srrs
do
  # FILE=${srr}_1.fastq.gz
  # if [ -f $FILE ]; then
  #    echo "File $FILE exists."
  # else
  #    echo "File $FILE does not exist."
  #    prefetch $srr
  #    vdb-validate $srr
  #    status=$?
  #    ## take some decision ##
  #    [ $status -ne 0 ] && echo "$srr check failed" || echo "$srr ok" >> checking_srrs_report.txt
  #    # parallel-fastq-dump --threads 16 --tmpdir /dev/shm --gzip --split-files --outdir ./ --sra-id ${srr}
  #    # /summer/epistorage/fchuffar/miniconda3.save/envs/oct22_env/bin/parallel-fastq-dump --threads 16 --tmpdir /dev/shm --gzip --split-files --outdir ./ --sra-id ${srr}
  #    # fastq-dump --gzip --split-files --outdir ./ --sra-id ${srr}
  #    #
  #    # fastq-dump --threads 16 --tmpdir /dev/shm --gzip --split-files --outdir ./ --sra-id ${srr}
     fasterq-dump --threads 16 -p --temp /dev/shm --split-files --outdir ./ ${srr}
  # fi
done
cat checking_srrs_report.txt
gzip -c *.fastq


# SR or PE?
ls -lha ~/projects/${datashare}/${gse}/raw
sequencing_read_type=SR

## metadata linking sample and raw files
gsms=`cat ~/projects/${datashare}/platforms/SRA_Accessions.tab | grep RUN | grep ${sra} | cut -f10 | cut -f1 -d_ | uniq`
echo $gsms
echo $gsms | wc
cd ~/projects/${datashare}/${gse}/
for gsm in $gsms
do
  echo ${gsm}  
  srrs=`cat ~/projects/${datashare}/platforms/SRA_Accessions.tab | grep RUN | grep ${gsm} | cut -f1 | grep SRR | sort`
  echo ${srrs}    
  # # PE
  # # echo raw/`echo $srrs | sed 's/ /_1\.fastq\.gz,raw\//g'`_1.fastq.gz raw/`echo $srrs | sed 's/ /_2\.fastq\.gz,raw\//g'`_2.fastq.gz > ${gsm}_notrim_fqgz.info
  # # SR
  echo raw/`echo $srrs | sed 's/ /_1\.fastq\.gz,raw\//g'`_1.fastq.gz > ${gsm}_notrim_fqgz.info
done
cat *.info



## qc align count
# put wf on dahu and launch
rsync -auvP ~/projects/${project}/results/${gse}/ dahu:~/projects/${project}/results/${gse}/
cd ~/projects/${project}/results/${gse}/
snakemake -s ~/projects/${project}/results/${gse}/wf.py --cores 16 -pn
snakemake -s ~/projects/${project}/results/${gse}/wf.py --cores 49 --cluster "oarsub --project epimed -l nodes=1/core={threads},walltime=6:00:00 "  --latency-wait 60 -pn


## get results
mkdir -p ~/projects/${datashare}/${gse}/raw/
rsync -auvP dahu:~/projects/${datashare}/${gse}/*.txt ~/projects/${datashare}/${gse}/
rsync -auvP dahu:~/projects/${datashare}/${gse}/raw/*.html ~/projects/${datashare}/${gse}/raw/
rsync -auvP dahu:~/projects/${datashare}/${gse}/raw/multiqc_notrim* ~/projects/${datashare}/${gse}/raw/
open ~/projects/${datashare}/${gse}/raw/multiqc_notrim.html
