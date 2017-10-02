class: CommandLineTool
cwlVersion: v1.0
id: samtools_index_cwl
baseCommand:
  - samtools
  - index
inputs:
  - id: bam
    type: File
    inputBinding:
      position: 0
outputs:
  - id: sorted.bam.ai
    type: File
    outputBinding: {}
  - id: sorted.bam
    label: sorted.bam
    type: File
    outputBinding: {}
label: samtools-index
