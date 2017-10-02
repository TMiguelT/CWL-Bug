class: Workflow
cwlVersion: v1.0
doc: This is some documentation
label: variant_calling
inputs:
  - id: known_snp_sites
    type: File
    format: data_1106
    secondaryFiles:
      - .tbi
  - id: recalibrated_bam
    type: File
  - id: reference_assembly
    type: File
    label: ref_assembly_buildhg19
    format: data_2340
    secondaryFiles:
      - .fai
      - ^.dict
  - id: target_sites
    type: File
    doc: >-
      bed file containing coordinates for intersection of exons and library
      captures sites.
    format: 'edam:format_3003'
outputs:
  - id: raw_variants_g_gvcf
    outputSource: genotypeGVCFs/raw_variants_g_gvcf
    type: File
steps:
  - id: call_variants
    in:
      - id: known_snp_sites
        source:
          - known_snp_sites
      - id: recalibrated_bam
        source:
          - recalibrated_bam
      - id: reference_assembly
        source:
          - reference_assembly
      - id: target_sites
        source:
          - target_sites
    out:
      - id: raw_variants_vcf
    run: ../tools/call_variants.cwl
    label: gatk-HaplotypeCaller version 3.6
    doc: >-
      simultaneous call of indels and snvs across target region sites. dbsnp ID
      annotated to file for referencing purposes.
  - id: genotypeGVCFs
    in:
      - id: known_snp_sites
        source:
          - known_snp_sites
      - id: raw_variants_g
        source:
          - call_variants/raw_variants_vcf
      - id: reference_assembly
        source:
          - reference_assembly
    out:
      - id: raw_variants_g_gvcf
    run: ../tools/genotypeGVCFs.cwl
    label: gatk-genotypeGVCF version 3.6
    doc: >-
      genotypeGVCF is a redundant stage for singleton pipeline. Stage is
      performed but functionality not relevant to downstream stages.
      Sample-by-sample calling employed for sample consistency and independence.
requirements:
  - class: SubworkflowFeatureRequirement
