class: CommandLineTool
cwlVersion: v1.0
id: bash_ontarget_cwl
baseCommand: []
inputs:
  - id: recal.bam
    type: File
    inputBinding:
      position: 0
outputs:
  - id: on_target.txt
    type: File
    outputBinding: {}
label: bash_ontarget
