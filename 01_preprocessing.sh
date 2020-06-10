# rsync -auvP ~/projects/heatshock/results/GSE100469/ dahu:~/projects/heatshock/results/GSE100469/
# cd ~/projects/heatshock/results/GSE100469
source config
echo $gse
echo $project
echo "rsync -auvP ~/projects/${project}/results/${gse}/ dahu:~/projects/${project}/results/${gse}/"
echo "cd ~/projects/${project}/results/${gse}"
## data description
echo https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=${gse}
# GSM2684046  Mock 1 4sU-RNA - Rep 1
# GSM2684047  Mock 2 4sU-RNA - Rep 1
# GSM2684048  0-1 h Salt stress 4sU-RNA - Rep 1
# GSM2684049  1-2 h Salt stress 4sU-RNA - Rep 1
# GSM2684050  0-1 h Heat stress 4sU-RNA - Rep 1
# GSM2684051  1-2 h Heat stress 4sU-RNA - Rep 1
# GSM2684052  Mock 1 4sU-RNA - Rep 2
# GSM2684053  Mock 2 4sU-RNA - Rep 2
# GSM2684054  0-1 h Salt stress 4sU-RNA - Rep 2
# GSM2684055  1-2 h Salt stress 4sU-RNA - Rep 2
# GSM2684056  0-1 h Heat stress 4sU-RNA - Rep 2
# GSM2684057  1-2 h Heat stress 4sU-RNA - Rep 2


## download fastq files
# wget https://ftp.ncbi.nlm.nih.gov/sra/reports/Metadata/SRA_Accessions.tab
sra=`cat ~/projects/datashare/platforms/SRA_Accessions.tab | grep ${gse} | cut -f1 | grep SRA`
echo $sra
srrs=`cat ~/projects/datashare/platforms/SRA_Accessions.tab | grep RUN | grep ${sra}| cut -f1 | grep SRR`
echo $srrs
echo $srrs | wc

mkdir -p ~/projects/datashare/${gse}/raw
cd ~/projects/datashare/${gse}/raw

echo "checking" $srrs >> checking_srrs_report.txt
for srr in $srrs
do
  FILE=${srr}_1.fastq.gz
  if [ -f $FILE ]; then
     echo "File $FILE exists."
  else
     echo "File $FILE does not exist."
     prefetch $srr
     vdb-validate $srr
     status=$?
     ## take some decision ##
     [ $status -ne 0 ] && echo "$srr check failed" || echo "$srr ok" >> checking_srrs_report.txt
     parallel-fastq-dump --threads 16 --tmpdir /dev/shm --gzip --split-files --outdir ./ --sra-id ${srr}
  fi
done

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
  echo raw/`echo $srrs | sed 's/ /_1\.fastq\.gz,raw\//g'`_1.fastq.gz raw/`echo $srrs | sed 's/ /_2\.fastq\.gz,raw\//g'`_2.fastq.gz > ${gsm}_notrim_fqgz.info
done
cat *.info


## qc align count
# put wf on dahu and launch
rsync -auvP ~/projects/${project}/results/${gse}/ dahu:~/projects/${project}/results/${gse}/
snakemake -s ~/projects/${project}/results/${gse}/wf.py --cores 16 -pn
snakemake -s ~/projects/${project}/results/${gse}/wf.py --cores 49 --cluster "oarsub --project epimed -l nodes=1/core={threads},walltime=6:00:00 "  --latency-wait 30 -pn


## get results
mkdir -p ~/projects/datashare/${gse}/raw/
rsync -auvP dahu:~/projects/datashare/${gse}/*.txt ~/projects/datashare/${gse}/
rsync -auvP dahu:~/projects/datashare/${gse}/raw/*.html ~/projects/datashare/${gse}/raw/
rsync -auvP dahu:~/projects/datashare/${gse}/raw/multiqc_notrim* ~/projects/datashare/${gse}/raw/

