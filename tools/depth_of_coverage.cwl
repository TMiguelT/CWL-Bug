class: CommandLineTool
cwlVersion: v1.0
id: depth_of_coverage_cwl
baseCommand:
  - GenomeAnalysisTK.jar
  - '-T'
  - DepthOfCoverage
inputs:
  - id: reference_assembly
    type: File
    inputBinding:
      position: 0
      valueFrom: /ref/reference_assembly
  - id: recal.bam
    type: File
    inputBinding:
      position: 0
      valueFrom: /align/recal.bam
  - id: target_sites.bed
    type: File
    inputBinding:
      position: 0
outputs:
  - id: coverage
    type: File
    outputBinding: {}
label: depth_of_coverage
arguments:
  - position: 0
    prefix: '-ct'
    valueFrom: '1'
  - position: 0
    prefix: '-ct'
    valueFrom: '10'
  - position: 0
    prefix: '-ct'
    valueFrom: '20'
  - position: 0
    prefix: '-ct'
    valueFrom: '50'
  - position: 0
    prefix: '-ct'
    valueFrom: '100'
  - position: 0
    prefix: '--omitDepthOutputAtEachBase'
