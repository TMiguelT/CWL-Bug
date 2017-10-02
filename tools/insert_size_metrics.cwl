class: CommandLineTool
cwlVersion: v1.0
id: insert_size_metrics_cwl
baseCommand:
  - java
  - picard.jar
  - CollectInsertSizeMetrics
inputs:
  - id: recal.bam
    type: File
    inputBinding:
      position: 0
      valueFrom: /align/recal.bam
outputs:
  - id: insert_size_metrics.pdf
    type: File?
    outputBinding: {}
  - id: insert_size_metrics.txt
    type: File?
    outputBinding: {}
label: insert_size_metrics
