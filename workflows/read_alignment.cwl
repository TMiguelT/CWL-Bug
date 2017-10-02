class: Workflow
cwlVersion: v1.0
label: read_alignment
inputs:
  - id: forward_reads
    type: File
    format: 'edam:format_1930'
  - id: reference_assembly
    type: File
    label: ref_assembly_buildhg19
    format: data_2340
    secondaryFiles:
      - .fai
      - ^.dict
  - id: reverse_reads
    type: File
    format: 'edam:format_1930'
outputs:
  - id: aligned_merged_bam
    outputSource: merge_alignments/aligned_merged_bam
    type: File
steps:
  - id: align_to_ref
    in:
      - id: forward_reads.gz
        source:
          - forward_reads
      - id: reference_assembly.fasta
        source:
          - reference_assembly
      - id: reverse_reads.gz
        source:
          - reverse_reads
    out:
      - id: ref_aligned_bam
    run: ../tools/align.cwl
    label: bwa-mem version 0.7.13
    doc: >-
      align a sequencing lane to the reference assembly using bwa-mem algorithm.
      mem does not perform local realignment.
  - id: merge_alignments
    in:
      - id: sorted.bam
        source:
          - align_to_ref/ref_aligned_bam
    out:
      - id: aligned_merged_bam
    run: ../tools/merge_alignments.cwl
    label: picard-mergSamFiles v2.6.0
    doc: merge individual alignments representing sequencing lanes.
requirements:
  - class: SubworkflowFeatureRequirement