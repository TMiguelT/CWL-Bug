class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - bash
  - vcf_to_table.sh
inputs:
  - format: 'http://edamontology.org/format_3016'
    id: post_anno_vcf
    type: File
  - id: reference_assembly
    type: File
    inputBinding:
      position: 0
outputs:
  - id: variant_table_tsv
    type: File
    outputBinding: {}
    format: 'http://edamontology.org/format_3475'
label: vcf_to_table filter
hints:
  - class: SoftwareRequirement
    packages:
      vcf_to_table.sh:
        specs: []
        version:
          - ''
