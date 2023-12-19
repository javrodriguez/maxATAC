#!/bin/bash
#SBATCH -J maxatac_predict
#SBATCH --mem=50gb
#SBATCH --time=48:00:00
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

#module load anaconda3/gpu/5.2.0
#conda activate maxatac
#module unload anaconda3/gpu/5.2.0

maxatac predict -tf CTCF  \
  --signal $bigwig \
  -o $outname \
  --sequence /gpfs/home/rodrij92/opt/maxatac/data/hg38/hg38.2bit \
  --blacklist /gpfs/home/rodrij92/opt/maxatac/data/hg38/hg38_maxatac_blacklist.bed \
  --chromosome_sizes /gpfs/home/rodrij92/opt/maxatac/data/hg38/hg38.chrom.sizes
