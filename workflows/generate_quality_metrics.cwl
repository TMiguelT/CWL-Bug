class: Workflow
cwlVersion: v1.0
id: generate_quality_metrics_cwl
label: generate_quality_metrics
inputs:
  - id: recalibrated.bam
    type: File
  - id: target_sites
    type: File
  - id: intersect.bed
    type: File
    label: capture_sites
  - id: dedup_metrics
    type: File
  - id: capture_coverage
    type: File
    label: capture_intersect_exons
  - id: reference_assembly
    type: File
outputs:
  - id: gzip.gz
    outputSource:
      - covergebed_cwl/gzip.gz
    type: File
    label: coverage.gz
  - id: karyotype.tsv
    outputSource:
      - write_karyotype_cwl/karyotype.tsv
    type: File
  - id: gzip.gz_1
    outputSource:
      - covergebed_cwl_1/gzip.gz
    type: File
    label: exome.cov.gz
  - id: fragments.tsv
    outputSource:
      - fragment_qc_stats_cwl/fragments.tsv
    type: File
  - id: summary.md
    outputSource:
      - generate_summary_report_cwl/summary.md
    type: File
  - id: summary.htm
    outputSource:
      - generate_summary_report_cwl/summary.htm
    type: File
  - id: coverage
    outputSource:
      - depth_of_coverage_cwl/coverage
    type: File
  - id: insert_size_metrics.txt
    outputSource:
      - collect_insertsize_metrics_cwl/insert_size_metrics.txt
    type: File
  - id: insert_size_metrics.pdf
    outputSource:
      - collect_insertsize_metrics_cwl/insert_size_metrics.pdf
    type: File
steps:
  - id: bedtools_intersect_cwl
    in:
      - id: bed_a
        source:
          - target_sites
      - id: bed_b
        source:
          - intersect.bed
    out:
      - id: intersect_bed
    run: ../tools/bedtools-intersect.cwl
    label: bedtools-intersect
  - id: bedtools_bamtobed_cwl
    in:
      - id: recalibrated.bam
        source:
          - recalibrated.bam
    out:
      - id: bed
    run: ../tools/bedtools-bamtobed.cwl
    label: bedtools-bamtobed
  - id: covergebed_cwl
    in:
      - id: intersect.bed
        source:
          - bedtools_intersect_cwl/intersect_bed
      - id: recal.bed
        source:
          - bedtools_bamtobed_cwl/bed
    out:
      - id: gzip.gz
    run: ../tools/covergebed.cwl
    label: covergeBed
  - id: samtools_view_cwl
    in:
      - id: bam
        source:
          - recalibrated.bam
    out:
      - id: sam
    run: ../tools/samtools-view.cwl
    label: samtools-view
  - id: write_karyotype_cwl
    in:
      - id: exome_cov.gz
        source:
          - covergebed_cwl_1/gzip.gz
    out:
      - id: karyotype.tsv
    run: ../tools/write_karyotype.cwl
    label: write_karyotype
  - id: covergebed_cwl_1
    in:
      - id: intersect.bed
        source:
          - intersect.bed
      - id: recal.bed
        source:
          - bedtools_bamtobed_cwl/bed
    out:
      - id: gzip.gz
    run: ../tools/covergebed.cwl
    label: covergeBed
  - id: fragment_qc_stats_cwl
    in:
      - id: sam
        source:
          - samtools_view_cwl_1/sam
    out:
      - id: fragments.tsv
    run: ../tools/fragment_qc_stats.cwl
    label: fragment_qc_stats
  - id: samtools_view_cwl_1
    in:
      - id: bam
        source:
          - recalibrated.bam
    out:
      - id: sam
    run: ../tools/samtools-view.cwl
    label: samtools-view
  - id: generate_summary_report_cwl
    in:
      - id: report_cov
        source:
          - covergebed_cwl/gzip.gz
      - id: exome_cov
        source:
          - covergebed_cwl_1/gzip.gz
      - id: metrics
        source:
          - dedup_metrics
      - id: gene_cov
        source:
          - capture_coverage
      - id: fragments
        source:
          - fragment_qc_stats_cwl/fragments.tsv
      - id: karyotype
        source:
          - write_karyotype_cwl/karyotype.tsv
    out:
      - id: summary.md
      - id: summary.htm
    run: ../tools/generate_summary_report.cwl
    label: generate_summary_report
  - id: depth_of_coverage_cwl
    in:
      - id: reference_assembly
        source:
          - reference_assembly
      - id: recal.bam
        source:
          - recalibrated.bam
      - id: target_sites.bed
        source:
          - target_sites
    out:
      - id: coverage
    run: ../tools/depth_of_coverage.cwl
    label: depth_of_coverage
  - id: collect_insertsize_metrics_cwl
    in:
      - id: recal.bam
        source:
          - recalibrated.bam
    out:
      - id: insert_size_metrics.txt
      - id: insert_size_metrics.pdf
    run: ../tools/collect_insertsize_metrics.cwl
    label: collect_insertsize_metrics