---
- dashboard: daily_revenue_report_legacy
  title: Daily Revenue Report Legacy (test)
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: hhx5dmVuK5T6FD46nzgJ8W
  elements:
  - title: Reporting date
    name: Reporting date
    model: DRR
    explore: DRR_Legacy
    type: single_value
    fields: [drr_legacy.Event_Date_Formatted]
    filters:
      drr_legacy.Data_Type: Daily metrics
    sorts: [drr_legacy.Event_Date_Formatted desc]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 6c27c30e-5523-4080-82ae-272146e699d0
      palette_id: 87654122-8144-4720-8259-82ac9908d5f4
    custom_color: "#000000"
    smart_single_value_size: false
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#FFEB8E",
        font_color: !!null '', color_application: {collection_id: 6c27c30e-5523-4080-82ae-272146e699d0,
          palette_id: 25b877bc-c7a8-4ed0-a0ef-5ba64ca3658d}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    theme: looker
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: true
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: false
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|drr_legacy.Region: Region
    heading|drr_legacy.Region: ''
    hide|drr_legacy.Region: false
    label|drr_legacy.Category: Category
    heading|drr_legacy.Category: ''
    hide|drr_legacy.Category: false
    label|drr_legacy.Subcategory: Subcategory
    heading|drr_legacy.Subcategory: ''
    hide|drr_legacy.Subcategory: false
    subtotalDepth: '1'
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    defaults_version: 1
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    label|drr_legacy.Revenue: Revenue
    heading|drr_legacy.Revenue: ''
    hide|drr_legacy.Revenue: false
    label|drr_legacy.Cost: Cost
    heading|drr_legacy.Cost: ''
    hide|drr_legacy.Cost: false
    hidden_pivots: {}
    transpose: false
    truncate_text: true
    size_to_fit: true
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    title_hidden: true
    listen:
      'Report run date:': drr_legacy.Report_Run_Date
    row: 2
    col: 0
    width: 6
    height: 2
  - title: Gross Revenue
    name: Gross Revenue
    model: DRR
    explore: DRR_Legacy
    type: single_value
    fields: [drr_legacy.Gross_Revenue_Daily]
    filters:
      drr_legacy.Data_Type: Daily metrics
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: legacy
      palette_id: looker_classic
    custom_color: "#000000"
    conditional_formatting: [{type: greater than, value: 0, background_color: "#d0d0d0",
        font_color: "#000000", color_application: {collection_id: legacy, palette_id: legacy_sequential3},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    theme: looker
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: true
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: false
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|drr_legacy.Region: Region
    heading|drr_legacy.Region: ''
    hide|drr_legacy.Region: false
    label|drr_legacy.Category: Category
    heading|drr_legacy.Category: ''
    hide|drr_legacy.Category: false
    label|drr_legacy.Subcategory: Subcategory
    heading|drr_legacy.Subcategory: ''
    hide|drr_legacy.Subcategory: false
    subtotalDepth: '1'
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    defaults_version: 1
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    label|drr_legacy.Revenue: Revenue
    heading|drr_legacy.Revenue: ''
    hide|drr_legacy.Revenue: false
    label|drr_legacy.Cost: Cost
    heading|drr_legacy.Cost: ''
    hide|drr_legacy.Cost: false
    hidden_pivots: {}
    transpose: false
    truncate_text: true
    size_to_fit: true
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    title_hidden: true
    listen:
      'Report run date:': drr_legacy.Report_Run_Date
    row: 2
    col: 6
    width: 9
    height: 2
  - title: Net Revenue
    name: Net Revenue
    model: DRR
    explore: DRR_Legacy
    type: single_value
    fields: [drr_legacy.Net_Revenue_Daily]
    filters:
      drr_legacy.Data_Type: Daily metrics
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: legacy
      palette_id: looker_classic
    custom_color: "#000000"
    conditional_formatting: [{type: greater than, value: 0, background_color: "#d0d0d0",
        font_color: "#000000", color_application: {collection_id: legacy, palette_id: legacy_sequential3},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    theme: looker
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: true
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: false
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|drr_legacy.Region: Region
    heading|drr_legacy.Region: ''
    hide|drr_legacy.Region: false
    label|drr_legacy.Category: Category
    heading|drr_legacy.Category: ''
    hide|drr_legacy.Category: false
    label|drr_legacy.Subcategory: Subcategory
    heading|drr_legacy.Subcategory: ''
    hide|drr_legacy.Subcategory: false
    subtotalDepth: '1'
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    defaults_version: 1
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    label|drr_legacy.Revenue: Revenue
    heading|drr_legacy.Revenue: ''
    hide|drr_legacy.Revenue: false
    label|drr_legacy.Cost: Cost
    heading|drr_legacy.Cost: ''
    hide|drr_legacy.Cost: false
    hidden_pivots: {}
    transpose: false
    truncate_text: true
    size_to_fit: true
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    title_hidden: true
    listen:
      'Report run date:': drr_legacy.Report_Run_Date
    row: 2
    col: 15
    width: 9
    height: 2
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "<div style=\" \n  height: 100%; \n  width: 100%;\n  text-align: center;\n\
      \"> <p style=\"font-size: 38px; margin: 0 0px 2px 10px; \">Consolidated Revenue</p>\n\
      </div>"
    row: 0
    col: 6
    width: 18
    height: 2
  - name: " (2)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "<div style=\" \n  display: flex;\n  justify-content: center;   \n\
      \  align-items: center; \n\">\n<p align=\"center\">\n  <img src=\"https://nexxen.com/wp-content/uploads/2023/07/logo.png\"\
      \ alt=\"Nexxen Logo\" width=\"220\">\n</p>\n</div>"
    row: 0
    col: 0
    width: 6
    height: 2
  - title: Device MTD
    name: Device MTD
    model: DRR
    explore: DRR_Legacy
    type: looker_column
    fields: [device_type, drr_legacy.Net_Revenue_MTD, drr_legacy.Gross_Revenue_MTD]
    filters:
      drr_legacy.Data_Type: Monthly metrics
    sorts: [device_type]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: dimension
      description: Fromatted
      expression: case(when(${drr_legacy.Device_Type} = "mobile", "MOBILE"), when(${drr_legacy.Device_Type}
        = "ctv", "CTV"), when(${drr_legacy.Device_Type} = "desktop", "DESKTOP"), when(${drr_legacy.Device_Type}
        = "", "UNDEFINED (Perf/Other)"), ${drr_legacy.Device_Type})
      label: 'Device Type '
      value_format:
      value_format_name:
      dimension: device_type
      _kind_hint: dimension
      _type_hint: string
    - category: table_calculation
      expression: "${drr_legacy.Net_Revenue_MTD}/${drr_legacy.Gross_Revenue_MTD}"
      label: Net Revenue %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: net_revenue
      _type_hint: number
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
      collection_id: legacy
      palette_id: looker_classic
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: drr_legacy.Net_Revenue, id: drr_legacy.Net_Revenue,
            name: Net Revenue}, {axisId: drr_legacy.Gross_Revenue, id: drr_legacy.Gross_Revenue,
            name: Gross Revenue}, {axisId: net_revenue, id: net_revenue, name: Net
              Revenue %}], showLabels: false, showValues: true, unpinAxis: true, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: []
    hide_legend: false
    series_colors:
      drr_legacy.Sum_Revenue: "#80b1d3"
      drr_legacy.Sum_Net_Revenue: "#d0d0d0"
      drr_legacy.Net_Revenue: "#d0d0d0"
      drr_legacy.Gross_Revenue: "#80b1d3"
      drr_legacy.Net_Revenue_MTD: "#d0d0d0"
      drr_legacy.Gross_Revenue_MTD: "#80b1d3"
    label_color: [black]
    show_dropoff: false
    advanced_vis_config: |-
      {
        chart: {
          "type": "column"
        },
        "plotOptions": {
          "column": {
            "stacking": "normal",
            "grouping": false,
            "pointPadding": 0.1
          }
        },
        series: [{
            name: 'Total Net Revenue',
            pointPadding: 0.2,
            pointPlacement: 0,
            "dataLabels": {
              "inside": true,
              "verticalAlign": "bottom",
              "y": -17,
              "style": {
                "color": "black"
              }
            }
          }, {
            name: 'Total Gross Revenue',
            pointPadding: 0.1,
            pointPlacement: 0
          },
          {
            name: '',
            color: "rgba(255, 193, 7, 0)"
          }
        ],
        "yAxis": {
          "title": {
            "text": ""
          },
          "labels": {
            "style": {
              "color": "black"
            }
          },
        },
        "xAxis": {
          "labels": {
            "rotation": 0,
            "align": "center",
            "style": {
              "whiteSpace": "normal",
              "textOverflow": "none",
              "fontSize": "12px"
            }
          }
        }
      }
    hidden_pivots: {}
    defaults_version: 1
    listen:
      'Report run date:': drr_legacy.Report_Run_Date
    row: 25
    col: 0
    width: 8
    height: 19
  - name: " (3)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "<div style=\"\n  display: flex;\n  align-items: center; \n  justify-content:\
      \ left;\n  height: 100%;\n  width: 100%;\n  background-color: #e0e0e0;  \n \
      \ border-radius: 6px;\n  padding: 8px;\n  box-sizing: border-box;\n\">\n  <p\
      \ style=\"font-size: 32px; margin: 0;\">Month-To-Date</p>\n</div>"
    row: 23
    col: 0
    width: 24
    height: 2
  - title: Daily data
    name: Daily data
    model: DRR
    explore: DRR_Legacy
    type: looker_grid
    fields: [drr_legacy.Gross_Revenue_Previous_Day, drr_legacy.Net_Revenue_Previous_Day, drr_legacy.Gross_Revenue_Daily,
      drr_legacy.Net_Revenue_Daily, region_order, drr_legacy.Region, drr_legacy.Category, drr_legacy.Subcategory]
    filters:
      drr_legacy.Data_Type: Daily metrics
    sorts: [region_order, drr_legacy.Region, drr_legacy.Category]
    subtotals: [region_order, drr_legacy.Region, drr_legacy.Category]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - category: table_calculation
      expression: "(${drr_legacy.Gross_Revenue_Daily}-${drr_legacy.Gross_Revenue_Previous_Day})/${drr_legacy.Gross_Revenue_Previous_Day}"
      label: Gross Change
      value_format: 0.0%;(0.0%)
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: gross_change
      _type_hint: number
    - category: table_calculation
      expression: "(${drr_legacy.Net_Revenue_Daily}-${drr_legacy.Net_Revenue_Previous_Day})/${drr_legacy.Net_Revenue_Previous_Day}"
      label: Net Change
      value_format: 0.0%;(0.0%)
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: net_change
      _type_hint: number
    - category: dimension
      expression: case(when(${drr_legacy.Region} = "Americas", 1),when(${drr_legacy.Region} = "APAC",
        2),when(${drr_legacy.Region} = "EMEA", 3),when(${drr_legacy.Region} = "Non-Regional", 4),
        5)
      label: Region_Order
      value_format:
      value_format_name:
      dimension: region_order
      _kind_hint: dimension
      _type_hint: number
    - category: table_calculation
      expression: "${drr_legacy.Net_Revenue_Daily}/${drr_legacy.Gross_Revenue_Daily}"
      label: GP %
      value_format: 0.0%;(0.0%)
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: gp
      _type_hint: number
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [drr_legacy.Region, drr_legacy.Category, drr_legacy.Subcategory, drr_legacy.Gross_Revenue_Daily,
      gp, drr_legacy.Net_Revenue_Daily, gross_change, net_change]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      drr_legacy.Net_Revenue: Net Rev
      drr_legacy.Gross_Revenue: Gross Rev
    series_cell_visualizations:
      drr_legacy.Sum_Revenue:
        is_active: true
    series_text_format:
      gross_change:
        align: right
      net_change:
        align: right
      drr_legacy.Region_Daily: {}
      gp:
        align: right
    series_collapsed:
      drr_legacy.Region_Daily: false
    series_value_format:
      drr_legacy.Gross_Revenue_Previous_Day:
        format_string: "$#,##0;($#,##0)"
      drr_legacy.Net_Revenue_Previous_Day:
        format_string: "$#,##0;($#,##0)"
      gross_change: 0.0%;(0.0%)
      net_change: 0.0%;(0.0%)
      drr_legacy.Gross_Revenue_Daily:
        format_string: "$#,##0;($#,##0)"
      drr_legacy.Net_Revenue_Daily:
        format_string: "$#,##0;($#,##0)"
      gp: 0.0%;(0.0%)
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
    hidden_fields: [drr_legacy.Gross_Revenue_Previous_Day, drr_legacy.Net_Revenue_Previous_Day,
      region_order]
    hidden_pivots: {}
    title_hidden: true
    listen:
      'Report run date:': drr_legacy.Report_Run_Date
    row: 4
    col: 0
    width: 16
    height: 19
  - name: " (4)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "<div style=\"\n  display: flex;\n  align-items: center; \n  justify-content:\
      \ left;\n  height: 100%;\n  width: 100%;\n  background-color: #e0e0e0;  \n \
      \ border-radius: 6px;\n  padding: 8px;\n  box-sizing: border-box;\n\">\n  <p\
      \ style=\"font-size: 32px; margin: 0;\">Year-To-Date</p>\n</div>"
    row: 65
    col: 0
    width: 24
    height: 2
  - name: " (5)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "<div style=\"\n  display: flex;\n  align-items: center; \n  justify-content:\
      \ left;\n  height: 100%;\n  width: 100%;\n  background-color: #e0e0e0;  \n \
      \ border-radius: 6px;\n  padding: 8px;\n  box-sizing: border-box;\n\">\n  <p\
      \ style=\"font-size: 32px; margin: 0;\">Quarter-To-Date</p>\n</div>"
    row: 44
    col: 0
    width: 24
    height: 2
  - name: " (6)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "<div style=\"\n  display: flex;\n  align-items: center; \n  justify-content:\
      \ left;\n  height: 100%;\n  width: 100%;\n  background-color: #e0e0e0;  \n \
      \ border-radius: 6px;\n  padding: 8px;\n  box-sizing: border-box;\n\">\n  <p\
      \ style=\"font-size: 32px; margin: 0;\">CTV-specific</p>\n</div>"
    row: 87
    col: 0
    width: 24
    height: 2
  - title: CTV-specific
    name: CTV-specific
    model: DRR
    explore: DRR_Legacy
    type: looker_grid
    fields: [drr_legacy.Cost_MTD, drr_legacy.Cost_QTD, drr_legacy.Cost_YTD, drr_legacy.Gross_Revenue_MTD, drr_legacy.Net_Revenue_MTD,
      drr_legacy.Gross_Revenue_QTD, drr_legacy.Net_Revenue_QTD, drr_legacy.Gross_Revenue_YTD, drr_legacy.Net_Revenue_YTD,
      drr_legacy.Gross_Revenue_Daily, drr_legacy.Net_Revenue_Daily, region_order, drr_legacy.Region, drr_legacy.Category,
      drr_legacy.Subcategory]
    filters:
      drr_legacy.Device_Type: ctv
      drr_legacy.Data_Type: POP metrics
    sorts: [region_order, drr_legacy.Region, drr_legacy.Category]
    subtotals: [region_order, drr_legacy.Region, drr_legacy.Category]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - category: table_calculation
      expression: "(${drr_legacy.Gross_Revenue_MTD}-${drr_legacy.Cost_MTD})/${drr_legacy.Gross_Revenue_MTD}"
      label: GP % MTD
      value_format: 0.0%;(0.0%)
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: gp_mtd
      _type_hint: number
    - category: table_calculation
      expression: "(${drr_legacy.Gross_Revenue_QTD}-${drr_legacy.Cost_QTD})/${drr_legacy.Gross_Revenue_QTD}"
      label: GP % QTD
      value_format: 0.0%;(0.0%)
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: gp_qtd
      _type_hint: number
    - category: table_calculation
      expression: "(${drr_legacy.Gross_Revenue_YTD}-${drr_legacy.Cost_YTD})/${drr_legacy.Gross_Revenue_YTD}"
      label: GP % YTD
      value_format: 0.0%;(0.0%)
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: gp_ytd
      _type_hint: number
    - category: dimension
      expression: case(when(${drr_legacy.Region} = "Americas", 1),when(${drr_legacy.Region} = "APAC",
        2),when(${drr_legacy.Region} = "EMEA", 3),when(${drr_legacy.Region} = "Non-Regional", 4),
        5)
      label: Region_Order
      value_format:
      value_format_name:
      dimension: region_order
      _kind_hint: dimension
      _type_hint: number
    - category: table_calculation
      expression: "${drr_legacy.Net_Revenue_Daily}/${drr_legacy.Gross_Revenue_Daily}"
      label: GP %
      value_format: 0.0%
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: gp
      _type_hint: number
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [drr_legacy.Region, drr_legacy.Category, drr_legacy.Subcategory, drr_legacy.Gross_Revenue_Daily,
      drr_legacy.Net_Revenue_Daily, gp, drr_legacy.Gross_Revenue_MTD, drr_legacy.Net_Revenue_MTD, gp_mtd,
      drr_legacy.Gross_Revenue_QTD, drr_legacy.Net_Revenue_QTD, gp_qtd, drr_legacy.Gross_Revenue_YTD, drr_legacy.Net_Revenue_YTD,
      gp_ytd]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      drr_legacy.Sum_Revenue:
        is_active: true
    series_text_format:
      gp_mtd:
        align: right
      gp_qtd:
        align: right
      gp_ytd:
        align: right
      gp:
        align: right
    series_value_format:
      drr_legacy.Gross_Revenue_MTD:
        format_string: "$#,##0;($#,##0)"
      drr_legacy.Net_Revenue_MTD:
        format_string: "$#,##0;($#,##0)"
      drr_legacy.Gross_Revenue_QTD:
        format_string: "$#,##0;($#,##0)"
      drr_legacy.Net_Revenue_QTD:
        format_string: "$#,##0;($#,##0)"
      drr_legacy.Gross_Revenue_YTD:
        format_string: "$#,##0;($#,##0)"
      drr_legacy.Net_Revenue_YTD:
        format_string: "$#,##0;($#,##0)"
      gp_mtd: 0.0%;(0.0%)
      gp_qtd: 0.0%;(0.0%)
      gp_ytd: 0.0%;(0.0%)
      drr_legacy.Gross_Revenue_Daily:
        format_string: "$#,##0;($#,##0)"
      drr_legacy.Net_Revenue_Daily:
        format_string: "$#,##0;($#,##0)"
      gp:
        format_string: 0.0%
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
    hidden_fields: [drr_legacy.Cost_QTD, drr_legacy.Cost_MTD, drr_legacy.Cost_YTD, region_order]
    hidden_pivots: {}
    title_hidden: true
    listen:
      'Report run date:': drr_legacy.Report_Run_Date
    row: 89
    col: 0
    width: 24
    height: 13
  - title: Revenue and GP - 90 days lookback
    name: Revenue and GP - 90 days lookback
    model: DRR
    explore: DRR_Legacy
    type: looker_line
    fields: [drr_legacy.Event_Date_Dt, drr_legacy.Gross_Revenue_Daily, drr_legacy.Cost_Daily]
    fill_fields: [drr_legacy.Event_Date_Dt]
    filters:
      drr_legacy.Data_Type: Ninty days metrics
    sorts: [drr_legacy.Event_Date_Dt desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "(${drr_legacy.Gross_Revenue_Daily}-${drr_legacy.Cost_Daily})/${drr_legacy.Gross_Revenue_Daily}"
      label: GP %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: gp
      _type_hint: number
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
    color_application:
      collection_id: legacy
      palette_id: looker_classic
      options:
        steps: 5
    y_axes: [{label: Revenue, orientation: left, series: [{axisId: drr_legacy.Gross_Revenue_Daily,
            id: drr_legacy.Gross_Revenue_Daily, name: Gross Rev Daily}], showLabels: true,
        showValues: true, unpinAxis: true, tickDensity: custom, type: linear}, {label: '',
        orientation: right, series: [{axisId: gp, id: gp, name: GP %}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: true
    series_types:
      drr_legacy.Gross_Revenue_Daily: area
    series_colors:
      drr_legacy.Gross_Revenue: "#80b1d3"
      drr_legacy.Gross_Profit_Perc: "#ff7f00"
      gp: "#e9b404"
      drr_legacy.Gross_Revenue_NintyDays: "#80b1d3"
      drr_legacy.Gross_Revenue_Daily: "#80b1d3"
    swap_axes: false
    advanced_vis_config: |-
      {
        chart: {},
        series: [{
          name: 'Gross Revenue'
        }, {
          name: 'GP %'
        }],
        "yAxis": [{
            "labels": {
              "style": {
                "color": "black"
              }
            },
            "title": {
              "style": {
                "color": "black",
                "fontSize": "14px"
              }
            }
          },
          {
            "labels": {
              "style": {
                "color": "black"
              }
            },
            "title": {
              "style": {
                "color": "black",
                "fontSize": "14px"
              }
            }
          }
        ]
      }
    defaults_version: 1
    hidden_fields: [drr_legacy.Cost_NintyDays, drr_legacy.Cost_Daily]
    hidden_pivots: {}
    title_hidden: true
    listen:
      'Report run date:': drr_legacy.Report_Run_Date
    row: 4
    col: 16
    width: 8
    height: 19
  - title: Device QTD
    name: Device QTD
    model: DRR
    explore: DRR_Legacy
    type: looker_column
    fields: [device_type, drr_legacy.Net_Revenue_QTD, drr_legacy.Gross_Revenue_QTD]
    filters:
      drr_legacy.Data_Type: Quarterly metrics
    sorts: [device_type]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: dimension
      description: Fromatted
      expression: case(when(${drr_legacy.Device_Type} = "mobile", "MOBILE"), when(${drr_legacy.Device_Type}
        = "ctv", "CTV"), when(${drr_legacy.Device_Type} = "desktop", "DESKTOP"), "UNDEFINED
        (Perf/Other)")
      label: 'Device Type '
      value_format:
      value_format_name:
      dimension: device_type
      _kind_hint: dimension
      _type_hint: string
    - category: table_calculation
      expression: "${drr_legacy.Net_Revenue_QTD}/${drr_legacy.Gross_Revenue_QTD}"
      label: Net Revenue %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: net_revenue
      _type_hint: number
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
      collection_id: legacy
      palette_id: looker_classic
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: drr_legacy.Net_Revenue, id: drr_legacy.Net_Revenue,
            name: Net Revenue}, {axisId: drr_legacy.Gross_Revenue, id: drr_legacy.Gross_Revenue,
            name: Gross Revenue}, {axisId: net_revenue, id: net_revenue, name: Net
              Revenue %}], showLabels: false, showValues: true, unpinAxis: true, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: []
    hide_legend: false
    series_colors:
      drr_legacy.Sum_Revenue: "#80b1d3"
      drr_legacy.Sum_Net_Revenue: "#d0d0d0"
      drr_legacy.Net_Revenue: "#d0d0d0"
      drr_legacy.Gross_Revenue: "#80b1d3"
      drr_legacy.Gross_Revenue_QTD: "#80b1d3"
      drr_legacy.Net_Revenue_QTD: "#d0d0d0"
    label_color: [black]
    show_dropoff: false
    advanced_vis_config: |-
      {
        chart: {
          "type": "column"
        },
        "plotOptions": {
          "column": {
            "stacking": "normal",
            "grouping": false,
            "pointPadding": 0.1
          }
        },
        series: [{
            name: 'Total Net Revenue',
            pointPadding: 0.2,
            pointPlacement: 0,
            "dataLabels": {
              "inside": true,
              "verticalAlign": "bottom",
              "y": -17,
              "style": {
                "color": "black"
              }
            }
          }, {
            name: 'Total Gross Revenue',
            pointPadding: 0.1,
            pointPlacement: 0
          },
          {
            name: '',
            color: "rgba(255, 193, 7, 0)"
          }
        ],
        "yAxis": {
          "title": {
            "text": ""
          },
          "labels": {
            "style": {
              "color": "black"
            }
          },
        },
        "xAxis": {
          "labels": {
            "rotation": 0,
            "align": "center",
            "style": {
              "whiteSpace": "normal",
              "textOverflow": "none",
              "fontSize": "12px"
            }
          }
        }
      }
    hidden_pivots: {}
    defaults_version: 1
    listen:
      'Report run date:': drr_legacy.Report_Run_Date
    row: 46
    col: 16
    width: 8
    height: 19
  - title: Revenue QTD
    name: Revenue QTD
    model: DRR
    explore: DRR_Legacy
    type: looker_grid
    fields: [drr_legacy.Region, drr_legacy.Category, drr_legacy.Subcategory, drr_legacy.Gross_Revenue_QTD, drr_legacy.Net_Revenue_QTD,
      drr_legacy.Cost_QTD]
    filters:
      drr_legacy.Data_Type: Quarterly metrics
    sorts: [drr_legacy.Region, drr_legacy.Category, drr_legacy.Sum_Revenue desc]
    subtotals: [drr_legacy.Region, drr_legacy.Category]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - category: table_calculation
      expression: "(${drr_legacy.Gross_Revenue}-${drr_legacy.Gross_Revenue_Previous_Day})/${drr_legacy.Gross_Revenue}"
      label: Gross Change
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
      table_calculation: gross_change
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: "(${drr_legacy.Net_Revenue}-${drr_legacy.Net_Revenue_Previous_Day})/${drr_legacy.Net_Revenue}"
      label: Net Change
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
      table_calculation: net_change
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: "(${drr_legacy.Gross_Revenue_QTD}-${drr_legacy.Cost_QTD})/${drr_legacy.Gross_Revenue_QTD}"
      label: GP% QTD
      value_format: 0.0%;(0.0%)
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: gp_qtd
      _type_hint: number
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
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
      drr_legacy.Sum_Revenue:
        is_active: true
    series_text_format:
      gp_qtd:
        align: right
    series_value_format:
      drr_legacy.Gross_Revenue_QTD:
        format_string: "$#,##0;($#,##0)"
      drr_legacy.Net_Revenue_QTD:
        format_string: "$#,##0;($#,##0)"
      gp_qtd: 0.0%;(0.0%)
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
    hidden_fields: [drr_legacy.Cost_QTD]
    hidden_pivots: {}
    title_hidden: true
    listen:
      'Report run date:': drr_legacy.Report_Run_Date
    row: 46
    col: 0
    width: 16
    height: 19
  - title: Revenue MTD
    name: Revenue MTD
    model: DRR
    explore: DRR_Legacy
    type: looker_grid
    fields: [drr_legacy.Gross_Revenue_MTD, drr_legacy.Net_Revenue_MTD, drr_legacy.Cost_MTD, region_order,
      drr_legacy.Region, drr_legacy.Category, drr_legacy.Subcategory]
    filters:
      drr_legacy.Data_Type: Monthly metrics
    sorts: [region_order, drr_legacy.Region, drr_legacy.Category, drr_legacy.Subcategory, drr_legacy.Gross_Revenue_MTD
        desc]
    subtotals: [region_order, drr_legacy.Region, drr_legacy.Category]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - category: table_calculation
      expression: "(${drr_legacy.Gross_Revenue}-${drr_legacy.Gross_Revenue_Previous_Day})/${drr_legacy.Gross_Revenue}"
      label: Gross Change
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
      table_calculation: gross_change
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: "(${drr_legacy.Net_Revenue}-${drr_legacy.Net_Revenue_Previous_Day})/${drr_legacy.Net_Revenue}"
      label: Net Change
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
      table_calculation: net_change
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: "(${drr_legacy.Gross_Revenue_MTD}-${drr_legacy.Cost_MTD})/${drr_legacy.Gross_Revenue_MTD}"
      label: GP% MTD
      value_format: 0.0%;(0.0%)
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: gp_mtd
      _type_hint: number
    - category: dimension
      expression: case(when(${drr_legacy.Region} = "Americas", 1),when(${drr_legacy.Region} = "APAC",
        2),when(${drr_legacy.Region} = "EMEA", 3),when(${drr_legacy.Region} = "Non-Regional", 4),
        5)
      label: Region_Order
      value_format:
      value_format_name:
      dimension: region_order
      _kind_hint: dimension
      _type_hint: number
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
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
    series_labels: {}
    series_cell_visualizations:
      drr_legacy.Sum_Revenue:
        is_active: true
    series_text_format:
      gp_mtd:
        align: right
    series_value_format:
      drr_legacy.Gross_Revenue_MTD:
        format_string: "$#,##0;($#,##0)"
      drr_legacy.Net_Revenue_MTD:
        format_string: "$#,##0;($#,##0)"
      gp_mtd: 0.0%;(0.0%)
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
    hidden_fields: [drr_legacy.Cost_MTD, region_order]
    hidden_pivots: {}
    title_hidden: true
    listen:
      'Report run date:': drr_legacy.Report_Run_Date
    row: 25
    col: 8
    width: 16
    height: 19
  - title: Revenue YTD
    name: Revenue YTD
    model: DRR
    explore: DRR_Legacy
    type: looker_grid
    fields: [drr_legacy.Region, drr_legacy.Category, drr_legacy.Subcategory, drr_legacy.Gross_Revenue_YTD, drr_legacy.Net_Revenue_YTD,
      drr_legacy.Cost_YTD]
    filters:
      drr_legacy.Data_Type: Yearly metrics
    sorts: [drr_legacy.Region, drr_legacy.Category, drr_legacy.Subcategory]
    subtotals: [drr_legacy.Region, drr_legacy.Category]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - category: table_calculation
      expression: "(${drr_legacy.Gross_Revenue}-${drr_legacy.Gross_Revenue_Previous_Day})/${drr_legacy.Gross_Revenue}"
      label: Gross Change
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
      table_calculation: gross_change
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: "(${drr_legacy.Net_Revenue}-${drr_legacy.Net_Revenue_Previous_Day})/${drr_legacy.Net_Revenue}"
      label: Net Change
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
      table_calculation: net_change
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: "(${drr_legacy.Gross_Revenue_YTD}-${drr_legacy.Cost_YTD})/${drr_legacy.Gross_Revenue_YTD}"
      label: GP% YTD
      value_format: 0.0%;(0.0%)
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: gp_ytd
      _type_hint: number
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
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
      drr_legacy.Sum_Revenue:
        is_active: true
    series_text_format:
      gp_ytd:
        align: right
    series_value_format:
      drr_legacy.Gross_Revenue_YTD:
        format_string: "$#,##0;($#,##0)"
      drr_legacy.Net_Revenue_YTD:
        format_string: "$#,##0;($#,##0)"
      gp_ytd: 0.0%;(0.0%)
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
    hidden_fields: [drr_legacy.Cost_YTD]
    hidden_pivots: {}
    title_hidden: true
    listen:
      'Report run date:': drr_legacy.Report_Run_Date
    row: 67
    col: 8
    width: 16
    height: 20
  - title: Device YTD
    name: Device YTD
    model: DRR
    explore: DRR_Legacy
    type: looker_column
    fields: [device_type, drr_legacy.Net_Revenue_YTD, drr_legacy.Gross_Revenue_YTD]
    filters:
      drr_legacy.Data_Type: Yearly metrics
    sorts: [device_type]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: dimension
      description: Fromatted
      expression: case(when(${drr_legacy.Device_Type} = "mobile", "MOBILE"), when(${drr_legacy.Device_Type}
        = "ctv", "CTV"), when(${drr_legacy.Device_Type} = "desktop", "DESKTOP"), "UNDEFINED
        (Perf/Other)")
      label: 'Device Type '
      value_format:
      value_format_name:
      dimension: device_type
      _kind_hint: dimension
      _type_hint: string
    - category: table_calculation
      expression: "${drr_legacy.Net_Revenue_YTD}/${drr_legacy.Gross_Revenue_YTD}"
      label: Net Revenue %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: net_revenue
      _type_hint: number
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
      collection_id: legacy
      palette_id: looker_classic
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: drr_legacy.Net_Revenue, id: drr_legacy.Net_Revenue,
            name: Net Revenue}, {axisId: drr_legacy.Gross_Revenue, id: drr_legacy.Gross_Revenue,
            name: Gross Revenue}, {axisId: net_revenue, id: net_revenue, name: Net
              Revenue %}], showLabels: false, showValues: true, unpinAxis: true, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: []
    hide_legend: false
    series_colors:
      drr_legacy.Sum_Revenue: "#80b1d3"
      drr_legacy.Sum_Net_Revenue: "#d0d0d0"
      drr_legacy.Net_Revenue: "#d0d0d0"
      drr_legacy.Gross_Revenue: "#80b1d3"
      drr_legacy.Gross_Revenue_QTD: "#80b1d3"
      drr_legacy.Net_Revenue_QTD: "#d0d0d0"
      drr_legacy.Gross_Revenue_YTD: "#80b1d3"
      drr_legacy.Net_Revenue_YTD: "#d0d0d0"
    label_color: [black]
    show_dropoff: false
    advanced_vis_config: |-
      {
        chart: {
          "type": "column"
        },
        "plotOptions": {
          "column": {
            "stacking": "normal",
            "grouping": false,
            "pointPadding": 0.1
          }
        },
        series: [{
            name: 'Total Net Revenue',
            pointPadding: 0.2,
            pointPlacement: 0,
            "dataLabels": {
              "inside": true,
              "verticalAlign": "bottom",
              "y": -17,
              "style": {
                "color": "black"
              }
            }
          }, {
            name: 'Total Gross Revenue',
            pointPadding: 0.1,
            pointPlacement: 0
          },
          {
            name: '',
            color: "rgba(255, 193, 7, 0)"
          }
        ],
        "yAxis": {
          "title": {
            "text": ""
          },
          "labels": {
            "style": {
              "color": "black"
            }
          },
        },
        "xAxis": {
          "labels": {
            "rotation": 0,
            "align": "center",
            "style": {
              "whiteSpace": "normal",
              "textOverflow": "none",
              "fontSize": "12px"
            }
          }
        }
      }
    hidden_pivots: {}
    defaults_version: 1
    listen:
      'Report run date:': drr_legacy.Report_Run_Date
    row: 67
    col: 0
    width: 8
    height: 20
  - title: Net Revenue and GP - 90 days look back
    name: Net Revenue and GP - 90 days look back
    model: DRR
    explore: DRR_Legacy
    type: looker_line
    fields: [drr_legacy.Event_Date_Dt, drr_legacy.Gross_Revenue_Daily, drr_legacy.Net_Revenue_Daily]
    fill_fields: [drr_legacy.Event_Date_Dt]
    filters:
      drr_legacy.Data_Type: Ninty days metrics
      drr_legacy.Device_Type: ctv
    sorts: [drr_legacy.Event_Date_Dt desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${drr_legacy.Net_Revenue_Daily}/${drr_legacy.Gross_Revenue_Daily}"
      label: GP %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: gp
      _type_hint: number
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
    color_application:
      collection_id: legacy
      palette_id: looker_classic
      options:
        steps: 5
    y_axes: [{label: Revenue, orientation: left, series: [{axisId: drr_legacy.Gross_Revenue_Daily,
            id: drr_legacy.Gross_Revenue_Daily, name: Gross Rev Daily}], showLabels: true,
        showValues: true, unpinAxis: true, tickDensity: default, type: linear}, {
        label: '', orientation: right, series: [{axisId: gp, id: gp, name: GP %}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: true
    series_types:
      drr_legacy.Net_Revenue_Daily: area
      drr_legacy.Gross_Revenue_Daily: area
    series_colors:
      drr_legacy.Gross_Revenue: "#80b1d3"
      drr_legacy.Gross_Profit_Perc: "#ff7f00"
      drr_legacy.Net_Revenue: "#80b1d3"
      drr_legacy.Net_Revenue_NintyDays: "#80b1d3"
      gp: "#e9b404"
      drr_legacy.Net_Revenue_Daily: "#a6cee3"
      drr_legacy.Gross_Revenue_Daily: "#80b1d3"
    swap_axes: false
    advanced_vis_config: |-
      {
        chart: {},
        series: [{
          name: 'Gross Revenue'
        }, {
          name: 'GP %'
        }],
        "yAxis": [{
            "labels": {
              "style": {
                "color": "black"
              }
            },
            "title": {
              "min": null,
              "style": {
                "color": "black",
                "fontSize": "14px"
              }
            }
          },
          {
            "labels": {
              "style": {
                "color": "black"
              }
            },
            "title": {
              "style": {
                "color": "black",
                "fontSize": "14px"
              }
            }
          }
        ]
      }
    defaults_version: 1
    hidden_pivots: {}
    hidden_fields: [drr_legacy.Gross_Revenue_NintyDays, drr_legacy.Net_Revenue_Daily]
    title_hidden: true
    listen:
      'Report run date:': drr_legacy.Report_Run_Date
    row: 102
    col: 0
    width: 24
    height: 9
  filters:
  - name: 'Report run date:'
    title: 'Report run date:'
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: DRR
    explore: DRR_Legacy
    listens_to_filters: []
    field: drr_legacy.Report_Run_Date
