#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

process bamqc {
    input:
    tuple path(bam_path)

    output:
    path "*"

    script:
    """
    qualimap bamqc -bam $bam_path -outdir ./${bam_path}/ -outformat pdf
    """
}
