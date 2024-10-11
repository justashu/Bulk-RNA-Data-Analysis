#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

process fastqc {
    input:
    tuple val(id), path(fastq_files)

    output:
    path "*_fastqc.html"
    path "*_fastqc.zip"

    script:
    """
    fastqc ${fastq_files} -o ./
    """
}
