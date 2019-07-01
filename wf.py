import os 
exec(open("config").read())

def get_files(src_dir, src_suffix, dest_dir, dest_suffix):
  files = [f for f in os.listdir(os.path.expanduser(src_dir)) if re.match("^.*"+src_suffix+"$", f)]
  files = [x.replace(src_suffix, dest_suffix) for x in files ]
  return [os.path.join(os.path.expanduser(dest_dir), f) for f in files]


localrules: target

rule target:
    threads: 1
    message: "-- Rule target completed. --"
    input: 
      fastqc_files = get_files("~/projects/datashare/"+gse+"/raw", ".fastq.gz", "~/projects/datashare/"+gse+"/raw", "_fastqc.zip"),
      blastn_files = get_files("~/projects/datashare/"+gse, "_notrim_fqgz.info", "~/projects/datashare/"+gse, "_telocentro.unmapblasted.txt.gz"),
      bam_files    = get_files("~/projects/datashare/"+gse, "_notrim_fqgz.info", "~/projects/datashare/"+gse, "_notrim_star_Homo_sapiens_hg19_Aligned.sortedByCoord.out.bam"),
      # bw_files     = get_files("~/projects/datashare/"+gse, "_notrim_fqgz.info", "~/projects/datashare/"+gse, "_notrim_star_Homo_sapiens_hg19_Aligned.sortedByCoord.out.bw"),
      ycount_files = get_files("~/projects/datashare/"+gse, "_notrim_fqgz.info", "~/projects/datashare/"+gse, "_notrim_star_Homo_sapiens_hg19_geneswchrm_strandedyes_classiccounts.txt")[1],
      ncount_files = get_files("~/projects/datashare/"+gse, "_notrim_fqgz.info", "~/projects/datashare/"+gse, "_notrim_star_Homo_sapiens_hg19_geneswchrm_strandedno_classiccounts.txt")[1],
      rcount_files = get_files("~/projects/datashare/"+gse, "_notrim_fqgz.info", "~/projects/datashare/"+gse, "_notrim_star_Homo_sapiens_hg19_geneswchrm_strandedreverse_classiccounts.txt")[1],

    shell:"""
multiqc --force -o ~/projects/datashare/"""+gse+"""/raw/ -n multiqc_notrim \
  ~/projects/datashare/"""+gse+"""/*_notrim_star_Homo_sapiens_hg19_Log.final.out \
  ~/projects/datashare/"""+gse+"""/raw/*_*_fastqc.zip \

echo workflow \"align_heatshock\" completed at `date` 
          """
rule fastqc:
    input:  fastqgz="{prefix}.fastq.gz"
    output: zip="{prefix}_fastqc.zip",
            html="{prefix}_fastqc.html"
    threads: 1
    shell:"""
    export PATH="/summer/epistorage/miniconda3/bin:$PATH"
    /summer/epistorage/miniconda3/bin/fastqc {input.fastqgz}
    """


rule trim_with_sickle_PE:
    input:
        fq_gz_f="{prefix}_R1_notrim.fastq.gz",
        fq_gz_r="{prefix}_R2_notrim.fastq.gz",
    output:
        t_fq_gz_f=protected("{prefix}_R1_sickle.fastq.gz"),
        t_fq_gz_r=protected("{prefix}_R2_sickle.fastq.gz"),
        t_fq_gz_s=protected("{prefix}_Sg_sickle.fastq.gz")
    threads: 1
    message:  "--- triming with sickle (Paired-End) ---"
    shell:"""
/summer/epistorage/miniconda3/bin/sickle  pe -g\
  -t sanger \
  -f {input.fq_gz_f} \
  -r {input.fq_gz_r} \
  -o {output.t_fq_gz_f} \
  -p {output.t_fq_gz_r} \
  -s {output.t_fq_gz_s}
    """

rule index_genome:
    input:
      genome_fasta=os.path.expanduser("~/projects/datashare/genomes/{species}/UCSC/{index}/Sequence/WholeGenomeFasta/genome.fa"), 
      gtf=os.path.expanduser("~/projects/datashare/genomes/{species}/UCSC/{index}/Annotation/Genes/geneswchrm.gtf"),
    output: directory(os.path.expanduser("~/projects/datashare/genomes/{species}/UCSC/{index}/Sequence/StarIndex"))
    #priority: 0
    threads: 8
    shell:    """
mkdir -p {output}
/summer/epistorage/miniconda3/bin/STAR \
  --runThreadN `echo "$(({threads} * 2))"` \
  --runMode genomeGenerate \
  --genomeDir {output} \
  --genomeFastaFiles  {input.genome_fasta} \
  --sjdbGTFfile {input.gtf} \
  --sjdbOverhang 100
    """

rule align_trimed:
    input:
      # fqgz_file="{prefix}/{sample}_{trim}.fastq.gz",
      # fastqc_file="{prefix}/{sample}_{trim}_fastqc.zip",
      fastqc_info="{prefix}/{sample}_{trim}_fqgz.info",
      star_index=os.path.expanduser("~/projects/datashare/genomes/{species}/UCSC/{index}/Sequence/StarIndex"),
      gtf=os.path.expanduser("~/projects/datashare/genomes/{species}/UCSC/{index}/Annotation/Genes/geneswchrm.gtf"),
    output:  "{prefix}/{sample}_{trim}_star_{species}_{index}_Aligned.sortedByCoord.out.bam"
    threads: 8
    shell:"""
cd {wildcards.prefix}
/summer/epistorage/miniconda3/bin/STAR \
  --runThreadN `echo "$(({threads} * 2))"` \
  --genomeDir  {input.star_index} \
  --sjdbGTFfile {input.gtf} \
  --readFilesCommand gunzip -c \
  --readFilesIn `cat {input.fastqc_info}` \
  --outFileNamePrefix {wildcards.prefix}/{wildcards.sample}_{wildcards.trim}_star_{wildcards.species}_{wildcards.index}_ \
  --outReadsUnmapped Fastx \
  --outSAMtype BAM SortedByCoordinate
/summer/epistorage/miniconda3/bin/samtools index {output}
    """
              
