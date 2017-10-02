class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - python
  - filter_tsv.py
inputs:
  - format: 'http://edamontology.org/format_3475'
    id: variant_table_tsv
    type: File
outputs:
  - id: filtered_variant_table
    type: File
    outputBinding: {}
    format: null
label: filter_table - based on quality scores
arguments:
  - position: 0
    prefix: '--ad'
    valueFrom: '2'
  - position: 0
    prefix: '--af'
    valueFrom: '0.15'
  - position: 0
    prefix: '--dp'
    valueFrom: '5'
  - position: 0
    prefix: '--qual'
    valueFrom: '5'
hints:
  - class: SoftwareRequirement
    packages:
      vcf_to_table.sh:
        specs: []
        version:
          - ''
