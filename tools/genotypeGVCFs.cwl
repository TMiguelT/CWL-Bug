class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - GenomeAnalysisTK.jar
  - '-T'
  - GenotypeGVCFs
inputs:
  - default: ''
    format: 'http://edamontology.org/format_3016'
    id: known_snp_sites
    type: File
    inputBinding:
      position: 0
      prefix: '--dbsnp'
      valueFrom: /ref/known_snp_sites
    doc: dbsnp sites
  - format: 'http://edamontology.org/format_3016'
    id: raw_variants_g
    type: File
    inputBinding:
      position: 0
      valueFrom: /vcf/raw_variants_g
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
  - id: raw_variants_g_gvcf
    type: File
    outputBinding: {}
    format: 'http://edamontology.org/format_3016'
label: genotype GVCF
arguments:
  - position: 0
    prefix: stand_call_conf
    valueFrom: =5.0
  - position: 0
    prefix: stand_emit_conf
    valueFrom: =5.0
hints:
  - class: SoftwareRequirement
    packages:
      gatk-toolkit:
        specs:
          - 'https://identifiers.org/rrid/RRID:SCR_001876'
        version:
          - '3.6'
