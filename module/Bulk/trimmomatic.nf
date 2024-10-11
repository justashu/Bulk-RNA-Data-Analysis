#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

process trimmomatic {
    input:
    tuple val(id), path(reads) // Paired-end reads

    output:
    tuple val(id), path("trimmed_${id}_*") // Trimmed output

    script:
    """
    trimmomatic PE -threads 4 \\
    ${reads[0]} ${reads[1]} \\
    trimmed_${id}_1.fastq.gz unpaired_R1.fastq.gz \\
    trimmed_${id}_2.fastq.gz unpaired_R2.fastq.gz \\
    ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

    gzip -d trimmed_${id}_1.fastq.gz
    gzip -d trimmed_${id}_2.fastq.gz
    """
}
