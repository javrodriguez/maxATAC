#!/usr/bin/env bash
#SBATCH --job-name=maxatac-prepare
#SBATCH --output=logs-prepare/%x-%j.out
#SBATCH --error=logs-prepare/%x-%j.err
#SBATCH --mem-per-cpu=3G
#SBATCH --cpus-per-task=8
#SBATCH --time=24:00:00

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

#module load anaconda3/gpu/5.2.0
#conda activate maxatac
#module unload anaconda3/gpu/5.2.0
#export PATH=/gpfs/share/apps/ucscutils/374:$PATH

maxatac prepare \
    --chrom_sizes /gpfs/home/rodrij92/opt/maxatac/data/hg38/hg38.chrom.sizes \
    --blacklist_bed /gpfs/home/rodrij92/opt/maxatac/data/hg38/hg38_maxatac_blacklist.bed \
    --blacklist /gpfs/home/rodrij92/opt/maxatac/data/hg38/hg38_maxatac_blacklist.bw \
    -skip_dedup \
    --threads "$SLURM_CPUS_PER_TASK" \
    -i $bam -o $outname -prefix $fname
