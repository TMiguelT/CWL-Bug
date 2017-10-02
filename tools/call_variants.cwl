class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - GenomeAnalysisTK.jar
  - '-T'
  - HaplotypeCaller
inputs:
  - format: null
    id: known_snp_sites
    type: File
    inputBinding:
      position: 0
      prefix: '--dbsnp'
      valueFrom: /ref/known_snp_sites
    doc: dbsnp reference sites
  - format: 'http://edamontology.org/format_2572'
    id: recalibrated_bam
    type: File
    inputBinding:
      position: 0
      valueFrom: /align/recalibrated_bam
    secondaryFiles:
      - bam.ai
  - format: 'http://edamontology.org/format_XXXX'
    id: reference_assembly
    type: File
    inputBinding:
      position: 0
      valueFrom: /align/reference_assembly
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
  - id: raw_variants_vcf
    type: File
    outputBinding: {}
    secondaryFiles:
      - vcf.index
    format: 'http://edamontology.org/format_3016'
label: Call variants
arguments:
  - position: 0
    prefix: interval_padding
    valueFrom: =25
  - position: 0
    prefix: emitRefConfidence
    valueFrom: =GVCF
hints:
  - class: SoftwareRequirement
    packages:
      gatk-toolkit:
        specs:
          - 'https://identifiers.org/rrid/RRID:SCR_001876'
        version:
          - '3.6'
