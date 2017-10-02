class: CommandLineTool
cwlVersion: v1.0
id: collect_insertsize_metrics_cwl
baseCommand:
  - java
  - picard.jarCollectInsertSizeMetrics
inputs:
  - id: recal.bam
    type: File
    inputBinding:
      position: 0
outputs:
  - id: insert_size_metrics.txt
    type: File
    outputBinding: {}
  - id: insert_size_metrics.pdf
    type: File
    outputBinding: {}
label: collect_insertsize_metrics
