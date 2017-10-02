class: CommandLineTool
cwlVersion: v1.0
id: samtools_view_cwl
baseCommand:
  - samtools
  - view
  - '|'
inputs:
  - id: bam
    type: File
    inputBinding:
      position: 0
outputs:
  - id: sam
    label: tmp.align.sam
    type: File
