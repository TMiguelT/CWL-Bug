class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - GenomeAnalysisTK.jar
  - '-T'
  - SelectVariants
inputs:
  - format: 'http://edamontology.org/format_3016'
    id: raw_variants_g_gvcf
    type: File
    inputBinding:
      position: 0
      valueFrom: /vcf/raw_variants_g_gvcf
  - format: 'http://edamontology.org/format_1929'
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
outputs:
  - id: indel_g_gvcf
    type: File
    outputBinding: {}
    format: null
label: select variants - indel
arguments:
  - position: 0
    prefix: interval_padding
  - position: 0
    prefix: select_type_to_include
hints:
  - class: SoftwareRequirement
    packages:
      gatk-toolkit:
        specs:
          - 'https://identifiers.org/rrid/RRID:SCR_001876'
        version:
          - '3.6'