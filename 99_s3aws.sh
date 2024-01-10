source config
echo $gse
echo $project

source ~/conda_config.sh 
conda create -n s3aws_env
conda activate s3aws_env

aws --version
aws configure

mkdir mkdir -p ~/projects/datashare/${gse}/raw
cd ~/projects/datashare/${gse}/raw
ls -lha ~/projects/datashare/${gse}/raw

BUCKETNAME="TO_BE_DEFINE_THERE"
aws s3 ls s3://${BUCKETNAME}/ 
aws s3 cp s3://${BUCKETNAME}/ ~/projects/datashare/${gse}/raw --recursive
