#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

process indexing {
    input:
    tuple path(reference), path(gtf)

    output:
    path("index*")

    script:
    """
    STAR --runThreadN 16 --runMode genomeGenerate --genomeDir index --genomeFastaFiles $reference --sjdbGTFfile $gtf --sjdbOverhang 100 --genomeSAindexNbases 12
    """
    
}