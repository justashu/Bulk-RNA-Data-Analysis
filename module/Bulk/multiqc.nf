#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

process multiqc {
    input:
    path fastqc_html
    path fastqc_results_zip

    output:
    path "multiqc_report.html"
    path "multiqc_data"

    script:
    """
    multiqc ./ 
    """
}
