class: CommandLineTool
cwlVersion: v1.0
id: write_karyotype_cwl
baseCommand:
  - qc_report.py
inputs:
  - id: exome_cov.gz
    type: File
    inputBinding:
      position: 0
outputs:
  - id: karyotype.tsv
    type: File
    outputBinding: {}
label: write_karyotype
