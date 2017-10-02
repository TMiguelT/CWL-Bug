class: Workflow
cwlVersion: v1.0
label: post_variant_processing
inputs:
  - id: raw_variants_g_gvcf
    type: File
  - id: reference_assembly
    type: File
    label: ref_assembly_buildhg19
    format: data_2340
    secondaryFiles:
      - .fai
      - ^.dict
outputs:
  - id: normalized_g_vcf
    outputSource: vcf_normalize/normalized_g_vcf
    type: File
steps:
  - id: merge_variants
    in:
      - id: indel_g_gvcf
        source:
          - select_indels/indel_g_gvcf
      - id: reference_assembly
        source:
          - reference_assembly
      - id: snv_g_gvcf
        source:
          - select_snvs/snv_g_gvcf
    out:
      - id: merged_variants_vcf
    run: ../tools/merge_variants.cwl
    label: gatk-selectVariants version 3.6
    doc: merge filtered indel and snv vcfs
  - id: select_indels
    in:
      - id: raw_variants_g_gvcf
        source:
          - raw_variants_g_gvcf
      - id: reference_assembly
        source:
          - reference_assembly
    out:
      - id: indel_g_gvcf
    run: ../tools/select_indels.cwl
    label: gatk-selectVariants version 3.6
    doc: >-
      extract indel mutations only. This is necessary so that indel-specific
      filters can be applied.
  - id: select_snvs
    in:
      - id: raw_variants_g_gvcf
        source:
          - raw_variants_g_gvcf
      - id: reference_assembly
        source:
          - reference_assembly
    out:
      - id: snv_g_gvcf
    run: ../tools/select_snvs.cwl
    label: gatk-selectVariants version 3.6
    doc: extract all but indel mutations types so that hard filters can be applied.
  - id: vcf_normalize
    in:
      - id: merged_variants_vcf
        source:
          - merge_variants/merged_variants_vcf
      - id: reference_assembly
        source:
          - reference_assembly
    out:
      - id: normalized_g_vcf
    run: ../tools/vcf_normalize.cwl
    label: bcftools version 1.3
    doc: normalisation and split multi-allelic sites
requirements:
  - class: SubworkflowFeatureRequirement