class: CommandLineTool
cwlVersion: v1.0
id: lovd_cwl
baseCommand: []
inputs:
  - id: table
    type: File
    inputBinding:
      position: 0
  - id: insert_size_metrics
    type: File
    inputBinding:
      position: 0
  - id: depth_of_coverage
    type: File
    inputBinding:
      position: 0
  - id: stage_report
    type: File
    inputBinding:
      position: 0
outputs:
  - id: table2
    label: table
    type: File

label: LOVD
