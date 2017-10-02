class: CommandLineTool
cwlVersion: v1.0
id: vep_filter_cwl
baseCommand:
  - perl
  - filter_vep.pl
inputs:
  - id: vep_annotated_vcf
    type: File
    inputBinding:
      position: 0
outputs:
  - id: post_filter_vep.vcf
    type: File
    outputBinding: {}
label: vep_filter
arguments:
  - position: 0
    prefix: '--filter'
    separate: false
    valueFrom: '"Consequence not matches stream"'
  - position: 0
    prefix: '--filter'
    valueFrom: '"BIOTYPE match protein_coding"'
  - position: 0
    prefix: '--filter'
    valueFrom: '"Feature"'
