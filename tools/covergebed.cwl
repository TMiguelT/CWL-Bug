class: CommandLineTool
cwlVersion: v1.0
id: covergebed_cwl
baseCommand:
  - bedtools
  - intersect
inputs:
  - id: intersect.bed
    type: File
    inputBinding:
      position: 0
  - id: sorted
    type: string?
    inputBinding:
      position: 0
      prefix: '-'
  - id: recal.bed
    type: File
    inputBinding:
      position: 0
outputs:
  - id: gzip.gz
    type: File?
    outputBinding: {}
label: covergeBed
