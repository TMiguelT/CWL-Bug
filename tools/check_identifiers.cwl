class: CommandLineTool
cwlVersion: v1.0
id: check_identifiers_cwl
baseCommand:
  - python
  - filter_transcripts.py
inputs:
  - id: flattened_table
    type: File
    inputBinding:
      position: 0
outputs:
  - id: identifier
    type: string
    outputBinding: {}
label: check_identifiers
