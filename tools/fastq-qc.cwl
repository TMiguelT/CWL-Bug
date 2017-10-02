class: CommandLineTool
cwlVersion: v1.0
id: fastq_qc_cwl
baseCommand:
  - fastqqc
inputs:
  - id: forward_reads
    type: File
    inputBinding:
      position: 0
  - id: reverse_reads
    type: File
    inputBinding:
      position: 0
outputs:
  - id: fastqc_report_forward
    type: File
  - id: fastqc_report_reverse
    type: File
  - id: read1.fastqc.gz
    type: File
  - id: read2.fastqc.gz
    type: File?
