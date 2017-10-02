class: CommandLineTool
cwlVersion: v1.0
id: bwa
baseCommand:
  - bwa
  - bwa-mem
inputs:
  - id: read1
    type: File
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    outputBinding: {}
label: bwa
arguments:
  - position: 0
