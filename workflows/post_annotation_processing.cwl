class: Workflow
cwlVersion: v1.0
label: post_annotation_processing
inputs:
  - id: reference_assembly
    type: File
  - id: post_anno_vcf
    type: File
outputs:
  - id: transcript_filtered_table
    outputSource:
      - transcript_filter/transcript_filtered_table
    type: File
    label: LOVD ready table
steps:
  - id: vcf_to_table
    in:
      - id: post_anno_vcf
        source:
          - post_anno_vcf
      - id: reference_assembly
        source:
          - reference_assembly
    out:
      - id: variant_table_tsv
    run: ../tools/vcf_to_table.cwl
    label: vcf_to_table filter
  - id: filter_table
    in:
      - id: variant_table_tsv
        source:
          - vcf_to_table/variant_table_tsv
    out:
      - id: filtered_variant_table
    run: ../tools/filter_table.cwl
    label: filter_table - based on quality scores
  - id: convert_table_lovd
    in:
      - id: filtered_variant_table
        source:
          - filter_table/filtered_variant_table
    out:
      - id: flattened_table
    run: ../tools/convert_table_lovd.cwl
    label: convert_table_lovd - for LOVD
  - id: transcript_filter
    in:
      - id: flattened_table
        source:
          - convert_table_lovd/flattened_table
    out:
      - id: transcript_filtered_table
    run: ../tools/transcript_filter.cwl
    label: transcript_filter - remove multiple transcripts