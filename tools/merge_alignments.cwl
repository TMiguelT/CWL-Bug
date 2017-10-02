class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - picard.jar
  - MergeSamFiles
inputs:
  - format: null
    id: sorted.bam
    type: File
    inputBinding:
      position: 0
    doc: >-
      Merge of bam files if multiple bams due to an individual being sequenced
      over several lanes.
    secondaryFiles:
      - bam.ai
outputs:
  - id: aligned_merged_bam
    doc: |-
      Merged and sorted bam file.

      Check secondary index requirements.
    type: File
    outputBinding: {}
    format: 'http://edamontology.org/format_2572'
doc: |
  http://bio-bwa.sourceforge.net/bwa.shtml
label: merge bam files
arguments:
  - position: 0
    prefix: ASSUME_SORTED
    separate: false
    valueFrom: =true
  - position: 0
    prefix: CREATE_INDEX
    separate: false
    valueFrom: =true
  - position: 0
    prefix: VALIDATION_STRINGENCY
    separate: false
    valueFrom: =LENIENT
hints:
  - class: SoftwareRequirement
    packages:
      picard--mergeSamFiles:
        specs:
          - 'https://identifiers.org/rrid/RRID:SCR_006525'
        version:
          - 2.6.0
