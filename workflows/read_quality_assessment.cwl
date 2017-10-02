class: Workflow
cwlVersion: v1.0
label: read_quality_assessment
inputs:
  - id: forward_reads
    type: File
    format: 'edam:format_1930'
  - id: reverse_reads
    type: File
    format: 'edam:format_1930'
outputs:
  - id: fastqc_report_reverse
    outputSource:
      - read_quality/fastqc_report_reverse
    type: File
  - id: fastqc_report_forward
    outputSource:
      - read_quality/fastqc_report_forward
    type: File
steps:
  - id: read_quality
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
    run: ../tools/fastq-qc.cwl
    label: fastQC version 0.11.5
    doc: >-
      Initial and cursory check for common issues arising as part of the
      sequencing process related to read quality. Separate reports generated for
      each lane x read.
requirements:
  - class: SubworkflowFeatureRequirement