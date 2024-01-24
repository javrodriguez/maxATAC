#!/bin/bash
#SBATCH-J maxatac_predict
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8 
#SBATCH --mem-per-cpu=8G
#SBATCH --output=logs-prediction/%J.out
#SBATCH --error=logs-prediction/%J.err

################################################################################
bigwig=$(awk "NR==${SLURM_ARRAY_TASK_ID} {print \$1}" sample_sheet_predict.txt)
outname=$(awk "NR==${SLURM_ARRAY_TASK_ID} {print \$2}" sample_sheet_predict.txt)
################################################################################

echo $bigwig
echo $outname

module purge
module load condaenvs/gpu/maxatac
module add openssl/1.0.2

maxatac predict -tf CTCF  \
  --signal $bigwig \
  -o $outname \
  --sequence /gpfs/home/rodrij92/opt/maxatac/data/hg38/hg38.2bit \
  --blacklist /gpfs/home/rodrij92/opt/maxatac/data/hg38/hg38_maxatac_blacklist.bed \
  --chromosome_sizes /gpfs/home/rodrij92/opt/maxatac/data/hg38/hg38.chrom.sizes \
  #--chromosomes chr1
