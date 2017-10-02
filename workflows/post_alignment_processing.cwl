class: Workflow
cwlVersion: v1.0
label: post_alignment_processing
inputs:
  - id: known_indel_sites
    type: File
    secondaryFiles:
      - .tbi
  - id: reference_assembly
    type: File
    label: ref_assembly_build_hg19
    format: data_2340
    secondaryFiles:
      - .fai
      - ^.dict
  - id: target_sites
    type: File
    doc: bed file containing coordinates for intersection of exons and library
      captures sites.
    format: 'edam:format_3003'
  - id: dbsnp_ID
    type: File
  - id: bam
    type: File
outputs:
  - id: dedup_metrics
    outputSource: mark_duplicates/dedup_metrics
    type: File
  - id: recalibrated_bam
    outputSource: apply_recalibration/recalibrated_bam
    type: File
steps:
  - id: apply_recalibration
    in:
      - id: deduped_realigned_bam
        source:
          - perform_realignment/deduped_realigned_bam
      - id: recalibrated_table
        source:
          - base_quality_recalibration/recalibrated_table
      - id: reference_assembly
        source:
          - reference_assembly
      - id: target_sites
        source:
          - target_sites
    out:
      - id: recalibrated_bam
    run: ../tools/apply_bqsr.cwl
    label: gatk-printReads version 3.6
    doc: overwrite quality scores with re-calibrated values.
  - id: base_quality_recalibration
    in:
      - id: deduped_realigned_bam
        source:
          - perform_realignment/deduped_realigned_bam
      - id: reference_assembly
        source:
          - reference_assembly
      - id: target_sites
        source:
          - target_sites
      - id: dbsnp_ID
        source:
          - dbsnp_ID
    out:
      - id: recalibrated_table
    run: ../tools/bsqr.cwl
    label: gatk-baseRecalibrator version 3.6
    doc: recalibrate quality scores and export to a table. Recalibration performed by readgroup (representing sequencing lanes).
  - id: mark_duplicates
    in:
      - id: sorted_aligned_bam
        source:
          - samtools_index_cwl/sorted.bam
      - id: sorted_aligned_bam.ai
        source:
          - samtools_index_cwl/sorted.bam.ai
    out:
      - id: dedup_metrics
      - id: deduped_bam
    run: ../tools/mark_duplicates.cwl
    label: picard-markDuplicates
    doc: identify pcr duplicates and mark.
  - id: perform_realignment
    in:
      - id: deduped_bam
        source:
          - mark_duplicates/deduped_bam
      - id: interval_list
        source:
          - realign_intervals/realigned_intervals
      - id: reference_assembly
        source:
          - reference_assembly
    out:
      - id: deduped_realigned_bam
    run: ../tools/perform_realignment.cwl
    label: gatk-IndelRealigner version 3.6
    doc: perform realignment and generate new vcf with updated coords.
  - id: realign_intervals
    in:
      - id: deduped_bam
        source:
          - mark_duplicates/deduped_bam
      - id: known_indel_sites
        source:
          - known_indel_sites
      - id: reference_assembly
        source:
          - reference_assembly
      - id: target_sites
        source:
          - target_sites
    out:
      - id: realigned_intervals
    run: ../tools/realign_intervals.cwl
    label: gatk-RealignerTargetCreator version 3.6
    doc: dentify sites in need of realignment using known indel sites as a guide. Sites with high mutation levels also targeted for inspection and potential realignment.
  - id: samtools_view_cwl
    in:
      - id: bam
        source:
          - bam
    out:
      - id: sam
    run: ../tools/samtools-view.cwl
    label: samtools-view
  - id: samtools_sort_cwl
    in:
      - id: aligned.sam
        source:
          - samtools_view_cwl/sam
    out:
      - id: sorted.bam
    run: ../tools/samtools-sort.cwl
    label: samtools-sort
  - id: samtools_index_cwl
    in:
      - id: bam
        source:
          - samtools_sort_cwl/sorted.bam
    out:
      - id: sorted.bam.ai
      - id: sorted.bam
    run: ../tools/samtools-index.cwl
    label: samtools-index
requirements:
  - class: SubworkflowFeatureRequirement