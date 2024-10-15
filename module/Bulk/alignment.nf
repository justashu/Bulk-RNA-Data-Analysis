#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

process alignment {
    input:
    path index_dir 
    tuple val(sample), path(fastqFiles)
    
    // fastqFiles -> paired-end FASTQ files
    // index_dir -> the index directory from the previous step

    output:
    path "${sample}*.Aligned.sortedByCoord.out.bam"

    script:
    """
	STAR --runThreadN 16 \
        --genomeDir $index_dir \
        --readFilesIn ${fastqFiles[0]} \
        --outSAMtype BAM SortedByCoordinate \
        --outFileNamePrefix ${sample}1.
    STAR --runThreadN 16 \
        --genomeDir $index_dir \
        --readFilesIn ${fastqFiles[1]} \
        --outSAMtype BAM SortedByCoordinate \
        --outFileNamePrefix ${sample}2.
    """
}