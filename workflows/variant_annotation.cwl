class: Workflow
cwlVersion: v1.0
label: variant_annotation
inputs:
  - id: normalized_g_vcf
    type: File
    format: 'edam:format_3016'
  - id: reference_assembly_2
    type: File
    format: File
  - id: vep_cache
    type: File
    format: 'edam:format_3016'
outputs:
  - id: vep_annotated_vcf
    outputSource: vcf_annotate_2/vep_annotated_vcf
    type: File
steps:
  - id: vcf_annotate
    in:
      - id: input_vcf
        source:
          - normalized_g_vcf
      - id: reference_assembly_2
        source:
          - reference_assembly_2
      - id: vep_cache
        source:
          - vep_cache
    out:
      - id: vep_annotated_vcf
    run: ../tools/vcf_annotate.cwl
    label: vep version 85
    doc: apply variant effect prediction tools and populate the vcf file.
  - id: vcf_annotate_2
    in:
      - id: input_vcf
        source:
          - vcf_annotate/vep_annotated_vcf
      - id: reference_assembly_2
        source:
          - reference_assembly_2
      - id: vep_cache
        source:
          - vep_cache
    out:
      - id: vep_annotated_vcf
    run: ../tools/vcf_annotate.cwl
    label: 'dbNSFP, grantham, condel plugin'
    doc: additional variant effect prediction scores
requirements:
  - class: SubworkflowFeatureRequirement