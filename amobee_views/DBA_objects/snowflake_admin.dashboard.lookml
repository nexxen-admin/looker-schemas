- dashboard: snowflake_admin
  title: Snowflake_admin
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - title: Total cost by WH
    name: Total cost by WH
    model: snowflake_administration
    explore: new_warehouse_cost
    type: looker_area
    fields: [new_warehouse_cost.capture_date, new_warehouse_cost.sum_credits, warehouse_name_groups]
    pivots: [warehouse_name_groups]
    fill_fields: [new_warehouse_cost.capture_date]
    filters:
      new_warehouse_cost.capture_date: 31 days ago for 31 days
    sorts: [new_warehouse_cost.capture_date desc, warehouse_name_groups]
    limit: 500
    dynamic_fields: [{category: dimension, description: '', label: Warehouse Name
          Groups, value_format: !!null '', value_format_name: !!null '', calculation_type: group_by,
        dimension: warehouse_name_groups, args: [new_warehouse_cost.warehouse_name,
          [!ruby/hash:ActiveSupport::HashWithIndifferentAccess {label: Other, filter: '-"LI_WH",-"ETL_WH",-"LOOKER_WH",-"OASYS_WH",-"OASYS_SMALL_WH",-"SLA_WH"'}],
          !!null ''], _kind_hint: dimension, _type_hint: string}]
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
    stacking: normal
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
    series_types: {}
    trend_lines: []
    defaults_version: 1
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 6
  - title: Total Execution time by WH
    name: Total Execution time by WH
    model: snowflake_administration
    explore: new_query_history
    type: looker_area
    fields: [new_query_history.capture_date, warehouse_name_groups, new_query_history.sum_total_elapsed_time]
    pivots: [warehouse_name_groups]
    filters:
      new_query_history.capture_date: 31 days ago for 31 days
    sorts: [new_query_history.capture_date desc, warehouse_name_groups]
    limit: 500
    dynamic_fields: [{category: dimension, description: '', label: Warehouse Name
          Groups, value_format: !!null '', value_format_name: !!null '', calculation_type: group_by,
        dimension: warehouse_name_groups, args: [new_query_history.warehouse_name,
          [!ruby/hash:ActiveSupport::HashWithIndifferentAccess {label: Other, filter: '-"LI_WH",-"ETL_WH",-"LOOKER_WH",-"OASYS_WH",-"OASYS_SMALL_WH",-"SLA_WH"'}],
          !!null ''], _kind_hint: dimension, _type_hint: string}]
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
    stacking: normal
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
    series_types: {}
    defaults_version: 1
    ordering: none
    show_null_labels: false
    listen: {}
    row: 6
    col: 0
    width: 24
    height: 6
  - title: Total Queued time by WH
    name: Total Queued time by WH
    model: snowflake_administration
    explore: new_query_history
    type: looker_area
    fields: [new_query_history.capture_date, warehouse_name_groups, new_query_history.sum_queued_time]
    pivots: [warehouse_name_groups]
    filters:
      new_query_history.capture_date: 31 days ago for 31 days
    sorts: [new_query_history.capture_date desc, warehouse_name_groups]
    limit: 500
    dynamic_fields: [{category: dimension, description: '', label: Warehouse Name
          Groups, value_format: !!null '', value_format_name: !!null '', calculation_type: group_by,
        dimension: warehouse_name_groups, args: [new_query_history.warehouse_name,
          [!ruby/hash:ActiveSupport::HashWithIndifferentAccess {label: Other, filter: '-"LI_WH",-"ETL_WH",-"LOOKER_WH",-"OASYS_WH",-"OASYS_SMALL_WH",-"SLA_WH"'}],
          !!null ''], _kind_hint: dimension, _type_hint: string}]
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
    stacking: normal
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
    series_types: {}
    defaults_version: 1
    ordering: none
    show_null_labels: false
    listen: {}
    row: 19
    col: 0
    width: 24
    height: 7
  - title: AVG query Execution time by WH
    name: AVG query Execution time by WH
    model: snowflake_administration
    explore: new_query_history
    type: looker_area
    fields: [new_query_history.capture_date, warehouse_name_groups, new_query_history.avg_total_elapsed_time]
    pivots: [warehouse_name_groups]
    filters:
      new_query_history.capture_date: 31 days ago for 31 days
    sorts: [new_query_history.capture_date desc, warehouse_name_groups]
    limit: 500
    dynamic_fields: [{category: dimension, description: '', label: Warehouse Name
          Groups, value_format: !!null '', value_format_name: !!null '', calculation_type: group_by,
        dimension: warehouse_name_groups, args: [new_query_history.warehouse_name,
          [!ruby/hash:ActiveSupport::HashWithIndifferentAccess {label: Other, filter: '-"LI_WH",-"ETL_WH",-"LOOKER_WH",-"OASYS_WH",-"OASYS_SMALL_WH",-"SLA_WH"'}],
          !!null ''], _kind_hint: dimension, _type_hint: string}]
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
    stacking: normal
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
    series_types: {}
    defaults_version: 1
    ordering: none
    show_null_labels: false
    listen: {}
    row: 12
    col: 0
    width: 24
    height: 7
  - title: Number of queries by WH
    name: Number of queries by WH
    model: snowflake_administration
    explore: new_query_history
    type: looker_area
    fields: [new_query_history.capture_date, warehouse_name_groups, new_query_history.count]
    pivots: [warehouse_name_groups]
    filters:
      new_query_history.capture_date: 31 days ago for 31 days
    sorts: [new_query_history.capture_date desc, warehouse_name_groups]
    limit: 500
    dynamic_fields: [{category: dimension, description: '', label: Warehouse Name
          Groups, value_format: !!null '', value_format_name: !!null '', calculation_type: group_by,
        dimension: warehouse_name_groups, args: [new_query_history.warehouse_name,
          [!ruby/hash:ActiveSupport::HashWithIndifferentAccess {label: Other, filter: '-"LI_WH",-"ETL_WH",-"LOOKER_WH",-"OASYS_WH",-"OASYS_SMALL_WH",-"SLA_WH"'}],
          !!null ''], _kind_hint: dimension, _type_hint: string}]
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
    stacking: normal
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
    series_types: {}
    defaults_version: 1
    ordering: none
    show_null_labels: false
    listen: {}
    row: 26
    col: 0
    width: 24
    height: 6
  - title: Data size by DB
    name: Data size by DB
    model: snowflake_administration
    explore: snodba_account_db_storage_history
    type: looker_area
    fields: [snodba_account_db_storage_history.usage_date, snodba_account_db_storage_history.average_database_bytes_sum,
      snodba_account_db_storage_history.database_name]
    pivots: [snodba_account_db_storage_history.database_name]
    filters:
      snodba_account_db_storage_history.usage_date: 31 days ago for 31 days
    sorts: [snodba_account_db_storage_history.usage_date desc, snodba_account_db_storage_history.database_name]
    limit: 500
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
    stacking: normal
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
    y_axes: [{label: '', orientation: left, series: [{axisId: DBAADMIN - snodba_account_db_storage_history.average_database_bytes_sum,
            id: DBAADMIN - snodba_account_db_storage_history.average_database_bytes_sum,
            name: DBAADMIN}, {axisId: ITV - snodba_account_db_storage_history.average_database_bytes_sum,
            id: ITV - snodba_account_db_storage_history.average_database_bytes_sum,
            name: ITV}, {axisId: OASYS - snodba_account_db_storage_history.average_database_bytes_sum,
            id: OASYS - snodba_account_db_storage_history.average_database_bytes_sum,
            name: OASYS}, {axisId: PLATFORMDATA - snodba_account_db_storage_history.average_database_bytes_sum,
            id: PLATFORMDATA - snodba_account_db_storage_history.average_database_bytes_sum,
            name: PLATFORMDATA}, {axisId: PROD - snodba_account_db_storage_history.average_database_bytes_sum,
            id: PROD - snodba_account_db_storage_history.average_database_bytes_sum,
            name: PROD}, {axisId: SBX - snodba_account_db_storage_history.average_database_bytes_sum,
            id: SBX - snodba_account_db_storage_history.average_database_bytes_sum,
            name: SBX}, {axisId: STG - snodba_account_db_storage_history.average_database_bytes_sum,
            id: STG - snodba_account_db_storage_history.average_database_bytes_sum,
            name: STG}, {axisId: SUPPLY_INGEST_TEST - snodba_account_db_storage_history.average_database_bytes_sum,
            id: SUPPLY_INGEST_TEST - snodba_account_db_storage_history.average_database_bytes_sum,
            name: SUPPLY_INGEST_TEST}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 32
    col: 0
    width: 24
    height: 6
