class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - perl
  - variant_effect_predictor.pl
inputs:
  - default: ''
    id: Grantham_plugin
    type: string
    inputBinding:
      position: 0
      prefix: '--plugin'
    doc: '[Grantham]'
  - default: ''
    id: condel_plugin
    type: string
    inputBinding:
      position: 0
      prefix: '--plugin'
    doc: '[Condel]'
  - default: ''
    id: dbNSFP
    type: string
    inputBinding:
      position: 0
      prefix: '--plugin'
    doc: '[dbNSFP]'
  - format: 'http://edamontology.org/format_3016'
    id: input_vcf
    type: File
  - format: 'http://edamontology.org/format_1929'
    id: reference_assembly_2
    type: File
    doc: Homo_sapiens.GRCh37.75.dna.primary_assembly.fa from VEP cache
  - format: null
    id: vep_cache
    type: File
outputs:
  - id: vep_annotated_vcf
    type: File
    outputBinding: {}
    format: null
doc: |
  "http://www.ensembl.org/info/docs/tools/vep/index.html"
label: vcf annotate
arguments:
  - position: 0
    prefix: '--plugin'
    separate: false
    valueFrom: condel
  - position: 0
    prefix: '--plugin'
    separate: false
    valueFrom: dbNSFP
  - position: 0
    prefix: '--plugin'
    separate: false
    valueFrom: Grantham
hints:
  - class: SoftwareRequirement
    packages:
      vep:
        specs:
          - 'https://identifiers.org/rrid/RRID:SCR_001876'
        version:
          - '85'
