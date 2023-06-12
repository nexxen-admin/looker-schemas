- dashboard: stg_sql_server_weekly
  title: STG SQL Server Weekly
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - title: Disk Space By DBs
    name: Disk Space By DBs
    model: dbaadmin_mssql_stg_oltp
    explore: dbaadmin_FILES_stats
    type: looker_area
    fields: [dbaadmin_FILES_stats.database_name, dbaadmin_FILES_stats.max_size_on_disk_gb,
      dbaadmin_FILES_stats.check_week]
    pivots: [dbaadmin_FILES_stats.database_name]
    filters:
      dbaadmin_FILES_stats.database_name: "-msdb,-master,-model"
      dbaadmin_FILES_stats.max_size_on_disk_gb: ">30"
    sorts: [dbaadmin_FILES_stats.database_name, dbaadmin_FILES_stats.check_week desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_FILES_stats.check_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_FILES_stats.check_week},now())>=7
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: AN_HIST - dbaadmin_FILES_stats.max_size_on_disk_gb,
            id: AN_HIST - dbaadmin_FILES_stats.max_size_on_disk_gb, name: AN_HIST},
          {axisId: AN_MAIN - dbaadmin_FILES_stats.max_size_on_disk_gb, id: AN_MAIN
              - dbaadmin_FILES_stats.max_size_on_disk_gb, name: AN_MAIN}, {axisId: AN_RAW
              - dbaadmin_FILES_stats.max_size_on_disk_gb, id: AN_RAW - dbaadmin_FILES_stats.max_size_on_disk_gb,
            name: AN_RAW}, {axisId: tempdb - dbaadmin_FILES_stats.max_size_on_disk_gb,
            id: tempdb - dbaadmin_FILES_stats.max_size_on_disk_gb, name: tempdb}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    hide_legend: false
    series_types: {}
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 9
    col: 0
    width: 12
    height: 6
  - title: CPU Trend
    name: CPU Trend
    model: dbaadmin_mssql_stg_oltp
    explore: dbaadmin_SysHealth_stats
    type: looker_area
    fields: [dbaadmin_SysHealth_stats.avg_cpu_sql, dbaadmin_SysHealth_stats.max_cpu_sql,
      dbaadmin_SysHealth_stats.record_week]
    fill_fields: [dbaadmin_SysHealth_stats.record_week]
    sorts: [dbaadmin_SysHealth_stats.record_week desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_SysHealth_stats.record_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_SysHealth_stats.record_week},now())>=7
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: custom
    y_axis_tick_density_custom: 25
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
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 9d1da669-a6b4-4a4f-8519-3ea8723b79b5
      palette_id: 0c5264fb-0681-4817-b9a5-d3c81002ce4c
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: dbaadmin_SysHealth_stats.avg_cpu_sql,
            id: dbaadmin_SysHealth_stats.avg_cpu_sql, name: Avg CPU SQL}, {axisId: dbaadmin_SysHealth_stats.max_cpu_sql,
            id: dbaadmin_SysHealth_stats.max_cpu_sql, name: Max CPU SQL}], showLabels: false,
        showValues: true, maxValue: 100, minValue: 0, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 25, type: linear}]
    font_size: '12'
    series_types: {}
    series_point_styles:
      dbaadmin_SysHealth_stats.avg_cpu_sql: diamond
    trend_lines: [{color: "#777777", label_position: center, order: 3, period: 30,
        regression_type: average, series_index: 2, show_label: true, label_type: string,
        label: Trend}]
    groupBars: true
    labelSize: 10pt
    showLegend: true
    defaults_version: 1
    ordering: none
    show_null_labels: false
    value_labels: legend
    label_type: labPer
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
    map: usa
    map_projection: ''
    up_color: false
    down_color: false
    total_color: false
    hidden_points_if_no: []
    listen: {}
    row: 15
    col: 0
    width: 12
    height: 6
  - title: CDC Trend
    name: CDC Trend
    model: dbaadmin_mssql_stg_oltp
    explore: dbaadmin_CDC_stats
    type: looker_line
    fields: [dbaadmin_CDC_stats.avg_command_count, dbaadmin_CDC_stats.avg_performance,
      dbaadmin_CDC_stats.max_latency, dbaadmin_CDC_stats.end_week]
    fill_fields: [dbaadmin_CDC_stats.end_week]
    sorts: [dbaadmin_CDC_stats.end_week desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_CDC_stats.end_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_CDC_stats.end_week},now())>=7
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: dbaadmin_CDC_stats.avg_command_count,
            id: dbaadmin_CDC_stats.avg_command_count, name: Avg Command Count}, {
            axisId: dbaadmin_CDC_stats.avg_performance, id: dbaadmin_CDC_stats.avg_performance,
            name: Avg Commands per sec}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: dbaadmin_CDC_stats.max_latency, id: dbaadmin_CDC_stats.max_latency,
            name: Max Latency}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types:
      dbaadmin_CDC_stats.avg_command_count: area
      dbaadmin_CDC_stats.avg_performance: area
    series_labels:
      dbaadmin_CDC_stats.avg_performance: Avg Commands per sec
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 2
    col: 12
    width: 12
    height: 5
  - title: Availability Group Trend
    name: Availability Group Trend
    model: dbaadmin_mssql_stg_oltp
    explore: dbaadmin_AG_stats
    type: looker_area
    fields: [dbaadmin_AG_stats.counter_name, dbaadmin_AG_stats.sum_value, dbaadmin_AG_stats.record_week]
    pivots: [dbaadmin_AG_stats.counter_name]
    fill_fields: [dbaadmin_AG_stats.record_week]
    filters:
      dbaadmin_AG_stats.counter_name: "-Recovery Queue,-Redo blocked,-Receives from\
        \ Replica,-Sends to Replica"
    sorts: [dbaadmin_AG_stats.counter_name, dbaadmin_AG_stats.record_week desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_AG_stats.record_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_AG_stats.record_week},now())>=7
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
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: GB, orientation: left, series: [{axisId: dbaadmin_AG_stats.sum_value,
            id: Bytes Received from Replica - dbaadmin_AG_stats.sum_value, name: Bytes
              Received from Replica}, {axisId: dbaadmin_AG_stats.sum_value, id: Bytes
              Sent to Replica - dbaadmin_AG_stats.sum_value, name: Bytes Sent to Replica}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_labels:
      Bytes Received from Replica - dbaadmin_AG_stats.sum_value: GB Received from
        Replica
      Bytes Sent to Replica - dbaadmin_AG_stats.sum_value: GB Sent to Replica
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 2
    col: 0
    width: 12
    height: 5
  - title: Index Rebuild/Reorganize Trend
    name: Index Rebuild/Reorganize Trend
    model: dbaadmin_mssql_stg_oltp
    explore: dbaadmin_IDXStats_log
    type: looker_area
    fields: [dbaadmin_IDXStats_log.database_name, dbaadmin_IDXStats_log.count, dbaadmin_IDXStats_log.end_week]
    pivots: [dbaadmin_IDXStats_log.database_name]
    fill_fields: [dbaadmin_IDXStats_log.end_week]
    filters:
      dbaadmin_IDXStats_log.command_type: '"ALTER_INDEX"'
    sorts: [dbaadmin_IDXStats_log.database_name, dbaadmin_IDXStats_log.end_week desc]
    limit: 500
    dynamic_fields: [{category: dimension, description: '', label: Database Name Groups,
        value_format: !!null '', value_format_name: !!null '', calculation_type: group_by,
        dimension: database_name_groups, args: [dbaadmin_IDXStats_log.database_name,
          [!ruby/hash:ActiveSupport::HashWithIndifferentAccess {label: AN_MN, filter: "%AN^_MAIN%"}],
          Other], _kind_hint: dimension, _type_hint: string}, {category: table_calculation,
        label: New Calculation, value_format: !!null '', value_format_name: Default
          formatting, calculation_type: running_row_total, table_calculation: new_calculation,
        args: [dbaadmin_IDXStats_log.average_duration], _kind_hint: measure, _type_hint: number,
        is_disabled: true}, {category: dimension, expression: "${new_calculation}",
        label: New Dimension, value_format: !!null '', value_format_name: !!null '',
        dimension: new_dimension, _kind_hint: dimension, _type_hint: 'null'}, {category: dimension,
        expression: 'NOT(matches_filter(${dbaadmin_IDXStats_log.end_date}, `today`))',
        label: IsToday, value_format: !!null '', value_format_name: !!null '', dimension: istoday,
        _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_IDXStats_log.end_week},now())>=7
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    color_application: undefined
    y_axes: [{label: Count, orientation: left, series: [{axisId: AN_HIST - dbaadmin_IDXStats_log.count,
            id: AN_HIST - dbaadmin_IDXStats_log.count, name: AN_HIST}, {axisId: AN_MAIN
              - dbaadmin_IDXStats_log.count, id: AN_MAIN - dbaadmin_IDXStats_log.count,
            name: AN_MAIN}, {axisId: AN_MAIN_DASHBOARD - dbaadmin_IDXStats_log.count,
            id: AN_MAIN_DASHBOARD - dbaadmin_IDXStats_log.count, name: AN_MAIN_DASHBOARD},
          {axisId: AN_RAW - dbaadmin_IDXStats_log.count, id: AN_RAW - dbaadmin_IDXStats_log.count,
            name: AN_RAW}, {axisId: DBA - dbaadmin_IDXStats_log.count, id: DBA - dbaadmin_IDXStats_log.count,
            name: DBA}, {axisId: Logging_db - dbaadmin_IDXStats_log.count, id: Logging_db
              - dbaadmin_IDXStats_log.count, name: Logging_db}, {axisId: VG_STATS
              - dbaadmin_IDXStats_log.count, id: VG_STATS - dbaadmin_IDXStats_log.count,
            name: VG_STATS}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    series_types:
      AN_HIST - dbaadmin_IDXStats_log.average_duration: scatter
      Row Total - dbaadmin_IDXStats_log.count: scatter
    rotation: false
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields: [dbaadmin_IDXStats_log.average_duration]
    hidden_points_if_no: []
    listen: {}
    row: 27
    col: 0
    width: 12
    height: 6
  - title: Index Rebuild/Reorganize Duration Trend
    name: Index Rebuild/Reorganize Duration Trend
    model: dbaadmin_mssql_stg_oltp
    explore: dbaadmin_IDXStats_log
    type: looker_area
    fields: [dbaadmin_IDXStats_log.database_name, dbaadmin_IDXStats_log.sum_duration_min,
      dbaadmin_IDXStats_log.end_week]
    pivots: [dbaadmin_IDXStats_log.database_name]
    fill_fields: [dbaadmin_IDXStats_log.end_week]
    sorts: [dbaadmin_IDXStats_log.database_name, dbaadmin_IDXStats_log.end_week desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_IDXStats_log.end_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_IDXStats_log.end_week},now())>=7
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 21
    col: 0
    width: 12
    height: 6
  - title: SQL Jobs Total Duration Trend
    name: SQL Jobs Total Duration Trend
    model: dbaadmin_mssql_stg_oltp
    explore: dbaadmin_JOBS_stats
    type: looker_area
    fields: [dbaadmin_JOBS_stats.total_hours_duration, job_name_short, dbaadmin_JOBS_stats.executed_week]
    pivots: [job_name_short]
    filters:
      dbaadmin_JOBS_stats.total_hours_duration: ">7"
    sorts: [job_name_short, dbaadmin_JOBS_stats.executed_week desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_JOBS_stats.executed_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}, {category: dimension,
        expression: 'substring(${dbaadmin_JOBS_stats.job_name}, 0,44)', label: Job
          Name Short, value_format: !!null '', value_format_name: !!null '', dimension: job_name_short,
        _kind_hint: measure, _type_hint: string}]
    filter_expression: diff_days(${dbaadmin_JOBS_stats.executed_week},now())>=7
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
    series_types: {}
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_points_if_no: []
    hidden_series: []
    listen: {}
    row: 33
    col: 0
    width: 12
    height: 7
  - name: OPT
    type: text
    title_text: OPT
    subtitle_text: ''
    body_text: ''
    row: 7
    col: 12
    width: 12
    height: 2
  - name: OLTP
    type: text
    title_text: OLTP
    subtitle_text: ''
    body_text: ''
    row: 7
    col: 0
    width: 12
    height: 2
  - title: CPU Trend
    name: CPU Trend (2)
    model: dbaadmin_mssql_stg_opt
    explore: dbaadmin_SysHealth_stats
    type: looker_area
    fields: [dbaadmin_SysHealth_stats.avg_cpu_sql, dbaadmin_SysHealth_stats.max_cpu_sql,
      dbaadmin_SysHealth_stats.record_week]
    fill_fields: [dbaadmin_SysHealth_stats.record_week]
    sorts: [dbaadmin_SysHealth_stats.record_week desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_SysHealth_stats.record_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_SysHealth_stats.record_week},now())>=7
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
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 9d1da669-a6b4-4a4f-8519-3ea8723b79b5
      palette_id: 0c5264fb-0681-4817-b9a5-d3c81002ce4c
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: dbaadmin_SysHealth_stats.avg_cpu_sql,
            id: dbaadmin_SysHealth_stats.avg_cpu_sql, name: Avg CPU SQL}, {axisId: dbaadmin_SysHealth_stats.max_cpu_sql,
            id: dbaadmin_SysHealth_stats.max_cpu_sql, name: Max CPU SQL}], showLabels: true,
        showValues: true, maxValue: 100, minValue: 0, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_point_styles:
      dbaadmin_SysHealth_stats.avg_cpu_sql: diamond
    trend_lines: [{color: "#777777", label_position: center, order: 3, period: 3,
        regression_type: average, series_index: 2, show_label: true, label_type: string,
        label: Trend}]
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 15
    col: 12
    width: 12
    height: 6
  - title: Disk Space by DBs
    name: Disk Space by DBs
    model: dbaadmin_mssql_stg_opt
    explore: dbaadmin_FILES_stats
    type: looker_area
    fields: [dbaadmin_FILES_stats.database_name, dbaadmin_FILES_stats.max_size_on_disk_gb,
      dbaadmin_FILES_stats.check_week]
    pivots: [dbaadmin_FILES_stats.database_name]
    filters:
      dbaadmin_FILES_stats.database_name: "-master,-msdb,-model"
      dbaadmin_FILES_stats.max_size_on_disk_gb: ">30"
    sorts: [dbaadmin_FILES_stats.database_name, dbaadmin_FILES_stats.check_week desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_FILES_stats.check_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_FILES_stats.check_week},now())>=7
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: AN_MAIN - dbaadmin_FILES_stats.max_size_on_disk_gb,
            id: AN_MAIN - dbaadmin_FILES_stats.max_size_on_disk_gb, name: AN_MAIN},
          {axisId: AN_OPT - dbaadmin_FILES_stats.max_size_on_disk_gb, id: AN_OPT -
              dbaadmin_FILES_stats.max_size_on_disk_gb, name: AN_OPT}, {axisId: AN_RESEARCH
              - dbaadmin_FILES_stats.max_size_on_disk_gb, id: AN_RESEARCH - dbaadmin_FILES_stats.max_size_on_disk_gb,
            name: AN_RESEARCH}, {axisId: AN_SMART - dbaadmin_FILES_stats.max_size_on_disk_gb,
            id: AN_SMART - dbaadmin_FILES_stats.max_size_on_disk_gb, name: AN_SMART},
          {axisId: AN_STAGE - dbaadmin_FILES_stats.max_size_on_disk_gb, id: AN_STAGE
              - dbaadmin_FILES_stats.max_size_on_disk_gb, name: AN_STAGE}, {axisId: DBA
              - dbaadmin_FILES_stats.max_size_on_disk_gb, id: DBA - dbaadmin_FILES_stats.max_size_on_disk_gb,
            name: DBA}, {axisId: Logging_db - dbaadmin_FILES_stats.max_size_on_disk_gb,
            id: Logging_db - dbaadmin_FILES_stats.max_size_on_disk_gb, name: Logging_db},
          {axisId: OPT_ARCHIVE - dbaadmin_FILES_stats.max_size_on_disk_gb, id: OPT_ARCHIVE
              - dbaadmin_FILES_stats.max_size_on_disk_gb, name: OPT_ARCHIVE}, {axisId: OPT_RPT
              - dbaadmin_FILES_stats.max_size_on_disk_gb, id: OPT_RPT - dbaadmin_FILES_stats.max_size_on_disk_gb,
            name: OPT_RPT}, {axisId: tempdb - dbaadmin_FILES_stats.max_size_on_disk_gb,
            id: tempdb - dbaadmin_FILES_stats.max_size_on_disk_gb, name: tempdb}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types: {}
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 9
    col: 12
    width: 12
    height: 6
  - title: Index Rebuild/Reorganize Duration Trend
    name: Index Rebuild/Reorganize Duration Trend (2)
    model: dbaadmin_mssql_stg_opt
    explore: dbaadmin_IDXStats_log
    type: looker_area
    fields: [dbaadmin_IDXStats_log.database_name, dbaadmin_IDXStats_log.sum_duration_min,
      dbaadmin_IDXStats_log.end_week]
    pivots: [dbaadmin_IDXStats_log.database_name]
    fill_fields: [dbaadmin_IDXStats_log.end_week]
    sorts: [dbaadmin_IDXStats_log.database_name, dbaadmin_IDXStats_log.end_week desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_IDXStats_log.end_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_IDXStats_log.end_week},now())>=7
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 21
    col: 12
    width: 12
    height: 6
  - title: Index Rebuild/Reorganize Trend
    name: Index Rebuild/Reorganize Trend (2)
    model: dbaadmin_mssql_stg_opt
    explore: dbaadmin_IDXStats_log
    type: looker_area
    fields: [dbaadmin_IDXStats_log.database_name, dbaadmin_IDXStats_log.count, dbaadmin_IDXStats_log.end_week]
    pivots: [dbaadmin_IDXStats_log.database_name]
    filters:
      dbaadmin_IDXStats_log.command_type: '"ALTER_INDEX"'
      dbaadmin_IDXStats_log.count: ">5"
    sorts: [dbaadmin_IDXStats_log.database_name, dbaadmin_IDXStats_log.end_week desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_IDXStats_log.end_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_IDXStats_log.end_week},now())>=7
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: Count, orientation: left, series: [{axisId: AN_OPT - dbaadmin_IDXStats_log.count,
            id: AN_OPT - dbaadmin_IDXStats_log.count, name: AN_OPT}, {axisId: AN_RESEARCH
              - dbaadmin_IDXStats_log.count, id: AN_RESEARCH - dbaadmin_IDXStats_log.count,
            name: AN_RESEARCH}, {axisId: AN_SMART - dbaadmin_IDXStats_log.count, id: AN_SMART
              - dbaadmin_IDXStats_log.count, name: AN_SMART}, {axisId: OPT_RPT - dbaadmin_IDXStats_log.count,
            id: OPT_RPT - dbaadmin_IDXStats_log.count, name: OPT_RPT}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    series_types: {}
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 27
    col: 12
    width: 12
    height: 6
  - title: SQL Jobs Total Duration Trend
    name: SQL Jobs Total Duration Trend (2)
    model: dbaadmin_mssql_stg_opt
    explore: dbaadmin_JOBS_stats
    type: looker_area
    fields: [dbaadmin_JOBS_stats.job_name, dbaadmin_JOBS_stats.total_hours_duration,
      dbaadmin_JOBS_stats.executed_week]
    pivots: [dbaadmin_JOBS_stats.job_name]
    filters:
      dbaadmin_JOBS_stats.total_hours_duration: ">14"
    sorts: [dbaadmin_JOBS_stats.job_name, dbaadmin_JOBS_stats.executed_week desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_JOBS_stats.executed_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_JOBS_stats.executed_week},now())>=7
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
    hidden_series: []
    series_types: {}
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 33
    col: 12
    width: 12
    height: 7
  - name: Replication / CDC
    type: text
    title_text: Replication / CDC
    subtitle_text: ''
    body_text: ''
    row: 0
    col: 0
    width: 24
    height: 2
  - title: SQL Compilations/Re-compilations
    name: SQL Compilations/Re-compilations
    model: dbaadmin_mssql_stg_oltp
    explore: dbaadmin_perfmon_stats
    type: looker_area
    fields: [dbaadmin_perfmon_stats.sum_value, dbaadmin_perfmon_stats.counter_name,
      dbaadmin_perfmon_stats.record_week]
    pivots: [dbaadmin_perfmon_stats.counter_name]
    fill_fields: [dbaadmin_perfmon_stats.record_week]
    filters:
      dbaadmin_perfmon_stats.counter_name: SQL Compilations,SQL Re-Compilations
    sorts: [dbaadmin_perfmon_stats.counter_name, dbaadmin_perfmon_stats.record_week
        desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_perfmon_stats.record_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_perfmon_stats.record_week},now())>=7
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
    y_axes: [{label: Count, orientation: left, series: [{axisId: dbaadmin_perfmon_stats.sum_value,
            id: SQL Compilations - dbaadmin_perfmon_stats.sum_value, name: SQL Compilations},
          {axisId: dbaadmin_perfmon_stats.sum_value, id: SQL Re-Compilations - dbaadmin_perfmon_stats.sum_value,
            name: SQL Re-Compilations}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types: {}
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 40
    col: 0
    width: 12
    height: 5
  - title: SQL Compilations/Re-compilations
    name: SQL Compilations/Re-compilations (2)
    model: dbaadmin_mssql_stg_opt
    explore: dbaadmin_perfmon_stats
    type: looker_area
    fields: [dbaadmin_perfmon_stats.counter_name, dbaadmin_perfmon_stats.sum_value,
      dbaadmin_perfmon_stats.record_week]
    pivots: [dbaadmin_perfmon_stats.counter_name]
    fill_fields: [dbaadmin_perfmon_stats.record_week]
    filters:
      dbaadmin_perfmon_stats.counter_name: SQL Compilations,SQL Re-Compilations
    sorts: [dbaadmin_perfmon_stats.counter_name, dbaadmin_perfmon_stats.record_week
        desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_perfmon_stats.record_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_perfmon_stats.record_week},now())>=7
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
    y_axes: [{label: Count, orientation: left, series: [{axisId: dbaadmin_perfmon_stats.sum_value,
            id: SQL Compilations - dbaadmin_perfmon_stats.sum_value, name: SQL Compilations},
          {axisId: dbaadmin_perfmon_stats.sum_value, id: SQL Re-Compilations - dbaadmin_perfmon_stats.sum_value,
            name: SQL Re-Compilations}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types: {}
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 40
    col: 12
    width: 12
    height: 5
  - title: Deadlocks
    name: Deadlocks
    model: dbaadmin_mssql_stg_oltp
    explore: dbaadmin_perfmon_stats
    type: looker_area
    fields: [dbaadmin_perfmon_stats.instance_name, dbaadmin_perfmon_stats.sum_value,
      dbaadmin_perfmon_stats.record_week]
    pivots: [dbaadmin_perfmon_stats.instance_name]
    filters:
      dbaadmin_perfmon_stats.counter_name: Number of Deadlocks
      dbaadmin_perfmon_stats.instance_name: -"_Total"
      dbaadmin_perfmon_stats.sum_value: ">0"
    sorts: [dbaadmin_perfmon_stats.instance_name, dbaadmin_perfmon_stats.record_week
        desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_perfmon_stats.record_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_perfmon_stats.record_week},now())>=7
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
    stacking: normal
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
    y_axes: [{label: Count, orientation: left, series: [{axisId: dbaadmin_perfmon_stats.sum_value,
            id: AllocUnit - dbaadmin_perfmon_stats.sum_value, name: AllocUnit}, {
            axisId: dbaadmin_perfmon_stats.sum_value, id: Application - dbaadmin_perfmon_stats.sum_value,
            name: Application}, {axisId: dbaadmin_perfmon_stats.sum_value, id: Database
              - dbaadmin_perfmon_stats.sum_value, name: Database}, {axisId: dbaadmin_perfmon_stats.sum_value,
            id: Extent - dbaadmin_perfmon_stats.sum_value, name: Extent}, {axisId: dbaadmin_perfmon_stats.sum_value,
            id: File - dbaadmin_perfmon_stats.sum_value, name: File}, {axisId: dbaadmin_perfmon_stats.sum_value,
            id: HoBT - dbaadmin_perfmon_stats.sum_value, name: HoBT}, {axisId: dbaadmin_perfmon_stats.sum_value,
            id: Key - dbaadmin_perfmon_stats.sum_value, name: Key}, {axisId: dbaadmin_perfmon_stats.sum_value,
            id: Metadata - dbaadmin_perfmon_stats.sum_value, name: Metadata}, {axisId: dbaadmin_perfmon_stats.sum_value,
            id: Object - dbaadmin_perfmon_stats.sum_value, name: Object}, {axisId: dbaadmin_perfmon_stats.sum_value,
            id: OIB - dbaadmin_perfmon_stats.sum_value, name: OIB}, {axisId: dbaadmin_perfmon_stats.sum_value,
            id: Page - dbaadmin_perfmon_stats.sum_value, name: Page}, {axisId: dbaadmin_perfmon_stats.sum_value,
            id: RID - dbaadmin_perfmon_stats.sum_value, name: RID}, {axisId: dbaadmin_perfmon_stats.sum_value,
            id: RowGroup - dbaadmin_perfmon_stats.sum_value, name: RowGroup}, {axisId: dbaadmin_perfmon_stats.sum_value,
            id: Xact - dbaadmin_perfmon_stats.sum_value, name: Xact}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    series_types: {}
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 45
    col: 0
    width: 12
    height: 5
  - title: Deadlocks
    name: Deadlocks (2)
    model: dbaadmin_mssql_stg_opt
    explore: dbaadmin_perfmon_stats
    type: looker_area
    fields: [dbaadmin_perfmon_stats.instance_name, dbaadmin_perfmon_stats.sum_value,
      dbaadmin_perfmon_stats.record_week]
    pivots: [dbaadmin_perfmon_stats.instance_name]
    filters:
      dbaadmin_perfmon_stats.counter_name: Number of Deadlocks
      dbaadmin_perfmon_stats.instance_name: -"_Total"
      dbaadmin_perfmon_stats.sum_value: ">0"
    sorts: [dbaadmin_perfmon_stats.instance_name, dbaadmin_perfmon_stats.record_week
        desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_perfmon_stats.record_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_perfmon_stats.record_week},now())>=7
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
    stacking: normal
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
    y_axes: [{label: Count, orientation: left, series: [{axisId: dbaadmin_perfmon_stats.sum_value,
            id: Object - dbaadmin_perfmon_stats.sum_value, name: Object}], showLabels: true,
        showValues: true, valueFormat: '', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    hide_legend: false
    series_types: {}
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 45
    col: 12
    width: 12
    height: 5
  - title: Batch Requests
    name: Batch Requests
    model: dbaadmin_mssql_stg_opt
    explore: dbaadmin_perfmon_stats
    type: looker_area
    fields: [dbaadmin_perfmon_stats.sum_value, dbaadmin_perfmon_stats.record_week]
    fill_fields: [dbaadmin_perfmon_stats.record_week]
    filters:
      dbaadmin_perfmon_stats.counter_name: Batch Requests
    sorts: [dbaadmin_perfmon_stats.record_week desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_perfmon_stats.record_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_perfmon_stats.record_week},now())>=7
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
    y_axes: [{label: Count, orientation: left, series: [{axisId: dbaadmin_perfmon_stats.sum_value,
            id: dbaadmin_perfmon_stats.sum_value, name: Sum Value}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    series_types: {}
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 50
    col: 12
    width: 12
    height: 6
  - title: Batch Requests
    name: Batch Requests (2)
    model: dbaadmin_mssql_stg_oltp
    explore: dbaadmin_perfmon_stats
    type: looker_area
    fields: [dbaadmin_perfmon_stats.sum_value, dbaadmin_perfmon_stats.record_week]
    fill_fields: [dbaadmin_perfmon_stats.record_week]
    filters:
      dbaadmin_perfmon_stats.counter_name: Batch Requests
    sorts: [dbaadmin_perfmon_stats.record_week desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_perfmon_stats.record_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_perfmon_stats.record_week},now())>=7
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
    y_axes: [{label: Count, orientation: left, series: [{axisId: dbaadmin_perfmon_stats.sum_value,
            id: dbaadmin_perfmon_stats.sum_value, name: Sum Value}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    series_types: {}
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 50
    col: 0
    width: 12
    height: 6
  - title: Query Store Size
    name: Query Store Size
    model: dbaadmin_mssql_stg_oltp
    explore: dbaadmin_qssize_stats
    type: looker_area
    fields: [dbaadmin_qssize_stats.db_name, dbaadmin_qssize_stats.avg_prcnt_full,
      dbaadmin_qssize_stats.record_week]
    pivots: [dbaadmin_qssize_stats.db_name]
    filters:
      dbaadmin_qssize_stats.avg_prcnt_full: ">3"
    sorts: [dbaadmin_qssize_stats.db_name, dbaadmin_qssize_stats.record_week desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_qssize_stats.record_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_qssize_stats.record_week},now())>=7
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
    y_axes: [{label: Percent Full, orientation: left, series: [{axisId: dbaadmin_qssize_stats.avg_prcnt_full,
            id: AN_MAIN - dbaadmin_qssize_stats.avg_prcnt_full, name: AN_MAIN}, {
            axisId: dbaadmin_qssize_stats.avg_prcnt_full, id: AN_MAIN_DASHBOARD -
              dbaadmin_qssize_stats.avg_prcnt_full, name: AN_MAIN_DASHBOARD}], showLabels: true,
        showValues: true, maxValue: 100, minValue: 0, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types: {}
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 56
    col: 0
    width: 12
    height: 5
  - title: Query Store Size
    name: Query Store Size (2)
    model: dbaadmin_mssql_stg_opt
    explore: dbaadmin_qssize_stats
    type: looker_area
    fields: [dbaadmin_qssize_stats.db_name, dbaadmin_qssize_stats.avg_prcnt_full,
      dbaadmin_qssize_stats.record_week]
    pivots: [dbaadmin_qssize_stats.db_name]
    filters:
      dbaadmin_qssize_stats.avg_prcnt_full: ">3"
    sorts: [dbaadmin_qssize_stats.db_name, dbaadmin_qssize_stats.record_week desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: 'NOT(matches_filter(${dbaadmin_qssize_stats.record_date},
          `today`))', label: IsToday, value_format: !!null '', value_format_name: !!null '',
        dimension: istoday, _kind_hint: dimension, _type_hint: yesno}]
    filter_expression: diff_days(${dbaadmin_qssize_stats.record_week},now())>=7
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
    y_axes: [{label: Percent Full, orientation: left, series: [{axisId: dbaadmin_qssize_stats.avg_prcnt_full,
            id: AN_MAIN - dbaadmin_qssize_stats.avg_prcnt_full, name: AN_MAIN}, {
            axisId: dbaadmin_qssize_stats.avg_prcnt_full, id: AN_OPT - dbaadmin_qssize_stats.avg_prcnt_full,
            name: AN_OPT}, {axisId: dbaadmin_qssize_stats.avg_prcnt_full, id: AN_SMART
              - dbaadmin_qssize_stats.avg_prcnt_full, name: AN_SMART}], showLabels: true,
        showValues: true, maxValue: 100, minValue: 0, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types: {}
    defaults_version: 1
    hidden_points_if_no: []
    listen: {}
    row: 56
    col: 12
    width: 12
    height: 5
  - title: Error Log for last Week
    name: Error Log for last Week
    model: dbaadmin_mssql_stg_oltp
    explore: dbaadmin_errorlog_stats
    type: looker_grid
    fields: [dbaadmin_errorlog_stats.LogText, dbaadmin_errorlog_stats.count, dbaadmin_errorlog_stats.last_time]
    sorts: [dbaadmin_errorlog_stats.last_time desc]
    limit: 500
    filter_expression: diff_days(${dbaadmin_errorlog_stats.Log_raw},now())<8
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
    series_labels:
      dbaadmin_errorlog_stats.count: Count
    series_column_widths:
      dbaadmin_errorlog_stats.count: 1
      dbaadmin_errorlog_stats.last_time: 115
    series_cell_visualizations:
      dbaadmin_errorlog_stats.count:
        is_active: true
    hidden_fields: []
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
    series_types: {}
    listen: {}
    row: 61
    col: 0
    width: 12
    height: 22
  - title: Error Log for last Week
    name: Error Log for last Week (2)
    model: dbaadmin_mssql_stg_opt
    explore: dbaadmin_errorlog_stats
    type: looker_grid
    fields: [dbaadmin_errorlog_stats.LogText, dbaadmin_errorlog_stats.count, dbaadmin_errorlog_stats.last_time]
    sorts: [dbaadmin_errorlog_stats.last_time desc]
    limit: 500
    filter_expression: diff_days(${dbaadmin_errorlog_stats.Log_raw},now())<8
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
    series_labels:
      dbaadmin_errorlog_stats.count: Count
    series_column_widths:
      dbaadmin_errorlog_stats.count: 1
      dbaadmin_errorlog_stats.last_time: 115
    series_cell_visualizations:
      dbaadmin_errorlog_stats.count:
        is_active: true
    hidden_fields: []
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
    series_types: {}
    listen: {}
    row: 61
    col: 12
    width: 12
    height: 22
