class: CommandLineTool
cwlVersion: v1.0
id: generate_summary_report_cwl
baseCommand:
  - python
  - markdown2.py
  - '|'
  - python
  - prettify_markdown.py
inputs:
  - id: report_cov
    type: File
    inputBinding:
      position: 0
  - id: exome_cov
    type: File
    inputBinding:
      position: 0
  - id: metrics
    type: File
    inputBinding:
      position: 0
  - id: gene_cov
    type: File
    inputBinding:
      position: 0
  - id: fragments
    type: File
    inputBinding:
      position: 0
  - id: karyotype
    type: File
    inputBinding:
      position: 0
outputs:
  - id: summary.md
    type: File
    outputBinding: {}
  - id: summary.htm
    type: File
    outputBinding: {}
label: generate_summary_report
