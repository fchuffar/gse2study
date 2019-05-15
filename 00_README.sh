## data description
# https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE57397
#
# SRR1274635 GSM1382045  RNA-Seq analysis in HCT116 WT cells upon heat shock treatment replicate 1
# SRR1274636 GSM1382046  RNA-Seq analysis in HCT116 WT cells upon heat shock treatment replicate 2
# SRR1274637 GSM1382047  RNA-Seq analysis in HCT116 WT cells after recovery from heat shock treatment replicate 1
# SRR1274638 GSM1382048  RNA-Seq analysis in HCT116 WT cells after recovery from heat shock treatment replicate 2


## download fastq files
mkdir -p /bettik/fchuffar/datashare/GSE57397/raw
cd /bettik/fchuffar/datashare/GSE57397/raw
parallel-fastq-dump --threads 16 --tmpdir ./ --gzip --split-files --outdir ./ --sra-id SRR1274635
parallel-fastq-dump --threads 16 --tmpdir ./ --gzip --split-files --outdir ./ --sra-id SRR1274636
parallel-fastq-dump --threads 16 --tmpdir ./ --gzip --split-files --outdir ./ --sra-id SRR1274637
parallel-fastq-dump --threads 16 --tmpdir ./ --gzip --split-files --outdir ./ --sra-id SRR1274638
# SR or PE?
ls -lha /bettik/fchuffar/datashare/GSE57397/raw

## qc align count
# rsync -auvP ~/projects/heatshock/ luke:~/projects/heatshock/
cd /bettik/fchuffar/datashare/GSE57397/
echo raw/SRR1274635_1.fastq.gz > /bettik/fchuffar/datashare/GSE57397/SRR1274635_notrim_fqgz.info
echo raw/SRR1274636_1.fastq.gz > /bettik/fchuffar/datashare/GSE57397/SRR1274636_notrim_fqgz.info
echo raw/SRR1274637_1.fastq.gz > /bettik/fchuffar/datashare/GSE57397/SRR1274637_notrim_fqgz.info
echo raw/SRR1274638_1.fastq.gz > /bettik/fchuffar/datashare/GSE57397/SRR1274638_notrim_fqgz.info

# put wf on luke and luachn 

rsync -auvP ~/projects/heatshock/ luke:~/projects/heatshock/
snakemake -s ~/projects/heatshock/results/GSE57397/wf.py --cores 8 -pn


## get results
mkdir -p ~/projects/datashare/GSE57397/raw/
rsync -auvP luke:/bettik/fchuffar/datashare/GSE57397/raw/*.html ~/projects/datashare/GSE57397/raw/
rsync -auvP luke:/bettik/fchuffar/datashare/GSE57397/*.txt ~/projects/datashare/GSE57397/
rsync -auvP luke:~/projects/heatshock/results/GSE57397/multiqc_notrim* ~/projects/heatshock/results/GSE57397/.