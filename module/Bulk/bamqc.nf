#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

process bamqc {
    input:
    path(bam_path)

    output:
    path "*"

    script:
    """
    qualimap bamqc -bam $bam_path -outdir ./${bam_path.baseName}/ -outformat pdf
    """
}
