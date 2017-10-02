class: CommandLineTool
cwlVersion: v1.0
id: samtools_sort_cwl
baseCommand:
  - samtools
  - sort
inputs:
  - id: aligned.sam
    type: File
    inputBinding:
      position: 0
outputs:
  - id: sorted.bam
    type: File
    outputBinding: {}
label: samtools-sort
