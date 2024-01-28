#!/usr/bin/env bash
#SBATCH --job-name=maxatac-prepare
#SBATCH --output=logs-prepare/%x-%j.out
#SBATCH --error=logs-prepare/%x-%j.err
#SBATCH --mem-per-cpu=6G
#SBATCH --cpus-per-task=8
#SBATCH --time=6:00:00

#####################################################################
bam=$(awk "NR==${SLURM_ARRAY_TASK_ID} {print \$1}" sample_sheet_prepare.txt)
outname=$(awk "NR==${SLURM_ARRAY_TASK_ID} {print \$2}" sample_sheet_prepare.txt)
fname=$(awk "NR==${SLURM_ARRAY_TASK_ID} {print \$3}" sample_sheet_prepare.txt)

#####################################################################

echo $bam
echo $outname

module purge
module load condaenvs/gpu/maxatac
module add openssl/1.0.2

if  !test -f $bam; then
  echo "Inpu bam file not available. Stopping."; exit 1
fi


if  test -f ./${outname}/${fname}_IS_slop20_RP20M_minmax01.bw; then
  echo "Bigwig file already available. Stopping."; exit 1
fi

maxatac prepare \
    --chrom_sizes /gpfs/home/rodrij92/opt/maxatac/data/hg38/hg38.chrom.sizes \
    --blacklist_bed /gpfs/home/rodrij92/opt/maxatac/data/hg38/hg38_maxatac_blacklist.bed \
    --blacklist /gpfs/home/rodrij92/opt/maxatac/data/hg38/hg38_maxatac_blacklist.bw \
    -skip_dedup \
    --threads "$SLURM_CPUS_PER_TASK" \
    -i $bam -o $outname -prefix $fname
