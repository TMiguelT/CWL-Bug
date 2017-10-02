class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - GenomeAnalysisTK.jar
  - '-T'
  - CombineVariants
inputs:
  - format: 'http://edamontology.org/format_3016'
    id: indel_g_gvcf
    type: File
    inputBinding:
      position: 0
      valueFrom: /vcf/indel_g_gvcf
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
  - format: 'http://edamontology.org/format_3016'
    id: snv_g_gvcf
    type: File
    inputBinding:
      position: 0
      valueFrom: /vcf/snv_g_gvcf
outputs:
  - id: merged_variants_vcf
    type: File
    outputBinding: {}
    format: 'http://edamontology.org/format_3016'
label: merge variants
arguments:
  - position: 0
    prefix: genotypemergeoption
    valueFrom: =UNSORTED
  - position: 0
    prefix: setKey
    valueFrom: =set
hints:
  - class: SoftwareRequirement
    packages:
      gatk-toolkit:
        specs:
          - 'https://identifiers.org/rrid/RRID:SCR_001876'
        version:
          - '3.6'