rule count_classic:
    input:
      bam_file="{prefix}/{sample}_{trim}_star_{species}_{index}_Aligned.sortedByCoord.out.bam",
      gtf_file= os.path.expanduser("~/projects/datashare/genomes/{species}/UCSC/{index}/Annotation/Genes/{gtf_prefix}.gtf")
    output: "{prefix}/{sample}_{trim}_star_{species}_{index}_{gtf_prefix}_stranded{stranded}_classiccounts.txt"
    priority: 50
    threads: 1
    shell:"""
/summer/epistorage/miniconda3/bin/htseq-count -t exon -f bam -r pos --stranded={wildcards.stranded} -m intersection-strict --nonunique none \
  {input.bam_file} \
  {input.gtf_file} \
  > {output}
    """

rule count_rmdup_stranded:
    input:
      bam_file="{prefix}/{sample}_{trim}_star_{species}_{index}_Aligned.sortedByCoord.out.rmdup.bam",
      gtf_file= os.path.expanduser("~/projects/datashare/genomes/{species}/UCSC/{index}/Annotation/Genes/{gtf_prefix}.gtf")
    output: "{prefix}/{sample}_{trim}_star_{species}_{index}_{gtf_prefix}_stranded{stranded}_rmdupcounts.txt"
    priority: 50
    threads: 1
    shell:"""
/summer/epistorage/miniconda3/bin/htseq-count -t exon -f bam -r pos --stranded={wildcards.stranded} -m intersection-strict --nonunique none \
  {input.bam_file} \
  {input.gtf_file} \
  > {output}
    """




rule rmdup_bam:
    input: "{prefix}/{sample}_{trim}_star_{species}_{index}_Aligned.sortedByCoord.out.bam",
    output: "{prefix}/{sample}_{trim}_star_{species}_{index}_Aligned.sortedByCoord.out.rmdup.bam"
    threads: 4
    shell:"""
cd {wildcards.prefix}
mkdir -p {wildcards.prefix}/tmp
java -Djava.io.tmpdir={wildcards.prefix}/tmp -jar /summer/epistorage/miniconda3/share/picard-2.14-0/picard.jar \
  MarkDuplicates \
  I={input} \
  O={output} \
  REMOVE_DUPLICATES=TRUE \
  CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT M={wildcards.prefix}/{wildcards.sample}_{wildcards.trim}_star_{wildcards.species}_{wildcards.index}_output.metrics  2>&1>/dev/null
samtools index {output}
    """




rule bigwig_coverage:
    input:
      bam_file="{prefix}/{sample}_{trim}_star_{species}_{index}_Aligned.sortedByCoord.out.bam",
    output: "{prefix}/{sample}_{trim}_star_{species}_{index}_Aligned.sortedByCoord.out.bw"
    threads: 4
    shell:"""
/summer/epistorage/miniconda3/bin/bamCoverage \
  -b {input.bam_file} \
  --numberOfProcessors `echo "$(({threads} * 2))"` \
  --binSize 10 \
  --minMappingQuality 30 \
  --normalizeUsingRPKM \
  -o {output}
    """
    
    

rule compile_blastdb:
    input: os.path.expanduser("~/projects/heatshock/data/{subject}.fasta")
    output: os.path.expanduser("~/projects/heatshock/data/{subject}.blast.db")
    threads: 1
    shell:"""
/summer/epistorage/miniconda3/bin/makeblastdb -in {input} -dbtype nucl -parse_seqids -out {output}
touch {output}
    """
    
rule blastn_ggaat:
    input:
      blast_db=os.path.expanduser("~/projects/heatshock/data/{subject}.blast.db"),
      query_fqgz="{prefix}/{sample}_1.fastq.gz",
    output: "{prefix}/{sample}_{subject}.blasted.txt.gz"
    threads: 1
    shell:"""
gunzip -c {input.query_fqgz} | /summer/epistorage/miniconda3/bin/seqtk seq -A | 
/summer/epistorage/miniconda3/bin/blastn -db {input.blast_db} -num_threads=1 -query - -outfmt "10 std sstrand" -evalue 10 -task blastn-short -word_size 8 -perc_identity 100 -qcov_hsp_perc 1  2>/dev/null | gzip  > {output}
    """


rule blastn_unmapped_ggaat:
    input:
      blast_db=os.path.expanduser("~/projects/heatshock/data/{subject}.blast.db"),
      query_fqgz="{prefix}/{sample}_notrim_star_Homo_sapiens_hg19_Unmapped.out.mate1",
    output: "{prefix}/{sample}_{subject}.unmapblasted.txt.gz"
    threads: 1
    shell:"""
cat {input.query_fqgz} | /summer/epistorage/miniconda3/bin/seqtk seq -A | 
/summer/epistorage/miniconda3/bin/blastn -db {input.blast_db} -num_threads=1 -query - -outfmt "10 std sstrand" -evalue 10 -task blastn-short -word_size 8 -perc_identity 100 -qcov_hsp_perc 1  2>/dev/null | gzip  > {output}
    """

