- dashboard: ncd_perf_dash
  title: NCD - NEW TABLE - overview
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: ZVz3T4WmKI89kNiHIZkzhR
  elements:
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |-
      <div text-align="center" position="relative">
      <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8zyzCIveJi2k9Ys9jxldX5wOZlfoEsFoQBQ&s" width="85%" position="absolute">
        </div>
    row: 0
    col: 21
    width: 3
    height: 2
  - title: Delivery by Device
    name: Delivery by Device
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    type: looker_pie
    fields: [ncd_fact_nexxen_dsp_test_raw_rev2.impressions, ncd_fact_nexxen_dsp_test_raw_rev2.device_type_category]
    filters:
      ncd_fact_nexxen_dsp_test_raw_rev2.device_type_category: "-Other"
    sorts: [ncd_fact_nexxen_dsp_test_raw_rev2.impressions desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${ncd_fact_nexxen_dsp_test_raw_rev2.impressions}"
      label: IMPRESSIONS
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: impressions
      _type_hint: number
    value_labels: labels
    label_type: labPer
    inner_radius: 30
    color_application:
      collection_id: ncd
      palette_id: ncd-categorical-0
      options:
        steps: 5
    series_colors:
      Mobile Phone: "#7f8db7"
      Tablet: "#6e1dff"
      Desktop: "#8CF585"
      CTV: "#3d00ac"
      Any Device: "#59594A"
      Other: "#b68eff"
    advanced_vis_config: |-
      {
        chart: {
          type: 'variablepie'
        },
        plotOptions: {
          series: {
            allowPointSelect: true,
            cursor: 'pointer',
            borderRadius: 8,
            dataLabels: [{
              enabled: true,
              distance: 20,
              color: '#4D3D69',
              style: {
                fontSize: '15px'
              }
            }],
          }
        },
        series: [{}]
      }
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_fields: [ncd_fact_nexxen_dsp_test_raw_rev2.impressions]
    listen:
      Package: ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname
      Tactic: ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname
      Campaign: ncd_fact_nexxen_dsp_test_raw_rev2.name
      Format: ncd_fact_nexxen_dsp_test_raw_rev2.format
      Date: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
      Advertiser: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
      Creative Group A: ncd_fact_nexxen_dsp_test_raw_rev2.creative_group_a
    row: 27
    col: 0
    width: 5
    height: 7
  - title: Delivery & Performance by Day
    name: Delivery & Performance by Day
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    type: looker_line
    fields: [ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date, ncd_fact_nexxen_dsp_test_raw_rev2.impressions, ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P,
      ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr]
    filters:
      ncd_fact_nexxen_dsp_test_raw_rev2.impressions: ">0"
      ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P: ">0"
    sorts: [ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    color_application:
      collection_id: ncd
      palette_id: ncd-categorical-0
      options:
        steps: 5
    y_axes: [{label: IMPRESSIONS, orientation: left, series: [{axisId: ncd_fact_nexxen_dsp_test_raw_rev2.impressions,
            id: ncd_fact_nexxen_dsp_test_raw_rev2.impressions, name: IMPRESSIONS}], showLabels: true,
        showValues: true, valueFormat: '0.0,, "M"', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: VCR, orientation: right, series: [
          {axisId: ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P, id: ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P, name: VCR}],
        showLabels: true, showValues: true, maxValue: !!null '', minValue: !!null '',
        valueFormat: 0%, unpinAxis: false, tickDensity: default, type: linear}, {
        label: '', orientation: right, series: [{axisId: ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr,
            id: ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr, name: CTR}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '1'
    hidden_series: []
    series_colors:
      ncd_fact_nexxen_dsp_test_raw_rev2.impressions: "#3d00ac"
      ncd_fact_nexxen_dsp_test_raw_rev2.clicks: "#CCA211"
      ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P: "#8CF585"
    series_labels:
      ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P: VCR
      ncd_fact_nexxen_dsp_test_raw_rev2.impressions: IMPRESSIONS
      ncd_fact_nexxen_dsp_test_raw_rev2.CTR_1P: CTR
      ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr: CTR
    advanced_vis_config: |-
      {
        chart: {
        },
        series: [{
            name: 'IMPRESSIONS',
            lineWidth: 3,
            animation: {
              duration: 1000 // Animation duration for this series
            }
          }, {
            name: 'VCR',
            lineWidth: 3,
            animation: {
              duration: 1000 // Animation duration for this series
            }
          },
          {
            name: 'CTR',
            lineWidth: 3,
            animation: {
              duration: 1000 // Animation duration for this series
            }
          }
        ]
      }
    defaults_version: 1
    hidden_fields: []
    hidden_pivots: {}
    listen:
      Package: ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname
      Tactic: ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname
      Campaign: ncd_fact_nexxen_dsp_test_raw_rev2.name
      Format: ncd_fact_nexxen_dsp_test_raw_rev2.format
      Date: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
      Advertiser: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
      Creative Group A: ncd_fact_nexxen_dsp_test_raw_rev2.creative_group_a
    row: 5
    col: 0
    width: 15
    height: 8
  - name: " (2)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "<body style=\"display: flex; justify-content: center; align-items:\
      \ center;\">\n\n<div style=\"display: flex; border-radius: 30px; overflow: hidden;\
      \ border: 1px solid #dcd3e3;\">\n\n <button style=\"border: none;  font-size:\
      \ 15px; cursor: pointer; background: #3d00ac; flex: 1; border-radius: 30px 0\
      \ 0 30px; border-right: 1px solid #3d00ac;\">\n        <a style=\" color: white;\
      \  font-weight: bold;\" href=\"https://tremor.cloud.looker.com/embed/dashboards/2435?theme=NCD\"\
      >Overview</a>\n    </button>\n\n    <button style=\"border: none; padding: 10px;\
      \ font-size: 15px; cursor: pointer; background: white;  flex: 1; border-radius:\
      \ 0 30px 30px 0;\">\n        <a style=\"  color: #3d00ac; font-weight: bold;\
      \ \" href=\"https://tremor.cloud.looker.com/embed/dashboards/2460?theme=NCD\"\
      >Details</a>\n    </button>\n   \n</div>\n\n</body>"
    row: 0
    col: 0
    width: 5
    height: 2
  - title: Delivery & Performance by Tactic
    name: Delivery & Performance by Tactic
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    type: looker_column
    fields: [ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname, ncd_fact_nexxen_dsp_test_raw_rev2.impressions, ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P,
      ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr]
    filters:
      ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname: "-NULL"
    sorts: [ncd_fact_nexxen_dsp_test_raw_rev2.impressions desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: ncd
      palette_id: ncd-categorical-0
      options:
        steps: 5
    y_axes: [{label: IMPRESSIONS, orientation: left, series: [{axisId: ncd_fact_nexxen_dsp_test_raw_rev2.impressions,
            id: ncd_fact_nexxen_dsp_test_raw_rev2.impressions, name: IMPRESSIONS}], showLabels: true,
        showValues: true, valueFormat: '0.0,,"M"', unpinAxis: false, tickDensity: default,
        type: linear}, {label: VCR, orientation: right, series: [{axisId: ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P,
            id: ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P, name: VCR}], showLabels: true, showValues: true,
        minValue: !!null '', valueFormat: 0%, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: '', orientation: right, series: [
          {axisId: ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr, id: ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr, name: CTR}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}]
    x_axis_label: TACTIC
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P: line
      ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr: line
    series_colors:
      ncd_fact_nexxen_dsp_test_raw_rev2.delivered_units: "#4D3D69"
      ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P: "#8CF585"
    series_labels:
      ncd_fact_nexxen_dsp_test_raw_rev2.cogs: Total Spend
      ncd_fact_nexxen_dsp_test_raw_rev2lineitem.start_date__c_date: Start Date
      ncd_fact_nexxen_dsp_test_raw_rev2lineitem.end_date__c_date: End Date
      ncd_fact_nexxen_dsp_test_raw_rev2.name: Package Name
      ncd_fact_nexxen_dsp_test_raw_rev2lineitem.price_type_name__c: Price Type
      ncd_fact_nexxen_dsp_test_raw_rev2.CTR_1P: CTR
      ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P: VCR
      ncd_fact_nexxen_dsp_test_raw_rev2.pacing: "% Delivered"
      ncd_fact_nexxen_dsp_test_raw_rev2.impressions: IMPRESSIONS
      ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr: CTR
    advanced_vis_config: |-
      {
        chart: {},
          series: [{
            name: 'IMPRESSIONS',
            type: 'column',
            borderRadius: 3,
            animation: {
              duration: 1000 // Animation duration for this series
            }
          }, {
            name: 'VCR',
            type: 'spline',
            lineWidth: 3,
            animation: {
              duration: 1000 // Animation duration for this series
            }
          },
          {
            name: 'CTR',
            type: 'spline',
            lineWidth: 3,
            animation: {
              duration: 1000 // Animation duration for this series
            }
          }
        ]
      }
    value_labels: legend
    label_type: labPer
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      ncd_fact_nexxen_dsp_test_raw_rev2.impressions:
        is_active: true
        palette:
          palette_id: 926920fb-1ebb-9062-6fba-e9c6dbf4eb55
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#1982c4"
          - "#ff595e"
    series_value_format:
      ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P:
        name: percent_1
        decimals: '1'
        format_string: "#,##0.0%"
        label: Percent (1)
        label_prefix: Percent
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Package: ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname
      Campaign: ncd_fact_nexxen_dsp_test_raw_rev2.name
      Format: ncd_fact_nexxen_dsp_test_raw_rev2.format
      Date: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
      Advertiser: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
      Creative Group A: ncd_fact_nexxen_dsp_test_raw_rev2.creative_group_a
    row: 5
    col: 15
    width: 9
    height: 8
  - name: " (3)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: ''
    row: 0
    col: 7
    width: 11
    height: 2
  - title: Pacing (Copy)
    name: Pacing (Copy)
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    type: single_value
    fields: [ncd_fact_nexxen_dsp_test_raw_rev2.html_kpi_pacing]
    filters:
      ncd_fact_nexxen_dsp_test_raw_rev2.name: ''
      ncd_fact_nexxen_dsp_test_raw_rev2.date_key_month: 12 month ago for 12 month
      ncd_fact_nexxen_dsp_test_raw_rev2lineitem_pacing.total_pacing: NOT NULL
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      label: Change
      value_format:
      value_format_name: percent_2
      calculation_type: percent_difference_from_previous
      table_calculation: change
      args:
      - ncd_fact_nexxen_dsp_test_raw_rev2lineitem_pacing.total_pacing
      _kind_hint: measure
      _type_hint: number
      is_disabled: true
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#4D3D69"
    single_value_title: "."
    comparison_label: "."
    font_size_main: '15'
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    hidden_pivots: {}
    title_hidden: true
    listen:
      Package: ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname
      Tactic: ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname
      Campaign: ncd_fact_nexxen_dsp_test_raw_rev2.name
      Format: ncd_fact_nexxen_dsp_test_raw_rev2.format
      Date: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
      Advertiser: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
      Creative Group A: ncd_fact_nexxen_dsp_test_raw_rev2.creative_group_a
    row: 2
    col: 0
    width: 3
    height: 3
  - title: Delivered Spend
    name: Delivered Spend
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    type: single_value
    fields: [ncd_fact_nexxen_dsp_test_raw_rev2.html_kpi_delivered_units]
    filters:
      ncd_fact_nexxen_dsp_test_raw_rev2.name: ''
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      label: Change
      value_format:
      value_format_name: percent_2
      calculation_type: percent_difference_from_previous
      table_calculation: change_1
      args:
      - ncd_fact_nexxen_dsp_test_raw_rev2.impressions
      _kind_hint: measure
      _type_hint: number
      is_disabled: true
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#4D3D69"
    single_value_title: "."
    comparison_label: "."
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    hidden_pivots: {}
    listen:
      Package: ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname
      Tactic: ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname
      Campaign: ncd_fact_nexxen_dsp_test_raw_rev2.name
      Format: ncd_fact_nexxen_dsp_test_raw_rev2.format
      Date: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
      Advertiser: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
      Creative Group A: ncd_fact_nexxen_dsp_test_raw_rev2.creative_group_a
    row: 2
    col: 6
    width: 3
    height: 3
  - title: VCR (Copy)
    name: VCR (Copy)
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    type: single_value
    fields: [ncd_fact_nexxen_dsp_test_raw_rev2.html_kpi_vcr]
    filters:
      ncd_fact_nexxen_dsp_test_raw_rev2.name: ''
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      label: Change
      value_format:
      value_format_name: percent_2
      calculation_type: percent_difference_from_previous
      table_calculation: change
      args:
      - ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P
      _kind_hint: measure
      _type_hint: number
      is_disabled: true
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#4D3D69"
    single_value_title: "."
    comparison_label: "."
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    hidden_pivots: {}
    listen:
      Package: ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname
      Tactic: ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname
      Campaign: ncd_fact_nexxen_dsp_test_raw_rev2.name
      Format: ncd_fact_nexxen_dsp_test_raw_rev2.format
      Date: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
      Advertiser: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
      Creative Group A: ncd_fact_nexxen_dsp_test_raw_rev2.creative_group_a
    row: 2
    col: 15
    width: 3
    height: 3
  - title: Delivered Spend
    name: Delivered Spend (2)
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    type: single_value
    fields: [ncd_fact_nexxen_dsp_test_raw_rev2.html_kpi_delivered_spend]
    filters:
      ncd_fact_nexxen_dsp_test_raw_rev2.name: ''
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      label: Change
      value_format:
      value_format_name: percent_2
      calculation_type: percent_difference_from_previous
      table_calculation: change
      args:
      - ncd_fact_nexxen_dsp_test_raw_rev2.Delivered_Spend
      _kind_hint: measure
      _type_hint: number
      is_disabled: true
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#4D3D69"
    single_value_title: "."
    comparison_label: "."
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    hidden_pivots: {}
    listen:
      Package: ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname
      Tactic: ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname
      Campaign: ncd_fact_nexxen_dsp_test_raw_rev2.name
      Format: ncd_fact_nexxen_dsp_test_raw_rev2.format
      Date: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
      Advertiser: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
      Creative Group A: ncd_fact_nexxen_dsp_test_raw_rev2.creative_group_a
    row: 2
    col: 3
    width: 3
    height: 3
  - title: Top CTV Apps
    name: Top CTV Apps
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    type: looker_bar
    fields: [ncd_fact_nexxen_dsp_test_raw_rev2.mobile_app_name, ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P, ncd_fact_nexxen_dsp_test_raw_rev2.impressions]
    filters:
      ncd_fact_nexxen_dsp_test_raw_rev2.mobile_app_name: "-EMPTY"
    sorts: [ncd_fact_nexxen_dsp_test_raw_rev2.impressions desc]
    limit: 5
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${ncd_fact_nexxen_dsp_test_raw_rev2.mobile_app_name}"
      label: App Name
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: app_name
      _type_hint: string
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: ncd
      palette_id: ncd-categorical-0
      options:
        steps: 5
    y_axes: [{label: VCR, orientation: left, series: [{axisId: ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P,
            id: ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P, name: VCR 1P}], showLabels: true, showValues: true,
        minValue: 0.9, valueFormat: 0%, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      Pluto TV: "#4D3D69"
      Plex: "#CCA211"
      Tubi TV: "#15003B"
      Samsung TV Plus: "#15003B"
      Fawesome TV: "#BCB7C6"
      Outside TV: "#15003B"
    series_labels:
      ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P: VCR
    advanced_vis_config: |-
      {
        chart: {},
        plotOptions: {
          column: {
            borderRadius: 3
          },
          series: {
            borderWidth: 0,
            "animation": {
              "duration": 1500,
              "easing": "easeOutBounce"
            }
          }
        }
      }
    value_labels: legend
    label_type: labPer
    inner_radius: 50
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_fields: [ncd_fact_nexxen_dsp_test_raw_rev2.impressions, ncd_fact_nexxen_dsp_test_raw_rev2.mobile_app_name]
    hidden_pivots: {}
    listen:
      Package: ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname
      Tactic: ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname
      Campaign: ncd_fact_nexxen_dsp_test_raw_rev2.name
      Format: ncd_fact_nexxen_dsp_test_raw_rev2.format
      Date: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
      Advertiser: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
      Creative Group A: ncd_fact_nexxen_dsp_test_raw_rev2.creative_group_a
    row: 21
    col: 17
    width: 7
    height: 6
  - title: Delivery by State
    name: Delivery by State
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    type: looker_google_map
    fields: [ncd_fact_nexxen_dsp_test_raw_rev2.impressions, ncd_fact_nexxen_dsp_test_raw_rev2.region_name]
    filters:
      ncd_fact_nexxen_dsp_test_raw_rev2.region_name: ''
      ncd_fact_nexxen_dsp_test_raw_rev2.country_name: Canada,United States
    sorts: [ncd_fact_nexxen_dsp_test_raw_rev2.impressions desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${ncd_fact_nexxen_dsp_test_raw_rev2.impressions}"
      label: IMPRESSIONS
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: impressions
      _type_hint: number
    hidden_fields: [ncd_fact_nexxen_dsp_test_raw_rev2.impressions]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.7
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    map_value_colors: ["#F2EBFF", "#3d00ac"]
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    defaults_version: 0
    listen:
      Package: ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname
      Tactic: ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname
      Campaign: ncd_fact_nexxen_dsp_test_raw_rev2.name
      Format: ncd_fact_nexxen_dsp_test_raw_rev2.format
      Date: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
      Advertiser: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
      Creative Group A: ncd_fact_nexxen_dsp_test_raw_rev2.creative_group_a
    row: 13
    col: 0
    width: 12
    height: 8
  - title: Delivery & Performance by Format
    name: Delivery & Performance by Format
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    type: looker_grid
    fields: [ncd_fact_nexxen_dsp_test_raw_rev2.format, ncd_fact_nexxen_dsp_test_raw_rev2.impressions, ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P,
      ncd_fact_nexxen_dsp_test_raw_rev2.complete_events, ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr, ncd_fact_nexxen_dsp_test_raw_rev2.ncd_clicks]
    filters:
      ncd_fact_nexxen_dsp_test_raw_rev2.format: Audio,Display,Video
    sorts: [ncd_fact_nexxen_dsp_test_raw_rev2.impressions desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: dimension
      expression: "case(\n  when(${ncd_fact_nexxen_dsp_test_raw_rev2.device_type}=\"TV\",\"CTV\"\
        ) \n  ,when(${ncd_fact_nexxen_dsp_test_raw_rev2.device_type}=\"Set Top Box\",\"CTV\"),\n\
        \  when(${ncd_fact_nexxen_dsp_test_raw_rev2.device_type} = \n    \"Media Player\",\"CTV\"\
        ),\n  when(${ncd_fact_nexxen_dsp_test_raw_rev2.device_type} = \n    \"Games Console\",\"\
        CTV\"),\n  when(${ncd_fact_nexxen_dsp_test_raw_rev2.device_type} = \n    \"PC\",\"Desktop\"\
        ),\n  when(${ncd_fact_nexxen_dsp_test_raw_rev2.device_type} = \n    \"E-Reader\",\"Tablet\"\
        ),\n  when(${ncd_fact_nexxen_dsp_test_raw_rev2.device_type} = \n    \"\",\"Other\"),\n${ncd_fact_nexxen_dsp_test_raw_rev2.device_type})"
      label: Device Type Category
      value_format:
      value_format_name:
      dimension: device_type_category
      _kind_hint: dimension
      _type_hint: string
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: ncd
      palette_id: ncd-categorical-0
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      ncd_fact_nexxen_dsp_test_raw_rev2.impressions: IMPRESSIONS
      ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P: VCR
      ncd_fact_nexxen_dsp_test_raw_rev2.CTR_1P: CTR
      ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr: CTR
      ncd_fact_nexxen_dsp_test_raw_rev2.format: FORMAT
      ncd_fact_nexxen_dsp_test_raw_rev2.complete_events: COMPLETE EVENTS
      ncd_fact_nexxen_dsp_test_raw_rev2.ncd_clicks: CLICKS
    series_cell_visualizations:
      ncd_fact_nexxen_dsp_test_raw_rev2.impressions:
        is_active: false
    header_font_color: "#636E7A"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: IMPRESSIONS, orientation: left, series: [{axisId: ncd_fact_nexxen_dsp_test_raw_rev2.impressions,
            id: ncd_fact_nexxen_dsp_test_raw_rev2.impressions, name: IMPRESSIONS}], showLabels: true,
        showValues: true, valueFormat: '0,, "M"', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: VCR, orientation: right, series: [
          {axisId: ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P, id: ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P, name: VCR}],
        showLabels: true, showValues: true, valueFormat: 0%, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: '', orientation: right, series: [
          {axisId: ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr, id: ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr, name: CTR}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}]
    x_axis_label: ''
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      ncd_fact_nexxen_dsp_test_raw_rev2.impressions: "#3d00ac"
      ncd_fact_nexxen_dsp_test_raw_rev2.complete_events: "#CCA211"
      ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P: "#8CF585"
    advanced_vis_config: |-
      {
        chart: {},
      series: [{
            name: 'IMPRESSIONS',
            type: 'column',
            borderRadius: 3,
            animation: {
              duration: 1000 // Animation duration for this series
            }
          }, {
            name: 'VCR',
            type: 'spline',
            lineWidth: 3,
            animation: {
              duration: 1000 // Animation duration for this series
            }
          },
          {
            name: 'CTR',
            type: 'spline',
            lineWidth: 3,
            animation: {
              duration: 1000 // Animation duration for this series
            }
          }
        ]
      }
    show_null_points: true
    cluster_points: false
    quadrants_enabled: false
    quadrant_properties:
      '0':
        color: ''
        label: Quadrant 1
      '1':
        color: ''
        label: Quadrant 2
      '2':
        color: ''
        label: Quadrant 3
      '3':
        color: ''
        label: Quadrant 4
    custom_quadrant_point_x: 5
    custom_quadrant_point_y: 5
    custom_x_column: ''
    custom_y_column: ''
    custom_value_label_column: ''
    defaults_version: 1
    listen:
      Package: ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname
      Tactic: ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname
      Campaign: ncd_fact_nexxen_dsp_test_raw_rev2.name
      Date: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
      Advertiser: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
      Creative Group A: ncd_fact_nexxen_dsp_test_raw_rev2.creative_group_a
    row: 21
    col: 0
    width: 10
    height: 6
  - title: Delivery & Performance by Package
    name: Delivery & Performance by Package
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    type: looker_grid
    fields: [ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname, ncd_fact_nexxen_dsp_test_raw_rev2.start_date__c_date,
      ncd_fact_nexxen_dsp_test_raw_rev2.end_date__c_date, ncd_fact_nexxen_dsp_test_raw_rev2lineitem.price_type_name__c,
      ncd_fact_nexxen_dsp_test_raw_rev2lineitem.booked_rate, ncd_fact_nexxen_dsp_test_raw_rev2lineitem.budgeted_units,
      ncd_fact_nexxen_dsp_test_raw_rev2lineitem.budgeted_spend, ncd_fact_nexxen_dsp_test_raw_rev2.delivered_units,
      ncd_fact_nexxen_dsp_test_raw_rev2.Delivered_Spend, ncd_fact_nexxen_dsp_test_raw_rev2.total_pacing, ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P,
      ncd_fact_nexxen_dsp_test_raw_rev2.complete_events, ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr, ncd_fact_nexxen_dsp_test_raw_rev2.ncd_clicks]
    filters: {}
    sorts: [ncd_fact_nexxen_dsp_test_raw_rev2.start_date__c_date desc]
    limit: 500
    column_limit: 50
    total: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: ncd
      palette_id: ncd-categorical-0
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      ncd_fact_nexxen_dsp_test_raw_rev2.cogs: Total Spend
      ncd_fact_nexxen_dsp_test_raw_rev2lineitem.start_date__c_date: Start Date
      ncd_fact_nexxen_dsp_test_raw_rev2lineitem.end_date__c_date: End Date
      ncd_fact_nexxen_dsp_test_raw_rev2.name: Package Name
      ncd_fact_nexxen_dsp_test_raw_rev2lineitem.price_type_name__c: PRICE TYPE
      ncd_fact_nexxen_dsp_test_raw_rev2.CTR_1P: CTR
      ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P: VCR
      ncd_fact_nexxen_dsp_test_raw_rev2.pacing: "% Delivered"
      ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname: PACKAGE
      ncd_fact_nexxen_dsp_test_raw_rev2.impressions: IMPRESSIONS
      ncd_fact_nexxen_dsp_test_raw_rev2.delivered_units: DELIVERED UNITS
      ncd_fact_nexxen_dsp_test_raw_rev2.Delivered_Spend: DELIVERED SPEND
      ncd_fact_nexxen_dsp_test_raw_rev2.campaign: CAMPAIGN
      ncd_fact_nexxen_dsp_test_raw_rev2lineitem.budgeted_units: BUDGETED UNITS
      ncd_fact_nexxen_dsp_test_raw_rev2lineitem.budgeted_spend: BUDGETED SPEND
      ncd_fact_nexxen_dsp_test_raw_rev2.start_date__c_date: START DATE
      ncd_fact_nexxen_dsp_test_raw_rev2.end_date__c_date: END DATE
      ncd_fact_nexxen_dsp_test_raw_rev2lineitem.booked_rate: BOOKED RATE
      ncd_fact_nexxen_dsp_test_raw_rev2.total_pacing: PACING %
      ncd_fact_nexxen_dsp_test_raw_rev2.complete_events: COMPLETE EVENTS
      ncd_fact_nexxen_dsp_test_raw_rev2.clicks: CLICKS
      ncd_fact_nexxen_dsp_test_raw_rev2.ncd_clicks: CLICKS
      ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr: CTR
    series_cell_visualizations:
      ncd_fact_nexxen_dsp_test_raw_rev2.impressions:
        is_active: false
        palette:
          palette_id: ncd-sequential-0
          collection_id: ncd
    header_font_color: "#636E7A"
    series_value_format:
      ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P:
        name: percent_1
        decimals: '1'
        format_string: "#,##0.0%"
        label: Percent (1)
        label_prefix: Percent
      ncd_fact_nexxen_dsp_test_raw_rev2.complete_events:
        name: decimal_0
        decimals: '0'
        format_string: "#,##0"
        label: Decimals (0)
        label_prefix: Decimals
      ncd_fact_nexxen_dsp_test_raw_rev2lineitem.budgeted_spend:
        name: usd_0
        decimals: '0'
        format_string: "$#,##0"
        label: U.S. Dollars (0)
        label_prefix: U.S. Dollars
      ncd_fact_nexxen_dsp_test_raw_rev2lineitem.budgeted_units:
        format_string:
      ncd_fact_nexxen_dsp_test_raw_rev2.Delivered_Spend:
        format_string: "$#,##0.00"
      ncd_fact_nexxen_dsp_test_raw_rev2lineitem.booked_rate:
        name: usd
        decimals: '2'
        format_string: "$#,##0.00"
        label: U.S. Dollars (2)
        label_prefix: U.S. Dollars
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: 'DELIVERED UNITS [MILLIONS]', orientation: left, series: [{axisId: ncd_fact_nexxen_dsp_test_raw_rev2.delivered_units,
            id: ncd_fact_nexxen_dsp_test_raw_rev2.delivered_units, name: Delivered Units}], showLabels: true,
        showValues: true, valueFormat: '0,, "M"', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P, id: ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P, name: VCR}],
        showLabels: true, showValues: true, valueFormat: 0%, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_label: TACTIC
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      ncd_fact_nexxen_dsp_test_raw_rev2.delivered_units: "#4D3D69"
      ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P: "#CCA211"
    advanced_vis_config: |-
      {
        chart: {},
        plotOptions: {
          column: {
            borderRadius: 3
          },
          series: {
            borderWidth: 0,
            "animation": {
              "duration": 1500,
              "easing": "easeOutBounce"
            }
          }
        },
        series: [{
          name: 'DELIVERED UNITS'
        }]
      }
    value_labels: legend
    label_type: labPer
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Package: ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname
      Campaign: ncd_fact_nexxen_dsp_test_raw_rev2.name
      Format: ncd_fact_nexxen_dsp_test_raw_rev2.format
      Date: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
      Advertiser: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
      Creative Group A: ncd_fact_nexxen_dsp_test_raw_rev2.creative_group_a
    row: 27
    col: 5
    width: 19
    height: 7
  - title: Reach and Frequency
    name: Reach and Frequency
    model: Nexxen_DSP_NCD_Perf
    explore: fact_reach_advertiser
    type: looker_bar
    fields: [fact_reach_frequency.date_range, fact_reach_frequency.reach, fact_reach_frequency.frequency,
      fact_reach_frequency.date_border_date]
    filters: {}
    sorts: [fact_reach_frequency.date_border_date desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: ncd
      palette_id: ncd-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: top, series: [{axisId: fact_reach_frequency.frequency,
            id: fact_reach_frequency.frequency, name: FREQUENCY}], showLabels: true,
        showValues: true, valueFormat: '0.0', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: '', orientation: bottom, series: [
          {axisId: fact_reach_frequency.reach, id: fact_reach_frequency.reach, name: REACH}],
        showLabels: true, showValues: true, valueFormat: '0.0,,"M"', unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      fact_reach_frequency.frequency: "#b68eff"
    series_labels:
      fact_reach_frequency.reach: REACH
      fact_reach_frequency.date_range: DATE RANGE
      fact_reach_frequency.frequency: FREQUENCY
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      fact_reach_frequency.reach:
        is_active: false
    header_font_color: "#47624F"
    hidden_fields: [fact_reach_frequency.date_border_date]
    defaults_version: 1
    listen:
      Advertiser: fact_reach_frequency.advertiser_name
    row: 34
    col: 0
    width: 24
    height: 7
  - title: Top CTV Devices
    name: Top CTV Devices
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    type: looker_column
    fields: [ncd_fact_nexxen_dsp_test_raw_rev2.device_manufacturer, ncd_fact_nexxen_dsp_test_raw_rev2.impressions]
    filters:
      ncd_fact_nexxen_dsp_test_raw_rev2.device_manufacturer: Samsung,Amazon,Apple,Toshiba,Roku,Sony,Insignia,Tcl,Philips,Google,Vizio,LG,Comcast,HiSense,AT&T
    sorts: [ncd_fact_nexxen_dsp_test_raw_rev2.impressions desc]
    limit: 5
    column_limit: 50
    dynamic_fields:
    - category: dimension
      expression: "case(\n  when(${ncd_fact_nexxen_dsp_test_raw_rev2.device_type}=\"TV\",\"CTV\"\
        ) \n  ,when(${ncd_fact_nexxen_dsp_test_raw_rev2.device_type}=\"Set Top Box\",\"CTV\"),\n\
        \  when(${ncd_fact_nexxen_dsp_test_raw_rev2.device_type} = \n    \"Media Player\",\"CTV\"\
        ),\n  when(${ncd_fact_nexxen_dsp_test_raw_rev2.device_type} = \n    \"Games Console\",\"\
        CTV\"),\n  when(${ncd_fact_nexxen_dsp_test_raw_rev2.device_type} = \n    \"PC\",\"Desktop\"\
        ),\n  when(${ncd_fact_nexxen_dsp_test_raw_rev2.device_type} = \n    \"E-Reader\",\"Tablet\"\
        ),\n  when(${ncd_fact_nexxen_dsp_test_raw_rev2.device_type} = \n    \"\",\"Other\"),\n${ncd_fact_nexxen_dsp_test_raw_rev2.device_type})"
      label: Device Type Category
      value_format:
      value_format_name:
      dimension: device_type_category
      _kind_hint: dimension
      _type_hint: string
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: ncd
      palette_id: ncd-categorical-0
      options:
        steps: 5
    y_axes: [{label: IMPRESSIONS, orientation: left, series: [{axisId: ncd_fact_nexxen_dsp_test_raw_rev2.html_impr_comp_event,
            id: ncd_fact_nexxen_dsp_test_raw_rev2.html_impr_comp_event, name: Impressions}], showLabels: true,
        showValues: true, valueFormat: '0.0,,"M"', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      Pluto TV: "#4D3D69"
      Plex: "#CCA211"
      Tubi TV: "#15003B"
      Samsung TV Plus: "#15003B"
      Fawesome TV: "#BCB7C6"
      Outside TV: "#15003B"
    series_labels:
      ncd_fact_nexxen_dsp_test_raw_rev2.impressions: IMPRESSIONS
    advanced_vis_config: |-
      {
        chart: {},
        plotOptions: {
          column: {
            borderRadius: 3
          },
          series: {
            borderWidth: 0,
            "animation": {
              "duration": 1500,
              "easing": "easeOutBounce"
            }
          }
        }
      }
    value_labels: legend
    label_type: labPer
    inner_radius: 50
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Package: ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname
      Tactic: ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname
      Campaign: ncd_fact_nexxen_dsp_test_raw_rev2.name
      Format: ncd_fact_nexxen_dsp_test_raw_rev2.format
      Date: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
      Advertiser: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
      Creative Group A: ncd_fact_nexxen_dsp_test_raw_rev2.creative_group_a
    row: 21
    col: 10
    width: 7
    height: 6
  - name: " (4)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |-
      <a style=" color: black;  font-style: italic; text-decoration: none" >All metrics shown in the Nexxen platform are preliminary. Final metrics are provided via invoice. Nexxen is not responsible for data entry errors, budget or tactic selection, or any third-party costs incurred by you or on your behalf. <br>
      Delivered Units/Spend = Billable Reporting Source | All Other Metrics = Nexxen 1st Party Data <br>
      Reach out to your Nexxen account team for questions and dashboard customizations.</a>
    row: 41
    col: 0
    width: 24
    height: 2
  - title: Geographic Performance
    name: Geographic Performance
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    type: looker_grid
    fields: [ncd_fact_nexxen_dsp_test_raw_rev2.region_name, ncd_fact_nexxen_dsp_test_raw_rev2.dma_name_public, ncd_fact_nexxen_dsp_test_raw_rev2.zip_code,
      ncd_fact_nexxen_dsp_test_raw_rev2.impressions, ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P, ncd_fact_nexxen_dsp_test_raw_rev2.complete_events,
      ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr, ncd_fact_nexxen_dsp_test_raw_rev2.ncd_clicks]
    filters:
      ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname: ''
      ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname: ''
    sorts: [ncd_fact_nexxen_dsp_test_raw_rev2.impressions desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: ncd
      palette_id: ncd-categorical-0
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      ncd_fact_nexxen_dsp_test_raw_rev2.dma_name: DMA NAME
      ncd_fact_nexxen_dsp_test_raw_rev2.zip_code: ZIP CODE
      ncd_fact_nexxen_dsp_test_raw_rev2.impressions: IMPRESSIONS
      ncd_fact_nexxen_dsp_test_raw_rev2.complete_events: COMPLETE EVENTS
      ncd_fact_nexxen_dsp_test_raw_rev2.VCR_1P: VCR
      ncd_fact_nexxen_dsp_test_raw_rev2.region_name: REGION NAME
      ncd_fact_nexxen_dsp_test_raw_rev2.dma_name_public: DMA NAME
      ncd_fact_nexxen_dsp_test_raw_rev2.ncd_ctr: CTR
      ncd_fact_nexxen_dsp_test_raw_rev2.ncd_clicks: CLICKS
    series_cell_visualizations:
      ncd_fact_nexxen_dsp_test_raw_rev2.impressions:
        is_active: true
        palette:
          palette_id: ncd-sequential-0
          collection_id: ncd
    header_font_color: "#636E7A"
    hidden_fields: []
    hidden_points_if_no: []
    defaults_version: 1
    listen:
      Date: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
      Advertiser: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
    row: 13
    col: 12
    width: 12
    height: 8
  - title: Clicks
    name: Clicks
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    type: single_value
    fields: [ncd_fact_nexxen_dsp_test_raw_rev2.html_kpi_clicks]
    filters:
      ncd_fact_nexxen_dsp_test_raw_rev2.name: ''
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      label: Change
      value_format:
      value_format_name: percent_2
      calculation_type: percent_difference_from_previous
      table_calculation: change
      args:
      - ncd_fact_nexxen_dsp_test_raw_rev2.Delivered_Spend
      _kind_hint: measure
      _type_hint: number
      is_disabled: true
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#4D3D69"
    single_value_title: "."
    comparison_label: "."
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    hidden_pivots: {}
    listen:
      Package: ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname
      Tactic: ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname
      Campaign: ncd_fact_nexxen_dsp_test_raw_rev2.name
      Format: ncd_fact_nexxen_dsp_test_raw_rev2.format
      Date: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
      Advertiser: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
      Creative Group A: ncd_fact_nexxen_dsp_test_raw_rev2.creative_group_a
    row: 2
    col: 12
    width: 3
    height: 3
  - title: Complete Events
    name: Complete Events
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    type: single_value
    fields: [ncd_fact_nexxen_dsp_test_raw_rev2.html_kpi_complete_events]
    filters:
      ncd_fact_nexxen_dsp_test_raw_rev2.name: ''
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      label: Change
      value_format:
      value_format_name: percent_2
      calculation_type: percent_difference_from_previous
      table_calculation: change
      args:
      - ncd_fact_nexxen_dsp_test_raw_rev2.Delivered_Spend
      _kind_hint: measure
      _type_hint: number
      is_disabled: true
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#4D3D69"
    single_value_title: "."
    comparison_label: "."
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    hidden_pivots: {}
    listen:
      Package: ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname
      Tactic: ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname
      Campaign: ncd_fact_nexxen_dsp_test_raw_rev2.name
      Format: ncd_fact_nexxen_dsp_test_raw_rev2.format
      Date: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
      Advertiser: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
      Creative Group A: ncd_fact_nexxen_dsp_test_raw_rev2.creative_group_a
    row: 2
    col: 18
    width: 3
    height: 3
  - title: CTR
    name: CTR
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    type: single_value
    fields: [ncd_fact_nexxen_dsp_test_raw_rev2.html_kpi_ctr]
    filters:
      ncd_fact_nexxen_dsp_test_raw_rev2.name: ''
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      label: Change
      value_format:
      value_format_name: percent_2
      calculation_type: percent_difference_from_previous
      table_calculation: change
      args:
      - ncd_fact_nexxen_dsp_test_raw_rev2.Delivered_Spend
      _kind_hint: measure
      _type_hint: number
      is_disabled: true
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#4D3D69"
    single_value_title: "."
    comparison_label: "."
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    hidden_pivots: {}
    listen:
      Package: ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname
      Tactic: ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname
      Campaign: ncd_fact_nexxen_dsp_test_raw_rev2.name
      Format: ncd_fact_nexxen_dsp_test_raw_rev2.format
      Date: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
      Advertiser: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
      Creative Group A: ncd_fact_nexxen_dsp_test_raw_rev2.creative_group_a
    row: 2
    col: 9
    width: 3
    height: 3
  - name: " (5)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |-
      <div text-align="center" position="relative">
      <img src="https://missouripartnership.com/wp-content/uploads/2021/12/nexxen-logo.png" width="80%" position="absolute">
        </div>
    row: 0
    col: 18
    width: 3
    height: 2
  filters:
  - name: Date
    title: Date
    type: field_filter
    default_value: 90 day ago for 90 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    listens_to_filters: []
    field: ncd_fact_nexxen_dsp_test_raw_rev2.date_key_date
  - name: Advertiser
    title: Advertiser
    type: field_filter
    default_value: CHAIRKING-CHAIRKING,McDonalds Franchisees - Moroch,RIESTER-PARKCITY-CHAMBERBUREAU,RIESTER-CASINO
      ARIZONA
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options:
      - CHAIRKING-CHAIRKING
      - McDonalds Franchisees - Moroch
      - RIESTER-PARKCITY-CHAMBERBUREAU
      - RIESTER-CASINO ARIZONA
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    listens_to_filters: []
    field: ncd_fact_nexxen_dsp_test_raw_rev2.advertiser_name
  - name: Campaign
    title: Campaign
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    listens_to_filters: [Advertiser]
    field: ncd_fact_nexxen_dsp_test_raw_rev2.campaign
  - name: Package
    title: Package
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    listens_to_filters: [Advertiser]
    field: ncd_fact_nexxen_dsp_test_raw_rev2.package_nickname
  - name: Tactic
    title: Tactic
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    listens_to_filters: [Advertiser]
    field: ncd_fact_nexxen_dsp_test_raw_rev2.line_item_nickname
  - name: Format
    title: Format
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options:
      - Audio
      - Display
      - Video
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    listens_to_filters: []
    field: ncd_fact_nexxen_dsp_test_raw_rev2.format
  - name: Creative Group A
    title: Creative Group A
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: Nexxen_DSP_NCD_Perf
    explore: fact_nexxen_ncd_perf_advertiser
    listens_to_filters: []
    field: ncd_fact_nexxen_dsp_test_raw_rev2.creative_group_a
