cd ~/projects/aml_simon/results/rnaseq_julie_integragen
source config
echo $gse
echo $project
rsync -auvP ~/projects/${project}/results/${gse}/ cargo:~/projects/${project}/results/${gse}/
## data description

# chuffarf@f-dahu:~$ ls -lha projects/datashare_epistorage/rnaseq_julie_integragen/raw/c3po-mondet-download/PJ2110424/RAWDATA/
# total 32G
# drwxr-xr-x 2 chuffarf l-iab 4.0K Dec 17 07:58 .
# drwxr-xr-x 3 chuffarf l-iab 4.0K Dec 15 12:19 ..
# -rw-r--r-- 1 chuffarf l-iab 3.0G Dec 15 12:20 HEL_R1.fastq.gz
# -rw-r--r-- 1 chuffarf l-iab 3.1G Dec 15 12:20 HEL_R2.fastq.gz
# -rw-r--r-- 1 chuffarf l-iab 3.2G Dec 15 12:20 HL60_R1.fastq.gz
# -rw-r--r-- 1 chuffarf l-iab 3.2G Dec 15 12:20 HL60_R2.fastq.gz
# -rw-r--r-- 1 chuffarf l-iab 3.5G Dec 15 12:20 K562_R1.fastq.gz
# -rw-r--r-- 1 chuffarf l-iab 3.6G Dec 15 12:20 K562_R2.fastq.gz
# -rw-r--r-- 1 chuffarf l-iab 3.1G Dec 15 12:20 KG1_R1.fastq.gz
# -rw-r--r-- 1 chuffarf l-iab 3.1G Dec 15 12:20 KG1_R2.fastq.gz
# -rw-r--r-- 1 chuffarf l-iab 2.9G Dec 15 12:20 OCI-AML3_R1.fastq.gz
# -rw-r--r-- 1 chuffarf l-iab 2.9G Dec 15 12:20 OCI-AML3_R2.fastq.gz
# -rw-r--r-- 1 chuffarf l-iab  514 Dec 15 12:47 md5sum.bettik.txt
# -rw-r--r-- 1 chuffarf l-iab  514 Dec 17 07:59 md5sum.summer.txt
# -rw-r--r-- 1 chuffarf l-iab  504 Dec 17 07:42 md5sum.txt


# fastq.gz files 
cd ~/projects/${datashare}/${gse}/raw
ls -lha c3po-mondet-download/PJ2110424/RAWDATA/*.fastq.gz .
ln -s c3po-mondet-download/PJ2110424/RAWDATA/HEL_R1.fastq.gz      HEL_R1.fastq.gz
ln -s c3po-mondet-download/PJ2110424/RAWDATA/HEL_R2.fastq.gz      HEL_R2.fastq.gz
ln -s c3po-mondet-download/PJ2110424/RAWDATA/HL60_R1.fastq.gz     HL6_R1.fastq.gz
ln -s c3po-mondet-download/PJ2110424/RAWDATA/HL60_R2.fastq.gz     HL6_R2.fastq.gz
ln -s c3po-mondet-download/PJ2110424/RAWDATA/K562_R1.fastq.gz     K56_R1.fastq.gz
ln -s c3po-mondet-download/PJ2110424/RAWDATA/K562_R2.fastq.gz     K56_R2.fastq.gz
ln -s c3po-mondet-download/PJ2110424/RAWDATA/KG1_R1.fastq.gz      KG1_R1.fastq.gz
ln -s c3po-mondet-download/PJ2110424/RAWDATA/KG1_R2.fastq.gz      KG1_R2.fastq.gz
ln -s c3po-mondet-download/PJ2110424/RAWDATA/OCI-AML3_R1.fastq.gz OCI_R1.fastq.gz
ln -s c3po-mondet-download/PJ2110424/RAWDATA/OCI-AML3_R2.fastq.gz OCI_R2.fastq.gz

# SR or PE?
ls -lha ~/projects/${datashare}/${gse}/raw
sequencing_read_type=PE

cd ~/projects/${datashare}/${gse}/
echo raw/HEL_R1.fastq.gz raw/HEL_R2.fastq.gz > HEL_notrim_fqgz.info
echo raw/HL6_R1.fastq.gz raw/HL6_R2.fastq.gz > HL6_notrim_fqgz.info
echo raw/K56_R1.fastq.gz raw/K56_R2.fastq.gz > K56_notrim_fqgz.info
echo raw/KG1_R1.fastq.gz raw/KG1_R2.fastq.gz > KG1_notrim_fqgz.info
echo raw/OCI_R1.fastq.gz raw/OCI_R2.fastq.gz > OCI_notrim_fqgz.info
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
