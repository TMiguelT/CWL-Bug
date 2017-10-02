class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - python
  - convert_to_lovd.py
inputs:
  - format: null
    id: filtered_variant_table
    type: File
outputs:
  - id: flattened_table
    type: File
    outputBinding: {}
    format: null
label: convert_table_lovd - for LOVD
hints:
  - class: SoftwareRequirement
    packages:
      convert_to_lovd.py:
        specs: []
        version:
          - ''
