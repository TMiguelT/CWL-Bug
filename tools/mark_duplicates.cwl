class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - picard.jar
  - MarkDuplicates
inputs:
  - format: null
    id: sorted_aligned_bam
    type: File
    inputBinding:
      position: 0
      valueFrom: /align/sorted.aligned.bam
    doc: Check secondary file requirement.
    secondaryFiles:
      - index.ai
  - id: sorted_aligned_bam.ai
    type: File
    inputBinding:
      position: 0
outputs:
  - id: dedup_metrics
    doc: Text file containing summaries of duplicate metrics.
    type: File
    outputBinding: {}
    format: 'http://edamontology.org/format_3475'
  - id: deduped_bam
    doc: 'Deduped, merged and sorted bam file.'
    type: File
    outputBinding: {}
    format: 'http://edamontology.org/format_2572'
doc: |
  http://picard.sourceforge.net
label: identify and mark pcr duplicates.
arguments:
  - position: 0
    prefix: CREATE_INDEX
    separate: false
    valueFrom: =true
  - position: 0
    prefix: REMOVE_DUPLICATES
    separate: false
    valueFrom: =true
  - position: 0
    prefix: VALIDATION_STRINGENCY
    separate: false
    valueFrom: =LENIENT
  - position: 0
    prefix: AS
    separate: false
    valueFrom: =true
hints:
  - class: SoftwareRequirement
    packages:
      picard--markduplicates:
        specs:
          - 'https://identifiers.org/rrid/RRID:SCR_006525'
        version:
          - 2.6.0
