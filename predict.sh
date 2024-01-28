#!/bin/bash
#SBATCH-J maxatac_predict
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8 
#SBATCH --mem-per-cpu=8G
#SBATCH --output=logs-predict/%J.out
#SBATCH --error=logs-predict/%J.err

################################################################################
bigwig=$(awk "NR==${SLURM_ARRAY_TASK_ID} {print \$1}" sample_sheet_predict.txt)
outname=$(awk "NR==${SLURM_ARRAY_TASK_ID} {print \$2}" sample_sheet_predict.txt)
################################################################################

echo $bigwig
echo $outname

module purge
module load condaenvs/gpu/maxatac
module add openssl/1.0.2

if  ! test -f $bigwig; then
  echo "Input bigwig is not available. Stopping,"; exit 1
fi

if  test -f ./${outname}/maxatac_predict_32bp.bed && test -f ./${outname}/maxatac_predict.bw; then
  echo "Output bigwig and bed files are already available. Stopping."; exit 1
fi

maxatac predict -tf CTCF  \
  --signal $bigwig \
  -o $outname \
  --sequence /gpfs/home/rodrij92/opt/maxatac/data/hg38/hg38.2bit \
  --blacklist /gpfs/home/rodrij92/opt/maxatac/data/hg38/hg38_maxatac_blacklist.bed \
  --chromosome_sizes /gpfs/home/rodrij92/opt/maxatac/data/hg38/hg38.chrom.sizes
