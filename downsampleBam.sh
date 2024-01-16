#!/usr/bin/env bash
#SBATCH --job-name=dwnsampbam
#SBATCH --output=logs-downsample/%x-%j.out
#SBATCH --error=logs-downsample/%x-%j.err
#SBATCH --time=12:00:00
#SBATCH -N 1

reads=40000000
ID=$(awk "NR==${SLURM_ARRAY_TASK_ID} {print \$1}" ids.txt)

module load samtools

echo $ID

cd $ID

#samtools view -c -F 1548 -f 3 *_atacseq_gdc_realn.bam
samtools view -b -F 1548 -f 3 *_atacseq_gdc_realn.bam > atac_filtered.bam
samtools index atac_filtered.bam

fraction=$(samtools idxstats atac_filtered.bam | cut -f3 | awk -v ct=$reads 'BEGIN {total=0} {total += $1} END {print ct/total}')
samtools view -b -s ${fraction} atac_filtered.bam > atac_filtered_ds40M.bam
samtools flagstat atac_filtered_ds40M.bam
