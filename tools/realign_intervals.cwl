class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - GenomeAnalysisTK.jar
  - '-T'
  - RealignerTargetCreator
inputs:
  - format: 'http://edamontology.org/format_2572'
    id: deduped_bam
    type: File
    inputBinding:
      position: 0
      valueFrom: /align/deduped_bam
    secondaryFiles:
      - bam.ai
  - format: null
    id: known_indel_sites
    type: File
    inputBinding:
      position: 0
      valueFrom: /ref/known_indel_sites
    doc: Mills & 1000G reference indels
  - format: 'http://edamontology.org/data_2340'
    id: reference_assembly
    type: File
    inputBinding:
      position: 0
      valueFrom: /ref/reference_assembly
    doc: hg19 human reference genome
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
outputs:
  - id: realigned_intervals
    doc: Coordinates for regions discovered requiring realignment.
    type: File
    outputBinding: {}
    format: 'http://edamontology.org/format_3475'
doc: |
  https://bio.tools/tool/gatk2_realigner_target_c/version/none
label: discover indel sites in need of realignment.
arguments:
  - position: 0
    prefix: interval_padding
    separate: false
    valueFrom: =25
  - position: 0
    prefix: known
    separate: false
    valueFrom: =MIlls_and_1000G_gold_standard.indels
hints:
  - class: SoftwareRequirement
    packages:
      gatk-toolkit:
        specs:
          - 'https://identifiers.org/rrid/RRID:SCR_001876'
        version:
          - '3.6'
