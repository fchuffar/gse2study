cd ~/projects/lfs_patients_fibroblast/results/rnaseq_lfs3_integragen
source config
echo $gse
echo $project

ssh cargo

## Transfering files
mkdir -p /bettik/chuffarf/geo_submission/${project}/${gse}/fastq
mkdir -p /bettik/chuffarf/geo_submission/${project}/${gse}/counts
cd ~/projects/datashare/${gse}/
# counts
ls -lha *_${gtf_prefix}_stranded${strand}_classiccounts.txt
rsync -auvP --copy-links \
  ~/projects/datashare/${gse}/*_${gtf_prefix}_stranded${strand}_classiccounts.txt \
  /bettik/chuffarf/geo_submission/${project}/${gse}/counts
# fastq
ls -lha raw/*1.fastq.gz raw/*2.fastq.gz
rsync -auvP --copy-links \
  ~/projects/datashare/${gse}/raw/*1.fastq.gz \
  ~/projects/datashare/${gse}/raw/*2.fastq.gz \
  /bettik/chuffarf/geo_submission/${project}/${gse}/fastq/.
# check
ls -lha /bettik/chuffarf/geo_submission/${project}/
ls -lha /bettik/chuffarf/geo_submission/${project}/${gse}
ls -lha /bettik/chuffarf/geo_submission/${project}/${gse}/fastq/
ls -lha /bettik/chuffarf/geo_submission/${project}/${gse}/counts/

# MD5
MD5BETTIKFQFILE=~/projects/datashare/${gse}/raw/md5.bettik.txt
ls ${MD5BETTIKFQFILE}
MD5GEOFQFILE=/bettik/chuffarf/geo_submission/${project}/md5.${gse}.fq.geo.txt
MD5GEOcntFILE=/bettik/chuffarf/geo_submission/${project}/md5.${gse}.cnt.geo.txt
cd /bettik/chuffarf/geo_submission/${project}/${gse}/fastq
md5sum *.fastq.gz > ${MD5GEOFQFILE}
cat ${MD5BETTIKFQFILE} | cut -f1 -d" " | sort > /tmp/tmp.${gse}.fq.md5.bettik.txt
cat ${MD5GEOFQFILE} | cut -f1 -d" " | sort > /tmp/tmp.${gse}.fq.md5.geo.txt
diff /tmp/tmp.${gse}.fq.md5.geo.txt /tmp/tmp.${gse}.fq.md5.bettik.txt
cd /bettik/chuffarf/geo_submission/${project}/${gse}/counts
md5sum *.txt > ${MD5GEOcntFILE}

ls -lha /bettik/chuffarf/geo_submission/${project}/
ls -lha /bettik/chuffarf/geo_submission/${project}/${gse}/
ls -lha /bettik/chuffarf/geo_submission/${project}/${gse}/fastq/
ls -lha /bettik/chuffarf/geo_submission/${project}/${gse}/counts/

# Put metadata
source ~/conda_config.sh 
conda activate rnaseq_env
cd ~/projects/${project}/results/${gse}/geo_submission
Rscript generate_metadata.R 
echo "rmarkdown::render('../10_material_and_methods.Rmd')" | Rscript -

rsync -auvP cargo:~/projects/${project}/results/${gse}/geo_submission/0*_*.xlsx ~/projects/${project}/results/${gse}/geo_submission/.
rsync -auvP cargo:~/projects/${project}/results/${gse}/10_material_and_methods.html ~/projects/${project}/results/${gse}/.


# localy 
cd ~/projects/${project}/results/${gse}/geo_submission
# wget https://www.ncbi.nlm.nih.gov/geo/info/examples/seq_template.xlsx
open seq_template.xlsx

# Put on GEO
# Login in # https://www.ncbi.nlm.nih.gov/geo/info/seq.html
# Login Era Account > Sign in – Research Organizations > UGA > submit dataset > Submit high-throughput sequencing (HTS)
# Login Era Account > Sign in – Research Organizations > UGA > submit dataset > Submit high-throughput sequencing (HTS)
# https://www.ncbi.nlm.nih.gov/geo/info/submissionftp.html
# get that:
#    1. personalized upload space uploads/florent.chuffart@univ-grenoble-alpes.fr_XXXHASHXXX
#    2. host address	ftp-private.ncbi.nlm.nih.gov
#    3. username	geoftp
#    4. password	XXXpasswrdXXX
# from your screen on cargo:
personalized_upload_space="uploads/florent.chuffart@univ-grenoble-alpes.fr_XXXHASHXXX"
host_address="ftp-private.ncbi.nlm.nih.gov"
username="geoftp"
password="XXXpasswrdXXX"
cd /bettik/chuffarf/geo_submission/${project}/
lftp -e "mirror -R ${gse} ${personalized_upload_space}/${gse} " -u ${username},${password} ${host_address}
# then Upload metadata file in https://submit.ncbi.nlm.nih.gov/geo/submission/meta/
