class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - bedtools
inputs:
  - default: ''
    format: 'http://edamontology.org/format_XXXX'
    id: dedup_metrics
    type: File
    inputBinding:
      position: 0
    doc: Text file containing summaries of duplicate metrics.
  - default: ''
    format: 'edam:format_3003'
    id: gender
    type: File
    inputBinding:
      position: 0
    doc: bed file containing the library sites.
  - default: ''
    format: 'edam:format_3003'
    id: library_sites
    type: File
    inputBinding:
      position: 0
    doc: bed file containing the library sites.
  - default: ''
    format: null
    id: recalibrated_bam
    type: File
    inputBinding:
      position: 0
  - default: ''
    format: 'http://edamontology.org/format_XXXX'
    id: reference_assembly
    type: File
    inputBinding:
      position: 0
      shellQuote: false
    secondaryFiles:
      - .fai
      - .bwt
      - .sa
      - .ann
      - .amb
      - .pac
      - .alt
  - default: ''
    format: 'edam:format_3003'
    id: target_sites
    type: File
    inputBinding:
      position: 0
    doc: bed file containing the coordinates for genes/regions to be targeted.
outputs:
  - id: exome_coverage_gz
    type: File
    outputBinding: {}
    format: null
  - id: fragments_tsv
    type: File
    outputBinding: {}
    format: 'http://edamontology.org/format_3475'
  - id: insert_size_metrics_txt
    type: File
    outputBinding: {}
    format: null
  - id: intersect_bed
    type: File
    outputBinding: {}
    format: 'http://edamontology.org/format_3003'
  - id: intersect_cov_gz
    type: File
    outputBinding: {}
    format: null
  - id: karyotype_summary
    type: File
    outputBinding: {}
    format: null
  - id: ontarget_txt
    type: File
    outputBinding: {}
    format: null
  - id: read_coverage_summary
    type: File
    outputBinding: {}
    format: null
  - id: recalibrated_bed
    type: File
    outputBinding: {}
    format: 'http://edamontology.org/format_3003'
  - id: stage_report_pdf
    type: File
    outputBinding: {}
    format: null
doc: |
  'https://github.com/arq5x/bedtools2'
label: bam_quality - calculate coverage statistics
requirements:
  - class: ShellCommandRequirement
hints:
  - class: SoftwareRequirement
    packages:
      bedtools:
        specs:
          - 'https://identifiers.org/rrid/RRID:SCR_006646'
        version:
          - 2.25.0
