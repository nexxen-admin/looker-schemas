---
- dashboard: msd_overview_chair_king
  title: MSD - Overview (Chair King)
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: DOFBibrsoXDIfnJqFdedXj
  elements:
  - type: button
    name: button_9832
    rich_content_json: '{"text":"Overview","description":"","newTab":false,"alignment":"center","size":"large","style":"OUTLINED","color":"#192d54","href":"https://tremor.cloud.looker.com/embed/dashboards/1873"}'
    row: 2
    col: 0
    width: 4
    height: 1
  - type: button
    name: button_9833
    rich_content_json: '{"text":"Creatives","description":"","newTab":false,"alignment":"center","size":"large","style":"TRANSPARENT","color":"#192d54","href":"https://tremor.cloud.looker.com/dashboards/1875"}'
    row: 4
    col: 0
    width: 4
    height: 1
  - type: button
    name: button_9834
    rich_content_json: '{"text":"DMA","description":"","newTab":false,"alignment":"center","size":"large","style":"TRANSPARENT","color":"#192d54","href":"https://tremor.cloud.looker.com/dashboards/1874"}'
    row: 3
    col: 0
    width: 4
    height: 1
  - title: Impressions & Clicks by date
    name: Impressions & Clicks by date
    model: Nexxen_dsp
    explore: fact_nexxen_dsp
    type: looker_line
    fields: [v_dim_dsp_date.date_key_date, fact_nexxen_dsp.impressions, fact_nexxen_dsp.clicks]
    fill_fields: [v_dim_dsp_date.date_key_date]
    filters: {}
    sorts: [v_dim_dsp_date.date_key_date desc]
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
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: fact_nexxen_dsp.impressions,
            id: fact_nexxen_dsp.impressions, name: Impressions}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: fact_nexxen_dsp.clicks,
            id: fact_nexxen_dsp.clicks, name: Clicks}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      fact_nexxen_dsp.impressions: "#1982c4"
      fact_nexxen_dsp.clicks: "#ff595e"
    defaults_version: 1
    listen:
      Date Key Date: v_dim_dsp_date.date_key_date
      Line Item Name: dim_sfdb_opportunitylineitem.line_item_name__c
      Advertiser Name: dim_dsp_advertiser.advertiser_name
    row: 6
    col: 14
    width: 10
    height: 7
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |-
      <div text-align="center">
      <img src="https://cdn11.bigcommerce.com/s-mm9ficts64/product_images/chairking-logo-web_1702046625__28519.png" width="85%" >
        </div>
    row: 0
    col: 0
    width: 4
    height: 2
  - title: New Tile
    name: New Tile
    model: Nexxen_dsp
    explore: fact_nexxen_dsp
    type: looker_grid
    fields: [v_dim_dsp_date.date_key_date, fact_nexxen_dsp.impressions, fact_nexxen_dsp.clicks,
      fact_nexxen_dsp.pacing]
    filters:
      fact_nexxen_dsp.impressions: ">0"
    sorts: [v_dim_dsp_date.date_key_date desc]
    limit: 500
    column_limit: 50
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
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      fact_nexxen_dsp.impressions:
        is_active: true
        palette:
          palette_id: 689de12a-ed1f-d5ee-b61b-0a6782aadfb3
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#1982c4"
          - "#ff595e"
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
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: fact_nexxen_dsp.impressions,
            id: fact_nexxen_dsp.impressions, name: Impressions}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: fact_nexxen_dsp.clicks,
            id: fact_nexxen_dsp.clicks, name: Clicks}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      fact_nexxen_dsp.impressions: navy
    defaults_version: 1
    title_hidden: true
    listen:
      Date Key Date: v_dim_dsp_date.date_key_date
      Line Item Name: dim_sfdb_opportunitylineitem.line_item_name__c
      Advertiser Name: dim_dsp_advertiser.advertiser_name
    row: 13
    col: 4
    width: 20
    height: 7
  - title: New Tile (Copy)
    name: New Tile (Copy)
    model: Nexxen_dsp
    explore: fact_nexxen_dsp
    type: looker_column
    fields: [v_dim_dsp_date.date_key_date, fact_nexxen_dsp.impressions, fact_nexxen_dsp.clicks]
    fill_fields: [v_dim_dsp_date.date_key_date]
    filters: {}
    sorts: [v_dim_dsp_date.date_key_date desc]
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
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: fact_nexxen_dsp.impressions,
            id: fact_nexxen_dsp.impressions, name: Impressions}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: fact_nexxen_dsp.clicks,
            id: fact_nexxen_dsp.clicks, name: Clicks}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      fact_nexxen_dsp.impressions: "#1982c4"
      fact_nexxen_dsp.clicks: "#ff595e"
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      fact_nexxen_dsp.impressions:
        is_active: true
        palette:
          palette_id: ba678197-eb0e-c047-7152-86403e42bd48
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - lightblue
          - navy
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hide_totals: false
    hide_row_totals: false
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    title_hidden: true
    listen:
      Date Key Date: v_dim_dsp_date.date_key_date
      Line Item Name: dim_sfdb_opportunitylineitem.line_item_name__c
      Advertiser Name: dim_dsp_advertiser.advertiser_name
    row: 20
    col: 4
    width: 20
    height: 7
  - title: Pacing by date
    name: Pacing by date
    model: Nexxen_dsp
    explore: fact_nexxen_dsp
    type: looker_area
    fields: [v_dim_dsp_date.date_key_date, fact_nexxen_dsp.pacing]
    fill_fields: [v_dim_dsp_date.date_key_date]
    filters: {}
    sorts: [v_dim_dsp_date.date_key_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${fact_nexxen_dsp.clicks}/${fact_nexxen_dsp.impressions}"
      label: Pacing %
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: pacing
      _type_hint: number
      is_disabled: true
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
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: fact_nexxen_dsp.impressions,
            id: fact_nexxen_dsp.impressions, name: Impressions}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: fact_nexxen_dsp.clicks,
            id: fact_nexxen_dsp.clicks, name: Clicks}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      fact_nexxen_dsp.impressions: navy
      pacing: "#15003b"
      fact_nexxen_dsp.pacing: "#1982c4"
    defaults_version: 1
    hidden_fields: []
    hidden_pivots: {}
    listen:
      Date Key Date: v_dim_dsp_date.date_key_date
      Line Item Name: dim_sfdb_opportunitylineitem.line_item_name__c
      Advertiser Name: dim_dsp_advertiser.advertiser_name
    row: 6
    col: 4
    width: 10
    height: 7
  - type: button
    name: button_9846
    rich_content_json: '{"text":"Device Insights","description":"","newTab":false,"alignment":"center","size":"large","style":"TRANSPARENT","color":"#192d54","href":"https://tremor.cloud.looker.com/dashboards/1877"}'
    row: 5
    col: 0
    width: 4
    height: 1
  - title: Campaign Last Active
    name: Campaign Last Active
    model: Nexxen_dsp
    explore: fact_nexxen_dsp
    type: marketplace_viz_multiple_value::multiple_value-KPI
    fields: [v_dim_dsp_date.date_key_date]
    filters:
      fact_nexxen_dsp.impressions: ">0"
    sorts: [v_dim_dsp_date.date_key_date desc]
    limit: 1
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${fact_nexxen_dsp.clicks}/${fact_nexxen_dsp.impressions}"
      label: Pacing %
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: pacing
      _type_hint: number
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: '9'
    orientation: vertical
    style_v_dim_dsp_date.date_key_date: "#3A4245"
    show_title_v_dim_dsp_date.date_key_date: true
    title_override_v_dim_dsp_date.date_key_date: Campaign Last Active
    title_placement_v_dim_dsp_date.date_key_date: below
    value_format_v_dim_dsp_date.date_key_date: ''
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
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: fact_nexxen_dsp.impressions,
            id: fact_nexxen_dsp.impressions, name: Impressions}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: fact_nexxen_dsp.clicks,
            id: fact_nexxen_dsp.clicks, name: Clicks}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      fact_nexxen_dsp.impressions: navy
      pacing: "#15003b"
    defaults_version: 0
    hidden_pivots: {}
    title_hidden: true
    listen:
      Line Item Name: dim_sfdb_opportunitylineitem.line_item_name__c
      Advertiser Name: dim_dsp_advertiser.advertiser_name
    row: 6
    col: 0
    width: 4
    height: 2
  - title: ''
    name: " (2)"
    model: Nexxen_dsp
    explore: fact_nexxen_dsp
    type: single_value
    fields: [fact_nexxen_dsp.html_kpi_board_line1]
    filters:
      dim_sfdb_account.name: ''
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    listen:
      Date Key Date: v_dim_dsp_date.date_key_date
      Line Item Name: dim_sfdb_opportunitylineitem.line_item_name__c
      Advertiser Name: dim_dsp_advertiser.advertiser_name
    row: 0
    col: 4
    width: 20
    height: 3
  - title: Line Items Details
    name: Line Items Details
    model: Nexxen_dsp
    explore: fact_nexxen_dsp
    type: looker_grid
    fields: [dim_sfdb_opportunitylineitem.line_item_name__c, dim_sfdb_opportunitylineitem.start_date__c_date,
      dim_sfdb_opportunitylineitem.end_date__c_date, dim_dsp_package.name, dim_sfdb_opportunitylineitem.price_type_name__c,
      dim_sfdb_opportunitylineitem.rate__c, dim_sfdb_opportunitylineitem.budgeted_units,
      dim_sfdb_opportunitylineitem.budgeted_spend, fact_nexxen_dsp.cogs, fact_nexxen_dsp.impressions,
      fact_nexxen_dsp.clicks, fact_nexxen_dsp.complete_events, fact_nexxen_dsp.CTR_1P,
      fact_nexxen_dsp.VCR_1P, fact_nexxen_dsp.pacing]
    filters: {}
    sorts: [fact_nexxen_dsp.impressions desc]
    limit: 500
    column_limit: 50
    total: true
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
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      fact_nexxen_dsp.cogs: Total Spend
      dim_sfdb_opportunitylineitem.start_date__c_date: Start Date
      dim_sfdb_opportunitylineitem.end_date__c_date: End Date
      dim_dsp_package.name: Package Name
      dim_sfdb_opportunitylineitem.price_type_name__c: Price Type
      fact_nexxen_dsp.CTR_1P: CTR
      fact_nexxen_dsp.VCR_1P: VCR
      fact_nexxen_dsp.pacing: "% Delivered"
    series_cell_visualizations:
      fact_nexxen_dsp.impressions:
        is_active: true
        palette:
          palette_id: 926920fb-1ebb-9062-6fba-e9c6dbf4eb55
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#1982c4"
          - "#ff595e"
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
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Date Key Date: v_dim_dsp_date.date_key_date
      Line Item Name: dim_sfdb_opportunitylineitem.line_item_name__c
      Advertiser Name: dim_dsp_advertiser.advertiser_name
    row: 27
    col: 4
    width: 20
    height: 7
  - title: " (Copy)"
    name: " (Copy)"
    model: Nexxen_dsp
    explore: fact_nexxen_dsp
    type: single_value
    fields: [fact_nexxen_dsp.html_kpi_board_line2]
    filters:
      dim_sfdb_account.name: ''
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    listen:
      Date Key Date: v_dim_dsp_date.date_key_date
      Line Item Name: dim_sfdb_opportunitylineitem.line_item_name__c
      Advertiser Name: dim_dsp_advertiser.advertiser_name
    row: 3
    col: 4
    width: 10
    height: 3
  - title: New Tile
    name: New Tile (2)
    model: Nexxen_dsp
    explore: fact_reach_accumulative
    type: single_value
    fields: [fact_reach_accumulative.html_kpi_board]
    filters:
      fact_reach_accumulative.account_name: ''
      fact_reach_accumulative.related_brand: ''
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${fact_reach_accumulative.impressions}/${fact_reach_accumulative.unique_users}"
      label: Frequency
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: frequency
      _type_hint: number
      is_disabled: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
      options:
        steps: 5
    up_color: false
    down_color: false
    total_color: false
    show_value_labels: false
    show_x_axis_ticks: true
    show_x_axis_label: true
    x_axis_scale: auto
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    arm_length: 25
    arm_weight: 50
    spinner_length: 100
    spinner_weight: 50
    angle: 90
    cutout: 50
    range_x: 1
    range_y: 1
    x_axis_gridlines: false
    show_view_names: false
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    label_density: 25
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    font_size: 12
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    groupBars: true
    labelSize: 10pt
    showLegend: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: legend
    label_type: labPer
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: These metrics are not affected by the date filter. Please reach out
      if you have questions
    listen:
      Advertiser Name: fact_reach_accumulative.advertiser_name
    row: 3
    col: 14
    width: 10
    height: 3
  - title: Pacing - test
    name: Pacing - test
    model: Nexxen_dsp
    explore: fact_nexxen_dsp
    type: looker_line
    fields: [dim_sfdb_opportunity.total_units__c, dim_sfdb_opportunitylineitem.gross_billable__c,
      dim_dsp_package_budget_schedule.start_date_in_timezone, dim_dsp_package_budget_schedule.end_date_in_timezone,
      dim_sfdb_opportunitylineitem.opportunitylineitem_aid__c, dim_sfdb_opportunitylineitem.price_type_name__c,
      fact_nexxen_dsp.pacing, fact_nexxen_dsp.impressions, dim_dsp_creative.creative_id,
      dim_sfdb_opportunitylineitem.units__c, v_dim_dsp_date.date_key_date, fact_nexxen_dsp.pacing_msd]
    filters:
      dim_dsp_advertiser.advertiser_name: CHAIRKING-CHAIRKING
      dim_sfdb_opportunitylineitem.opportunitylineitem_aid__c: 00kPF00000BAFZmYAP
    sorts: [cap desc]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - category: table_calculation
      expression: |-
        (${fact_nexxen_dsp.impressions}/
        ${cap})*100
      label: pacing
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: pacing
      _type_hint: number
    - category: table_calculation
      expression: diff_days(${dim_dsp_package_budget_schedule.start_date_in_timezone},${dim_dsp_package_budget_schedule.end_date_in_timezone})
      label: diff days
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: diff_days
      _type_hint: number
    - category: table_calculation
      expression: diff_days(${v_dim_dsp_date.date_key_date}, ${dim_dsp_package_budget_schedule.start_date_in_timezone})
      label: remaining
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: remaining
      _type_hint: number
    - category: table_calculation
      expression: |2-

        ${dim_sfdb_opportunitylineitem.units__c}/
        (diff_days(${dim_dsp_package_budget_schedule.start_date_in_timezone},${dim_dsp_package_budget_schedule.end_date_in_timezone})+1)
      label: cap
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: cap
      _type_hint: number
    - category: table_calculation
      expression: running_total(${cap})
      label: pacing Copy
      value_format:
      value_format_name: decimal_2
      _kind_hint: dimension
      table_calculation: pacing_copy
      _type_hint: number
    - category: table_calculation
      expression: |-
        (${fact_nexxen_dsp.impressions}/
        ${pacing_copy})*100
      label: pacing Copy 2
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: pacing_copy_2
      _type_hint: number
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
    show_null_points: true
    interpolation: linear
    hidden_fields: [dim_sfdb_opportunity.total_units__c, dim_sfdb_opportunitylineitem.gross_billable__c,
      dim_dsp_package_budget_schedule.start_date_in_timezone, dim_dsp_package_budget_schedule.end_date_in_timezone,
      dim_sfdb_opportunitylineitem.opportunitylineitem_aid__c, dim_sfdb_opportunitylineitem.price_type_name__c,
      dim_dsp_creative.creative_id, dim_sfdb_opportunitylineitem.units__c, diff_days,
      remaining, cap, pacing_copy, fact_nexxen_dsp.pacing, fact_nexxen_dsp.impressions,
      pacing_copy_2]
    defaults_version: 1
    listen: {}
    row: 34
    col: 4
    width: 20
    height: 6
  filters:
  - name: Date Key Date
    title: Date Key Date
    type: field_filter
    default_value: 14 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: Nexxen_dsp
    explore: fact_nexxen_dsp
    listens_to_filters: []
    field: v_dim_dsp_date.date_key_date
  - name: Advertiser Name
    title: Advertiser Name
    type: field_filter
    default_value: CHAIRKING-CHAIRKING
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: Nexxen_dsp
    explore: fact_nexxen_dsp
    listens_to_filters: []
    field: dim_dsp_advertiser.advertiser_name
  - name: Line Item Name
    title: Line Item Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: Nexxen_dsp
    explore: fact_nexxen_dsp
    listens_to_filters: [Advertiser Name]
    field: dim_sfdb_opportunitylineitem.line_item_name__c
