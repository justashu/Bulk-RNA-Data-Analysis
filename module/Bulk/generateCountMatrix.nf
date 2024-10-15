#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

process generateCountMatrix {
    input:
    path bam_file
    path gtf

    output:
    path "counts.txt"

    script:
    """
    featureCounts -T 16 -a $gtf -o counts.txt $bam_file
    """
}