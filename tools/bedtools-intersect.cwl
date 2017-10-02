class: CommandLineTool
cwlVersion: v1.0
id: bedtools_intersect_cwl
baseCommand:
  - bedtools
  - intersect
  - '|'
  - sort
inputs:
  - id: bed_a
    type: File
    inputBinding:
      position: 0
  - id: bed_b
    type: File
    inputBinding:
      position: 0
outputs:
  - id: intersect_bed
    type: File
    outputBinding: {}
label: bedtools-intersect
