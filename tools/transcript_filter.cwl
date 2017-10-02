class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - python
  - filter_transcripts.py
inputs:
  - id: flattened_table
    type: File
outputs:
  - id: transcript_filtered_table
    label: LOVD ready table
    type: File
label: transcript_filter - remove multiple transcripts
hints:
  - class: SoftwareRequirement
    packages:
      filter_transcripts.py:
        specs: []
        version:
          - ''
