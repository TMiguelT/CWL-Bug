class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - bcftools
  - norm
inputs:
  - format: 'http://edamontology.org/format_3016'
    id: merged_variants_vcf
    type: File
    inputBinding:
      position: 0
      valueFrom: /vcf/merged_variants_vcf
    secondaryFiles:
      - vcf.index
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
  - id: normalized_g_vcf
    type: File
    outputBinding: {}
    secondaryFiles:
      - vcf.index
    format: 'http://edamontology.org/format_3016'
doc: |
  http://samtools.sourceforge.net/mpileup.shtml
label: vcf normalize
arguments:
  - position: 0
    prefix: ''
    valueFrom: '-m'
  - position: 0
    prefix: ''
    valueFrom: '-both'
hints:
  - class: SoftwareRequirement
    packages:
      bcftools:
        specs:
          - 'https://identifiers.org/rrid/RRID:SCR_001876'
        version:
          - '1.3'
