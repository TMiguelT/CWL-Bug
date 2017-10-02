class: CommandLineTool
cwlVersion: v1.0
id: fragment_qc_stats_cwl
baseCommand:
  - samtools
  - view
  - file.bam
  - '|'
  - python
  - calculate_qc_statistics.py
inputs:
  - id: sam
    type: File
    inputBinding:
      position: 0
outputs:
  - id: fragments.tsv
    type: File
    outputBinding: {}
label: fragment_qc_stats
