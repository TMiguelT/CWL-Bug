class: CommandLineTool
cwlVersion: v1.0
id: bedtools_bamtobed_cwl
baseCommand: []
inputs:
  - id: recalibrated.bam
    type: File
    inputBinding:
      position: 0
outputs:
  - id: bed
    type: File
label: bedtools-bamtobed
