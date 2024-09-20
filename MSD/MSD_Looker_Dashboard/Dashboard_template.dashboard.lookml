---
- dashboard: msd__device_insights_empower
  title: MSD - Device Insights (Empower)
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: CaahK0K77S1aQbLT1zTzKM
  elements:
  - type: button
    name: button_10164
    rich_content_json: '{"text":"Overview","description":"","newTab":false,"alignment":"center","size":"large","style":"TRANSPARENT","color":"#192d54","href":"https://tremor.cloud.looker.com/dashboards/1931"}'
    row: 0
    col: 0
    width: 4
    height: 1
  - type: button
    name: button_10165
    rich_content_json: '{"text":"Creatives","description":"","newTab":false,"alignment":"center","size":"large","style":"TRANSPARENT","color":"#192d54","href":"https://tremor.cloud.looker.com/dashboards/1933"}'
    row: 2
    col: 0
    width: 4
    height: 1
  - type: button
    name: button_10166
    rich_content_json: '{"text":"DMA","description":"","newTab":false,"alignment":"center","size":"large","style":"TRANSPARENT","color":"#192d54","href":"https://tremor.cloud.looker.com/dashboards/1932"}'
    row: 1
    col: 0
    width: 4
    height: 1
  - title: Perfomance by device
    name: Perfomance by device
    model: dod_MSD
    explore: dsp_media_and_bids_advertiser
    type: looker_column
    fields: [dsp_media_and_bids.impression, dsp_media_and_bids.click, device_type_category]
    filters: {}
    sorts: [dsp_media_and_bids.impression desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${dsp_media_and_bids.click}/${dsp_media_and_bids.impression}"
      label: CTR
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: ctr
      _type_hint: number
    - category: dimension
      expression: "case(\n  when(${dsp_media_and_bids.device_type_name}=\"TV\",\"\
        CTV\") \n  ,when(${dsp_media_and_bids.device_type_name}=\"Set Top Box\",\"\
        CTV\"),\n  when(${dsp_media_and_bids.device_type_name} = \n    \"Media Player\"\
        ,\"CTV\"),\n  when(${dsp_media_and_bids.device_type_name} = \n    \"Games\
        \ Console\",\"CTV\"),\n  when(${dsp_media_and_bids.device_type_name} = \n\
        \    \"PC\",\"Desktop\"),\n  when(${dsp_media_and_bids.device_type_name} =\
        \ \n    \"E-Reader\",\"Tablet\"),\n  when(${dsp_media_and_bids.device_type_name}\
        \ = \n    \"\",\"Other\"),\n${dsp_media_and_bids.device_type_name})"
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
    y_axes: [{label: !!null '', orientation: left, series: [{axisId: dsp_media_and_bids.impression,
            id: dsp_media_and_bids.impression, name: Impression}], showLabels: true,
        showValues: true, valueFormat: '0.0,, "M"', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: '', orientation: right, series: [
          {axisId: ctr, id: ctr, name: CTR}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    label_value_format: 0.000,, "M"
    series_types:
      ctr: line
    series_colors:
      ctr: "#ff595e"
      dsp_media_and_bids.impression: "#1982c4"
    label_color: []
    hidden_fields: [dsp_media_and_bids.click]
    defaults_version: 1
    listen:
      " Time Date": dsp_media_and_bids.__time_date
      Device Type Name: dsp_media_and_bids.device_type_name
      Advertiser Name: dsp_media_and_bids.advertiser_name
    row: 0
    col: 14
    width: 10
    height: 7
  - type: button
    name: button_10168
    rich_content_json: '{"text":"Device Insights","description":"","newTab":false,"alignment":"center","size":"large","style":"OUTLINED","color":"#192d54","href":"https://tremor.cloud.looker.com/embed/dashboards/1934"}'
    row: 3
    col: 0
    width: 4
    height: 1
  - title: Perfomance by device (Copy)
    name: Perfomance by device (Copy)
    model: dod_MSD
    explore: dsp_media_and_bids_advertiser
    type: looker_grid
    fields: [dsp_media_and_bids.impression, dsp_media_and_bids.click, dsp_media_and_bids.cogs,
      device_type_category]
    filters: {}
    sorts: [dsp_media_and_bids.impression desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${dsp_media_and_bids.click}/${dsp_media_and_bids.impression}"
      label: CTR
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: ctr
      _type_hint: number
    - category: dimension
      expression: "case(\n  when(${dsp_media_and_bids.device_type_name}=\"TV\",\"\
        CTV\") \n  ,when(${dsp_media_and_bids.device_type_name}=\"Set Top Box\",\"\
        CTV\"),\n  when(${dsp_media_and_bids.device_type_name} = \n    \"Media Player\"\
        ,\"CTV\"),\n  when(${dsp_media_and_bids.device_type_name} = \n    \"Games\
        \ Console\",\"CTV\"),\n  when(${dsp_media_and_bids.device_type_name} = \n\
        \    \"PC\",\"Desktop\"),\n  when(${dsp_media_and_bids.device_type_name} =\
        \ \n    \"E-Reader\",\"Tablet\"),\n  when(${dsp_media_and_bids.device_type_name}\
        \ = \n    \"\",\"Other\"),\n${dsp_media_and_bids.device_type_name})"
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
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      dsp_media_and_bids.cogs: Spend
    series_cell_visualizations:
      dsp_media_and_bids.impression:
        is_active: true
        palette:
          palette_id: e9f14485-8a35-fb0f-6b6a-ea1108e217d3
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#1982c4"
          - "#ff595e"
    series_value_format:
      dsp_media_and_bids.cogs:
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
    defaults_version: 1
    title_hidden: true
    listen:
      " Time Date": dsp_media_and_bids.__time_date
      Device Type Name: dsp_media_and_bids.device_type_name
      Advertiser Name: dsp_media_and_bids.advertiser_name
    row: 7
    col: 5
    width: 19
    height: 7
  - title: Delivery by device
    name: Delivery by device
    model: dod_MSD
    explore: dsp_media_and_bids_advertiser
    type: looker_pie
    fields: [dsp_media_and_bids.count, device_type_category]
    filters: {}
    sorts: [dsp_media_and_bids.count desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${dsp_media_and_bids.click}/${dsp_media_and_bids.impression}"
      label: CTR
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: ctr
      _type_hint: number
      is_disabled: true
    - category: dimension
      expression: "case(\n  when(${dsp_media_and_bids.device_type_name}=\"TV\",\"\
        CTV\") \n  ,when(${dsp_media_and_bids.device_type_name}=\"Set Top Box\",\"\
        CTV\"),\n  when(${dsp_media_and_bids.device_type_name} = \n    \"Media Player\"\
        ,\"CTV\"),\n  when(${dsp_media_and_bids.device_type_name} = \n    \"Games\
        \ Console\",\"CTV\"),\n  when(${dsp_media_and_bids.device_type_name} = \n\
        \    \"PC\",\"Desktop\"),\n  when(${dsp_media_and_bids.device_type_name} =\
        \ \n    \"E-Reader\",\"Tablet\"),\n  when(${dsp_media_and_bids.device_type_name}\
        \ = \n    \"\",\"Other\"),\n${dsp_media_and_bids.device_type_name})"
      label: Device Type Category
      value_format:
      value_format_name:
      dimension: device_type_category
      _kind_hint: dimension
      _type_hint: string
    value_labels: legend
    label_type: labPer
    series_colors:
      ctr: "#8cf585"
      dsp_media_and_bids.impression: "#15003b"
      TV: "#1982c4"
      Set Top Box: "#ff595e"
      PC: "#ffca3f"
      Mobile Phone: "#8ac926"
      Tablet: "#ffca3f"
      Other: "#6a4c93"
      CTV: "#1982c4"
      Desktop: "#ff595e"
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
    y_axes: [{label: !!null '', orientation: left, series: [{axisId: dsp_media_and_bids.impression,
            id: dsp_media_and_bids.impression, name: Impression}], showLabels: true,
        showValues: true, valueFormat: '0.0,, "M"', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: '', orientation: right, series: [
          {axisId: ctr, id: ctr, name: CTR}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    label_value_format: 0.000,, "M"
    label_color: []
    hidden_fields: []
    defaults_version: 1
    hidden_pivots: {}
    listen:
      " Time Date": dsp_media_and_bids.__time_date
      Device Type Name: dsp_media_and_bids.device_type_name
      Advertiser Name: dsp_media_and_bids.advertiser_name
    row: 0
    col: 5
    width: 9
    height: 7
  filters:
  - name: " Time Date"
    title: " Time Date"
    type: field_filter
    default_value: 90 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: dod_MSD
    explore: dsp_media_and_bids_advertiser
    listens_to_filters: []
    field: dsp_media_and_bids.__time_date
  - name: Advertiser Name
    title: Advertiser Name
    type: field_filter
    default_value: EMPOWER-CROSSMEDIA
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: dod_MSD
    explore: dsp_media_and_bids_advertiser
    listens_to_filters: []
    field: dsp_media_and_bids.advertiser_name
  - name: Device Type Name
    title: Device Type Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: dod_MSD
    explore: dsp_media_and_bids_advertiser
    listens_to_filters: []
    field: dsp_media_and_bids.device_type_name
