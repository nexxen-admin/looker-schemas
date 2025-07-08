---
- dashboard: strategic_sales_forecast_snapshot_report_poc
  title: Test_Strategic_Sales_Forecast
  layout: newspaper
  description: ''
  filters_bar_collapsed: true
  filters_location_top: false
  preferred_slug: 8Ze0MCN1V8X29VfsS9400q
  elements:
  - title: By Regional VP
    name: By Regional VP
    model: forecast
    explore: snapshot_quarterly_forecast
    type: looker_column
    fields: [snapshot_quarterly_forecast.strat_sales_rvp, sum_scheduled_net_revenue_v2]
    sorts: [sum_scheduled_net_revenue_v2 desc, snapshot_quarterly_forecast.strat_sales_rvp]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: measure
      expression:
      label: Sum Scheduled Net Revenue V2
      value_format:
      value_format_name:
      based_on: snapshot_quarterly_forecast.scheduled_net_revenue_v2
      _kind_hint: measure
      measure: sum_scheduled_net_revenue_v2
      type: sum
      _type_hint: number
      filters: {}
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
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      sum_scheduled_net_revenue_v2: "#079c98"
    advanced_vis_config: |-
      {
        chart: {},
        series: [{
          name: 'Sum Scheduled Net Revenue V2'
        }]
      }
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Opportunity Owner: snapshot_quarterly_forecast.opportunity_owner
      Io Type: snapshot_quarterly_forecast.io_type
      Related Brand: snapshot_quarterly_forecast.related_brand
      Strat Sales RVP: snapshot_quarterly_forecast.strat_sales_rvp
      Strat Sales Team: snapshot_quarterly_forecast.strat_sales_team
      Revenue Line v2: snapshot_quarterly_forecast.revenue_line_v2
    row: 4
    col: 1
    width: 21
    height: 8
  - title: By Regional VP (Copy)
    name: By Regional VP (Copy)
    model: Standby_Environment_looks_dashboards
    explore: snapshot_quarterly_forecast
    type: looker_grid
    fields: [group_by_strat_sales_rvp, sum_scheduled_net_revenue_v2, snapshot_quarterly_forecast.opportunity_owner]
    sorts: [sum_scheduled_net_revenue_v2 desc, group_by_strat_sales_rvp]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: measure
      expression:
      label: Sum Scheduled Net Revenue V2
      value_format:
      value_format_name:
      based_on: snapshot_quarterly_forecast.scheduled_net_revenue_v2
      _kind_hint: measure
      measure: sum_scheduled_net_revenue_v2
      type: sum
      _type_hint: number
    - category: dimension
      description: ''
      label: Group By Strat Sales RVP
      value_format:
      value_format_name:
      calculation_type: group_by
      dimension: group_by_strat_sales_rvp
      args:
      - snapshot_quarterly_forecast.strat_sales_rvp
      - - label: West
          filter: West
        - label: East
          filter: East
        - label: 'South '
          filter: South
        - label: 'Central '
          filter: Central
        - label: Canada
          filter: Canada
      - Other
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
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: true
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: []
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels: {}
    series_cell_visualizations:
      sum_scheduled_net_revenue_v2:
        is_active: true
        palette:
          palette_id: cfba0c0c-68f4-cbd9-fed7-96b3303d994c
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#ffffff"
          - "#79c798"
    conditional_formatting: [{type: greater than, value: 1, background_color: "#12B5CB",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [sum_scheduled_net_revenue_v2]}]
    series_value_format:
      sum_scheduled_net_revenue_v2:
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
    hidden_fields: []
    hidden_points_if_no: []
    truncate_column_names: false
    hidden_pivots: {}
    listen:
      Opportunity Owner: snapshot_quarterly_forecast.opportunity_owner
      Io Type: snapshot_quarterly_forecast.io_type
      Related Brand: snapshot_quarterly_forecast.related_brand
      Strat Sales RVP: snapshot_quarterly_forecast.strat_sales_rvp
      Strat Sales Team: snapshot_quarterly_forecast.strat_sales_team
      Revenue Line v2: snapshot_quarterly_forecast.revenue_line_v2
    row: 12
    col: 1
    width: 21
    height: 8
  - title: By Account & Related Brand
    name: By Account & Related Brand
    model: Standby_Environment_looks_dashboards
    explore: snapshot_quarterly_forecast
    type: looker_grid
    fields: [snapshot_quarterly_forecast.related_brand, sum_scheduled_net_revenue_v2]
    sorts: [snapshot_quarterly_forecast.related_brand]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - category: measure
      expression:
      label: Sum Scheduled Net Revenue V2
      value_format:
      value_format_name:
      based_on: snapshot_quarterly_forecast.scheduled_net_revenue_v2
      _kind_hint: measure
      measure: sum_scheduled_net_revenue_v2
      type: sum
      _type_hint: number
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: true
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      sum_scheduled_net_revenue_v2:
        is_active: false
        palette:
          palette_id: a190b580-4512-921b-a8b6-aa98d6094e77
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#fafffc"
          - "#3A4245"
    conditional_formatting: [{type: greater than, value: 1, background_color: "#97c798",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [sum_scheduled_net_revenue_v2]}]
    series_value_format:
      sum_scheduled_net_revenue_v2:
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
    hidden_pivots: {}
    listen:
      Opportunity Owner: snapshot_quarterly_forecast.opportunity_owner
      Io Type: snapshot_quarterly_forecast.io_type
      Related Brand: snapshot_quarterly_forecast.related_brand
      Strat Sales RVP: snapshot_quarterly_forecast.strat_sales_rvp
      Strat Sales Team: snapshot_quarterly_forecast.strat_sales_team
      Revenue Line v2: snapshot_quarterly_forecast.revenue_line_v2
    row: 20
    col: 1
    width: 21
    height: 8
  - title: By Opportunity
    name: By Opportunity
    model: Standby_Environment_looks_dashboards
    explore: snapshot_quarterly_forecast
    type: looker_grid
    fields: [snapshot_quarterly_forecast.opportunity_owner, snapshot_quarterly_forecast.related_brand,
      snapshot_quarterly_forecast.io_type]
    sorts: [snapshot_quarterly_forecast.related_brand]
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
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    listen:
      Opportunity Owner: snapshot_quarterly_forecast.opportunity_owner
      Io Type: snapshot_quarterly_forecast.io_type
      Related Brand: snapshot_quarterly_forecast.related_brand
      Strat Sales RVP: snapshot_quarterly_forecast.strat_sales_rvp
      Strat Sales Team: snapshot_quarterly_forecast.strat_sales_team
      Revenue Line v2: snapshot_quarterly_forecast.revenue_line_v2
    row: 28
    col: 1
    width: 21
    height: 8
  - title: Snapshot by Month - TL
    name: Snapshot by Month - TL
    model: Standby_Environment_looks_dashboards
    explore: snapshot_quarterly_forecast
    type: looker_grid
    fields: [snapshot_quarterly_forecast.io_type, snapshot_quarterly_forecast.today_month,
      snapshot_quarterly_forecast.count]
    pivots: [snapshot_quarterly_forecast.today_month]
    fill_fields: [snapshot_quarterly_forecast.today_month]
    sorts: [snapshot_quarterly_forecast.today_month, snapshot_quarterly_forecast.io_type]
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
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
      Opportunity Owner: snapshot_quarterly_forecast.opportunity_owner
      Io Type: snapshot_quarterly_forecast.io_type
      Related Brand: snapshot_quarterly_forecast.related_brand
      Strat Sales RVP: snapshot_quarterly_forecast.strat_sales_rvp
      Strat Sales Team: snapshot_quarterly_forecast.strat_sales_team
      Revenue Line v2: snapshot_quarterly_forecast.revenue_line_v2
    row: 36
    col: 1
    width: 21
    height: 8
  - title: Snapshot by Month - NR
    name: Snapshot by Month - NR
    model: Standby_Environment_looks_dashboards
    explore: snapshot_quarterly_forecast
    type: looker_grid
    fields: [snapshot_quarterly_forecast.io_type, snapshot_quarterly_forecast.today_month,
      snapshot_quarterly_forecast.count]
    pivots: [snapshot_quarterly_forecast.today_month]
    fill_fields: [snapshot_quarterly_forecast.today_month]
    sorts: [snapshot_quarterly_forecast.today_month, snapshot_quarterly_forecast.io_type]
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
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
      Opportunity Owner: snapshot_quarterly_forecast.opportunity_owner
      Io Type: snapshot_quarterly_forecast.io_type
      Related Brand: snapshot_quarterly_forecast.related_brand
      Strat Sales RVP: snapshot_quarterly_forecast.strat_sales_rvp
      Strat Sales Team: snapshot_quarterly_forecast.strat_sales_team
      Revenue Line v2: snapshot_quarterly_forecast.revenue_line_v2
    row: 44
    col: 1
    width: 21
    height: 8
  - title: Snapshot by Month - TL
    name: Snapshot by Month - TL (2)
    model: Standby_Environment_looks_dashboards
    explore: snapshot_quarterly_forecast
    type: looker_column
    fields: [snapshot_quarterly_forecast.io_type, snapshot_quarterly_forecast.count,
      snapshot_quarterly_forecast.today_quarter]
    pivots: [snapshot_quarterly_forecast.today_quarter]
    fill_fields: [snapshot_quarterly_forecast.today_quarter]
    sorts: [snapshot_quarterly_forecast.io_type, snapshot_quarterly_forecast.today_quarter]
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
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Opportunity Owner: snapshot_quarterly_forecast.opportunity_owner
      Io Type: snapshot_quarterly_forecast.io_type
      Related Brand: snapshot_quarterly_forecast.related_brand
      Strat Sales RVP: snapshot_quarterly_forecast.strat_sales_rvp
      Strat Sales Team: snapshot_quarterly_forecast.strat_sales_team
      Revenue Line v2: snapshot_quarterly_forecast.revenue_line_v2
    row: 52
    col: 1
    width: 21
    height: 8
  - title: 'QTD NR Forecast Trend By Day '
    name: 'QTD NR Forecast Trend By Day '
    model: Standby_Environment_looks_dashboards
    explore: snapshot_quarterly_forecast
    type: looker_area
    fields: [snapshot_quarterly_forecast.count, snapshot_quarterly_forecast.today_date]
    fill_fields: [snapshot_quarterly_forecast.today_date]
    sorts: [snapshot_quarterly_forecast.today_date desc]
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
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Opportunity Owner: snapshot_quarterly_forecast.opportunity_owner
      Io Type: snapshot_quarterly_forecast.io_type
      Related Brand: snapshot_quarterly_forecast.related_brand
      Strat Sales RVP: snapshot_quarterly_forecast.strat_sales_rvp
      Strat Sales Team: snapshot_quarterly_forecast.strat_sales_team
      Revenue Line v2: snapshot_quarterly_forecast.revenue_line_v2
    row: 68
    col: 1
    width: 21
    height: 8
  - title: QTD TL Forecast Trend By Day
    name: QTD TL Forecast Trend By Day
    model: Standby_Environment_looks_dashboards
    explore: snapshot_quarterly_forecast
    type: looker_area
    fields: [snapshot_quarterly_forecast.count, snapshot_quarterly_forecast.today_date]
    fill_fields: [snapshot_quarterly_forecast.today_date]
    sorts: [snapshot_quarterly_forecast.today_date desc]
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
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Opportunity Owner: snapshot_quarterly_forecast.opportunity_owner
      Io Type: snapshot_quarterly_forecast.io_type
      Related Brand: snapshot_quarterly_forecast.related_brand
      Strat Sales RVP: snapshot_quarterly_forecast.strat_sales_rvp
      Strat Sales Team: snapshot_quarterly_forecast.strat_sales_team
      Revenue Line v2: snapshot_quarterly_forecast.revenue_line_v2
    row: 60
    col: 1
    width: 21
    height: 8
  - title: " QTD Forecast Trend by Account & Related Brand"
    name: " QTD Forecast Trend by Account & Related Brand"
    model: Standby_Environment_looks_dashboards
    explore: snapshot_quarterly_forecast
    type: looker_grid
    fields: [snapshot_quarterly_forecast.related_brand, snapshot_quarterly_forecast.deal_type]
    sorts: [snapshot_quarterly_forecast.related_brand]
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
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    listen:
      Opportunity Owner: snapshot_quarterly_forecast.opportunity_owner
      Io Type: snapshot_quarterly_forecast.io_type
      Related Brand: snapshot_quarterly_forecast.related_brand
      Strat Sales RVP: snapshot_quarterly_forecast.strat_sales_rvp
      Strat Sales Team: snapshot_quarterly_forecast.strat_sales_team
      Revenue Line v2: snapshot_quarterly_forecast.revenue_line_v2
    row: 76
    col: 1
    width: 21
    height: 8
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "<div style=\"text-align: center;\">\n  <a href=\"https://www.iabuk.com/member-directory/nexxen\"\
      \ target=\"_blank\">\n    <img \n      src=\"https://media.licdn.com/dms/image/v2/D560BAQEcvZfUMT6ocQ/company-logo_200_200/company-logo_200_200/0/1686328959036/nexxen_inc_logo?e=2147483647&v=beta&t=9_0YoGGrnd7Cpy15-EhnkdyAJHucGjOJsM2zbBsbMUg\"\
      \ \n      style=\"width: 55%; max-width: 100%; height: auto; border-radius:\
      \ 50%;\"\n    >\n  </a>\n</div>\n"
    row: 0
    col: 1
    width: 3
    height: 4
  - name: " (2)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "<div style=\"text-align: center; padding-bottom: 10px;\">\n  <h2 style=\"\
      font-weight: bold; font-size: 28px; color: #15003B; margin-bottom: 5px;\">\U0001f4c8\
      \ Strategic Sales Forecast| Snapshot report POC</h2>\n  <p style=\"color: gray;\
      \ font-size: 14px; margin-top: 0;\">\n    \n  </p>\n</div>\n\n<hr style=\"border-top:\
      \ 6px solid #64BDC6; width: 60%; margin: 10px auto;\">\n  <p style=\"color:\
      \ red; margin: 0;\">\n    <span style=\"font-weight: bold; font-size: 16px;\"\
      >NOTE:</span>\n    <span style=\"font-weight: normal; font-size: 14px;\">\n\
      \     Dashboards are based on inputs from the integrated Salesforce instance\
      \ (post-migration). The consolidated forecast figures and salesforce opportunities\
      \ are still undergoing review for accuracy and excludes PMP forecast for now.\n\
      \    </span>\n"
    row: 0
    col: 4
    width: 17
    height: 4
  filters:
  - name: Strat Sales RVP
    title: Strat Sales RVP
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: Standby_Environment_looks_dashboards
    explore: snapshot_quarterly_forecast
    listens_to_filters: []
    field: snapshot_quarterly_forecast.strat_sales_rvp
  - name: Strat Sales Team
    title: Strat Sales Team
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: Standby_Environment_looks_dashboards
    explore: snapshot_quarterly_forecast
    listens_to_filters: []
    field: snapshot_quarterly_forecast.strat_sales_team
  - name: Revenue Line v2
    title: Revenue Line v2
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: Standby_Environment_looks_dashboards
    explore: snapshot_quarterly_forecast
    listens_to_filters: []
    field: snapshot_quarterly_forecast.revenue_line_v2
  - name: Opportunity Owner
    title: Opportunity Owner
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: Standby_Environment_looks_dashboards
    explore: snapshot_quarterly_forecast
    listens_to_filters: []
    field: snapshot_quarterly_forecast.opportunity_owner
  - name: Io Type
    title: Io Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: Standby_Environment_looks_dashboards
    explore: snapshot_quarterly_forecast
    listens_to_filters: []
    field: snapshot_quarterly_forecast.io_type
  - name: Related Brand
    title: Related Brand
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: Standby_Environment_looks_dashboards
    explore: snapshot_quarterly_forecast
    listens_to_filters: []
    field: snapshot_quarterly_forecast.related_brand
