class: Workflow
cwlVersion: v1.0
requirements:
  - class: SubworkflowFeatureRequirement
  - class: ScatterFeatureRequirement
doc: WES pipeline with workflow managed by Bpipe. Auditing and logs generated and managed by Bpipe.
label: Detect Variants workflow
inputs:
  - id: forward_reads
    type: File
    format: 'edam:format_1930'
  - id: known_indel_sites
    type: File
  - id: known_snp_sites
    type: File
    format: data_1106
    secondaryFiles:
      - .tbi
  - id: reference_assembly
    type: File
    label: ref_assembly_buildhg19
    format: data_2340
    secondaryFiles:
      - .fai
      - ^.dict
  - id: reference_assembly_2
    type: File
    doc: This is used by VEP.
  - id: reverse_reads
    type: File
    format: 'edam:format_1930'
  - id: target_sites
    type: File
    doc: 
      bed File containing coordinates for intersection of exons and library
      captures sites.
    format: 'edam:format_3003'
  - id: vep_cache
    type: File
    doc: database of annotations.
  - id: capture_coverage
    type: File
  - id: intersect.bed
    type: File
outputs:
  - id: fastqc_report_forward
    outputSource: read_quality_assessment/fastqc_report_forward
    type: File
  - id: fastqc_report_reverse
    outputSource: read_quality_assessment/fastqc_report_reverse
    type: File
  - id: summary.md
    outputSource:
      - generate_quality_metrics_cwl/summary.md
    type: File
  - id: on_target.txt
    outputSource:
      - generate_quality_metrics_cwl/on_target.txt
    type: File
  - id: karyotype.tsv
    outputSource:
      - generate_quality_metrics_cwl/karyotype.tsv
    type: File
  - id: gzip.gz_1
    outputSource:
      - generate_quality_metrics_cwl/gzip.gz_1
    type: File
  - id: gzip.gz
    outputSource:
      - generate_quality_metrics_cwl/gzip.gz
    type: File
  - id: fragments.tsv
    outputSource:
      - generate_quality_metrics_cwl/fragments.tsv
    type: File
  - id: insert_size_metrics.pdf
    outputSource:
      - generate_quality_metrics_cwl/insert_size_metrics.pdf
    type: File
steps:
  - id: post_alignment_processing
    in:
      - id: aligned_merged_bam
        source:
          - read_alignment/aligned_merged_bam
      - id: known_indel_sites
        source:
          - known_indel_sites
      - id: reference_assembly
        source:
          - reference_assembly
      - id: target_sites
        source:
          - target_sites
      - id: dbsnp_ID
        source:
          - known_snp_sites
    out:
      - id: dedup_metrics
      - id: recalibrated_bam
    run: post_alignment_processing.cwl
    label: post_alignment_processing
  - id: post_annotation_processing
    in:
      - id: reference_assembly
        source:
          - reference_assembly
      - id: post_anno_vcf
        source:
          - variant_annotation/vep_annotated_vcf
    out:
      - id: transcript_Filetered_table
    run: post_annotation_processing.cwl
    label: post_annotation_processing
  - id: post_variant_processing
    in:
      - id: raw_variants_g_gvcf
        source:
          - variant_calling/raw_variants_g_gvcf
      - id: reference_assembly
        source:
          - reference_assembly
    out:
      - id: normalized_g_vcf
    run: post_variant_processing.cwl
    label: post_variant_processing
  - id: read_alignment
    in:
      - id: forward_reads
        source:
          - forward_reads
      - id: reference_assembly
        source:
          - reference_assembly
      - id: reverse_reads
        source:
          - reverse_reads
    out:
      - id: aligned_merged_bam
    run: read_alignment.cwl
    label: read_alignment
  - id: read_quality_assessment
    in:
      - id: forward_reads
        source:
          - forward_reads
      - id: reverse_reads
        source:
          - reverse_reads
    out:
      - id: fastqc_report_forward
      - id: fastqc_report_reverse
    run: read_quality_assessment.cwl
    label: read_quality_assessment
  - id: variant_annotation
    in:
      - id: normalized_g_vcf
        source:
          - post_variant_processing/normalized_g_vcf
      - id: reference_assembly_2
        source:
          - reference_assembly_2
      - id: vep_cache
        source:
          - vep_cache
    out:
      - id: vep_annotated_vcf
    run: variant_annotation.cwl
    label: variant_annotation
  - id: variant_calling
    in:
      - id: known_snp_sites
        source:
          - known_snp_sites
      - id: recalibrated_bam
        source:
          - post_alignment_processing/recalibrated_bam
      - id: reference_assembly
        source:
          - reference_assembly
      - id: target_sites
        source:
          - target_sites
    out:
      - id: raw_variants_g_gvcf
    run: variant_calling.cwl
    label: variant_calling
  - id: generate_quality_metrics_cwl
    in:
      - id: recalibrated.bam
        source:
          - post_alignment_processing/recalibrated_bam
      - id: target_sites
        source:
          - target_sites
      - id: intersect.bed
        source:
          - intersect.bed
      - id: dedup_metrics
        source:
          - post_alignment_processing/dedup_metrics
      - id: capture_coverage
        source:
          - capture_coverage
    out:
      - id: gzip.gz
      - id: on_target.txt
      - id: karyotype.tsv
      - id: gzip.gz_1
      - id: fragments.tsv
      - id: summary.md
      - id: summary.htm
      - id: coverage
      - id: insert_size_metrics.txt
      - id: insert_size_metrics.pdf
    run: generate_quality_metrics.cwl
    label: generate_quality_metrics
  - id: lovd_cwl
    in:
      - id: table
        source:
          - post_annotation_processing/transcript_Filetered_table
      - id: insert_size_metrics
        source:
          - generate_quality_metrics_cwl/insert_size_metrics.txt
      - id: depth_of_coverage
        source:
          - generate_quality_metrics_cwl/coverage
      - id: stage_report
        source:
          - generate_quality_metrics_cwl/summary.htm
    out:
      - id: table2
    run: ../tools/lovd.cwl
    label: LOVD+
