source config
echo $gse
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
cat ~/projects/datashare/platforms/SRA_Accessions.tab | grep ${gse}
sra=`cat ~/projects/datashare/platforms/SRA_Accessions.tab | grep ${gse} | cut -f1 | grep SRA`
echo $sra
cat ~/projects/datashare/platforms/SRA_Accessions.tab | grep RUN | grep ${sra}
srrs=`cat ~/projects/datashare/platforms/SRA_Accessions.tab | grep RUN | grep ${sra}| cut -f1 | grep SRR`
echo $srrs
echo $srrs | wc

mkdir -p /bettik/fchuffar/datashare/${gse}/raw
cd /bettik/fchuffar/datashare/${gse}/raw
for srr in $srrs
do
  echo ${srr}
  parallel-fastq-dump --threads 16 --tmpdir ./ --gzip --split-files --outdir ./ --sra-id ${srr}
done
# SR or PE?
ls -lha /bettik/fchuffar/datashare/${gse}/raw
sequencing_read_type=PE

## metadata linking sample and raw files
gsms=`cat ~/projects/datashare/platforms/SRA_Accessions.tab | grep RUN | grep ${sra} | cut -f10 | cut -f1 -d_ | uniq`
echo $gsms
echo $gsms | wc

cd /bettik/fchuffar/datashare/${gse}/
for gsm in $gsms
do
  echo ${gsm}  
  srrs=`cat ~/projects/datashare/platforms/SRA_Accessions.tab | grep RUN | grep ${gsm} | cut -f1 | grep SRR | sort`
  echo raw/`echo $srrs | sed 's/ /_1\.fastq\.gz,raw\//g'`_1.fastq.gz raw/`echo $srrs | sed 's/ /_2\.fastq\.gz,raw\//g'`_2.fastq.gz > /bettik/fchuffar/datashare/${gse}/${gsm}_notrim_fqgz.info
done
# SR or PE?
ls -lha /bettik/fchuffar/datashare/${gse}/raw
cat *.info


## qc align count
# put wf on luke and luachn
rsync -auvP ~/projects/heatshock/ luke:~/projects/heatshock/
snakemake -s ~/projects/heatshock/results/${gse}/wf.py --cores 16 -pn
snakemake -s ~/projects/heatshock/results/${gse}/wf.py --cores 49 --cluster "oarsub --project epimed -l nodes=1/core={threads},walltime=6:00:00 " -pn


## get results
mkdir -p ~/projects/datashare/${gse}/raw/
rsync -auvP luke:/bettik/fchuffar/datashare/${gse}/raw/*.html ~/projects/datashare/${gse}/raw/
rsync -auvP luke:/bettik/fchuffar/datashare/${gse}/raw/multiqc_notrim* ~/projects/datashare/${gse}/raw/
rsync -auvP luke:/bettik/fchuffar/datashare/${gse}/*.txt ~/projects/datashare/${gse}/

