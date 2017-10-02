class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - GenomeAnalysisTK.jar
  - '-T'
  - BaseRecalibrator
inputs:
  - format: 'http://edamontology.org/format_2572'
    id: deduped_realigned_bam
    type: File
    secondaryFiles:
      - bam.ai
  - format: 'http://edamontology.org/format_XXXX'
    id: reference_assembly
    type: File
    inputBinding:
      position: 0
      valueFrom: /ref/reference_assembly
    secondaryFiles:
      - .fai
      - .bwt
      - .sa
      - .ann
      - .amb
      - .pac
      - .alt
  - format: 'http://edamontology.org/format_3003'
    id: target_sites
    type: File
    inputBinding:
      position: 0
      valueFrom: /ref/target_sites
    doc: bed file containing the coordinates for genes/regions to be targeted.
  - id: dbsnp_ID
    type: File
    inputBinding:
      position: 0
outputs:
  - id: recalibrated_table
    type: File
    outputBinding: {}
    format: null
doc: |
  https://bio.tools/tool/gatk2_base_recalibrator-/version/none
label: Calculate recalibration values for base recalibration.
arguments:
  - position: 0
    prefix: interval_padding
    separate: false
    valueFrom: =25
  - position: 0
    prefix: known_sites
    separate: false
    valueFrom: =dbsnp_138
  - position: 0
    prefix: cov
    valueFrom: =ReadGroupCovariate
  - position: 0
    prefix: cov
    valueFrom: =QualityScoreCovariate
  - position: 0
    prefix: cov
    valueFrom: =CycleCovariate
  - position: 0
    prefix: cov
    valueFrom: =ContextCovariate
hints:
  - class: SoftwareRequirement
    packages:
      gatk-toolkit:
        specs:
          - 'https://identifiers.org/rrid/RRID:SCR_001876'
        version:
          - '3.6'
