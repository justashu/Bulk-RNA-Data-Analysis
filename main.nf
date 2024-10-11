#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { indexing } from './module/Bulk/indexing'
include { alignment } from './module/Bulk/alignment'
include { generateCountMatrix } from './module/Bulk/generateCountMatrix'
include { fastqc } from './module/Bulk/fastqc'
include { fastqc_forTrimming} from './module/Bulk/fastqc_forTrimming' 
include { multiqc } from './module/Bulk/multiqc'
include { multiqc_forTrimming} from './module/Bulk/multiqc_forTrimming'
include { trimmomatic } from './module/Bulk/trimmomatic'

workflow {
    // 1. Indexing step
    indexing([params.reference, params.gtf]).set { index_dir }

    // 2. Load FASTQ files (paired-end)
    Channel.fromFilePairs(params.fastq_path).set { fastqFiles }

    // 3. Pre-trim FastQC on raw FASTQ files
    fastqFiles | fastqc | multiqc

    // 6. Alignment step using the indexed genome and trimmed FASTQ files
    if (params.trimming == true) {
        // 4. Trimming step (Trimmomatic)
        fastqFiles | trimmomatic | set { trimmedFiles }

        // 5. Post-trim FastQC on trimmed FASTQ files
        trimmedFiles | fastqc_forTrimming | multiqc_forTrimming

        alignment(index_dir, trimmedFiles).set { bam }
        }
    else {
        alignment(index_dir, fastqFiles).set { bam }
    }

    // 7. Generate count matrix using the BAM files and the GTF
    generateCountMatrix(bam, params.gtf).set { countMatrix }

}
