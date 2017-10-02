class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - GenomeAnalysisTK.jar
  - '-'
  - T
  - PrintReads
inputs:
  - format: 'http://edamontology.org/format_2572'
    id: deduped_realigned_bam
    type: File
  - format: 'http://edamontology.org/format_3475'
    id: recalibrated_table
    type: File
    doc: Coordinates for regions discovered requiring realignment.
  - format: 'http://edamontology.org/format_1929'
    id: reference_assembly
    type: File
    secondaryFiles:
      - .fai
      - .bwt
      - .sa
      - .ann
      - .amb
      - .pac
      - .alt
  - format: 'edam:format_3003'
    id: target_sites
    type: File
    doc: bed file containing the coordinates for genes/regions to be targeted.
outputs:
  - id: recalibrated_bam
    type: File
    outputBinding: {}
    format: 'http://edamontology.org/format_2572'
label: Apply recalibration to bam file. Overwrites values
arguments:
  - position: 0
    prefix: '-bqsr'
  - position: 0
    prefix: '--Printreads'
hints:
  - class: SoftwareRequirement
    packages:
      gatk-toolkit:
        specs:
          - 'https://identifiers.org/rrid/RRID:SCR_001876'
        version:
          - '3.6'
