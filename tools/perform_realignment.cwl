class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - GenomeAnalysisTK.jar
  - IndelRealigner
inputs:
  - format: 'http://edamontology.org/format_2572'
    id: deduped_bam
    type: File
    inputBinding:
      position: 0
      valueFrom: /align/deduped.bam
  - format: 'http://edamontology.org/format_3475'
    id: interval_list
    type: File
    inputBinding:
      position: 0
      valueFrom: /align/interval_list
    doc: Coordinates for regions discovered requiring realignment.
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
outputs:
  - id: deduped_realigned_bam
    type: File
    outputBinding: {}
    secondaryFiles:
      - bam.index
    format: 'http://edamontology.org/format_2572'
doc: |
  https://bio.tools/tool/gatk2_indel_realigner-IP/version/none
label: perform local realignment of indel sites.
arguments:
  - position: 0
    prefix: taregtIntervals
    valueFrom: =intervals
hints:
  - class: SoftwareRequirement
    packages:
      gatk-toolkit:
        specs:
          - 'https://identifiers.org/rrid/RRID:SCR_001876'
        version:
          - '3.6'
