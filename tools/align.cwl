class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - bwa
  - mem
inputs:
  - format: 'http://edamontology.org/format_1930'
    id: forward_reads.gz
    type: File
    inputBinding:
      position: 0
    doc: >-
      Forward reads produced as a part of a paired-end sequencing experiment.
      Multiple file inputs when libraries are pooled across >1 lanes
  - format: 'http://edamontology.org/data_2340'
    id: reference_assembly.fasta
    type: File
    inputBinding:
      position: 0
    doc: hg19 human reference genome
    secondaryFiles:
      - .fai
      - .bwt
      - .sa
      - .ann
      - .amb
      - .pac
      - .alt
  - format: 'http://edamontology.org/format_1930'
    id: reverse_reads.gz
    type: File
    inputBinding:
      position: 0
    doc: >-
      Reverse reads produced as a part of a paired-end sequencing experiment.
      Multiple file inputs when libraries are pooled across >1 lanes
outputs:
  - id: ref_aligned_bam
    doc: bam file containing aligned sequences.
    type: File
    outputBinding: {}
    format: 'http://edamontology.org/format_2572'
doc: 'http://bio-bwa.sourceforge.net/bwa.shtml'
label: mapping of forward and reverse reads to the reference assembly
arguments:
  - position: 0
    prefix: '-k'
    valueFrom: '19'
  - position: 0
    prefix: '-M'
  - position: 0
    prefix: '-t'
    valueFrom: '8'
hints:
  - class: SoftwareRequirement
    packages:
      bwa-mem:
        specs:
          - 'https://identifiers.org/rrid/RRID:SCR_010910'
        version:
          - 0.7.13