# The name of this view in Looker is "Revenue Vertical Buying Channel"
view: revenue_vertical_buying_channel {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.Revenue_Vertical_Buying_Channel ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Advertiser Category" in Explore.

  dimension: advertiser_category {
    type: string
    sql: ${TABLE}.advertiser_category ;;
  }

   dimension: Verticals {
     type: string
     sql: case when ${revenue_vertical_buying_channel.advertiser_category} = 'CPG' OR ${revenue_vertical_buying_channel.advertiser_category}='Other' OR
                    ${revenue_vertical_buying_channel.advertiser_category}='Food' OR ${revenue_vertical_buying_channel.advertiser_category}='Health' OR
                    ${revenue_vertical_buying_channel.advertiser_category}='Retail' OR ${revenue_vertical_buying_channel.advertiser_category}='Business' OR
                    ${revenue_vertical_buying_channel.advertiser_category}='Entertainment' OR ${revenue_vertical_buying_channel.advertiser_category}='Personal Finance' OR
                    ${revenue_vertical_buying_channel.advertiser_category}='Travel' then ${revenue_vertical_buying_channel.advertiser_category} else 'Grouped Other' end;;
    drill_fields: [advertiser_category]
    link: {
      label: "Show as line plot" #or your label of choice
      url: "
      {% assign vis_config = '{
      \"x_axis_gridlines\":false,\"y_axis_gridlines\":true,\"show_view_names\":false,\"show_y_axis_labels\":true,\"show_y_axis_ticks\":true,\"y_axis_tick_density\":\"default\",\"y_axis_tick_density_custom\":5,\"show_x_axis_label\":true,\"show_x_axis_ticks\":true,\"y_axis_scale_mode\":\"linear\",\"x_axis_reversed\":false,\"y_axis_reversed\":false,\"plot_size_by_field\":false,\"trellis\":\"\",\"stacking\":\"\",\"limit_displayed_rows\":false,\"legend_position\":\"center\",\"point_style\":\"none\",\"show_value_labels\":false,\"label_density\":25,\"x_axis_scale\":\"auto\",\"y_axis_combined\":true,\"show_null_points\":true,\"interpolation\":\"linear\",\"color_application\":{\"collection_id\":\"7c56cc21-66e4-41c9-81ce-a60e1c3967b2\",\"custom\":{\"id\":\"12d121a6-4395-50e8-d81e-e712fab342c2\",\"label\":\"Custom\",\"type\":\"continuous\",\"stops\":[{\"color\":\"#ace0ff\",\"offset\":0},{\"color\":\"#1A73E8\",\"offset\":100}]},\"options\":{\"steps\":5}},\"y_axes\":[{\"label\":\"% Of Total Revenue\",\"orientation\":\"left\",\"series\":[{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Automotive - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Automotive\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Business - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Business\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Careers - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Careers\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Computing - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Computing\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"CPG - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"CPG\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Education - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Education\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Electronics -
        percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Electronics\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Entertainment - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Entertainment\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Family Parenting - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Family Parenting\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Food - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Food\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Government - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Government\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Health - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Health\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Hobbies Interests - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Hobbies Interests\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Home Garden - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Home Garden\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"News - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"News\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Non Standard - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Non Standard\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Other - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Other\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Personal Finance - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Personal Finance\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Pets - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Pets\"},{\"axisId\"
        :\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Real Estate - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Real Estate\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Religion Spirituality - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Religion Spirituality\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Retail - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Retail\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Science - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Science\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Shopping - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Shopping\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Society - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Society\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Sports - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Sports\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Style Fashion - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Style Fashion\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Telecom - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Telecom\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Travel - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Travel\"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Travel  - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Travel \"},{\"axisId\":\"percent_of_revenue_vertical_buying_channel_revenue_1\",\"id\":\"Uncategorized - percent_of_revenue_vertical_buying_channel_revenue_1\",\"name\":\"Uncategorized\"}],\"showLabels\":true,\"showValues\":true,\"unpinAxis\":false,\"tickDensity\":\"default\"
    ,\"tickDensityCustom\":5,\"type\":\"linear\"}],\"x_axis_label\":\"Event Month\",\"x_axis_zoom\":true,\"y_axis_zoom\":false,\"hidden_series\":[\"Pets - revenue_vertical_buying_channel.revenue\",\"Family Parenting - revenue_vertical_buying_channel.revenue\",\"Travel  - revenue_vertical_buying_channel.revenue\",\"Real Estate - revenue_vertical_buying_channel.revenue\",\"Telecom - revenue_vertical_buying_channel.revenue\",\"Style Fashion - revenue_vertical_buying_channel.revenue\",\"Electronics - revenue_vertical_buying_channel.revenue\",\"Sports - revenue_vertical_buying_channel.revenue\",\"Non Standard - revenue_vertical_buying_channel.revenue\",\"Education - revenue_vertical_buying_channel.revenue\",\"News - revenue_vertical_buying_channel.revenue\",\"Society - revenue_vertical_buying_channel.revenue\",\"Shopping - revenue_vertical_buying_channel.revenue\",\"Home Garden - revenue_vertical_buying_channel.revenue\",\"Computing - revenue_vertical_buying_channel.revenue\",\"Science - revenue_vertical_buying_channel.revenue\",\"Hobbies Interests - revenue_vertical_buying_channel.revenue\",\"Careers - revenue_vertical_buying_channel.revenue\",\"Uncategorized - revenue_vertical_buying_channel.revenue\",\"Religion Spirituality - revenue_vertical_buying_channel.revenue\",\"Government - revenue_vertical_buying_channel.revenue\",\"Automotive - revenue_vertical_buying_channel.revenue\",\"Travel - revenue_vertical_buying_channel.revenue\",\"Retail - revenue_vertical_buying_channel.revenue\",\"Personal Finance - revenue_vertical_buying_channel.revenue\",\"Other - revenue_vertical_buying_channel.revenue\",\"Grouped Other - revenue_vertical_buying_channel.revenue\",\"Entertainment - revenue_vertical_buying_channel.revenue\",\"CPG - revenue_vertical_buying_channel.revenue\",\"Food - revenue_vertical_buying_channel.revenue\",\"Health - revenue_vertical_buying_channel.revenue\",\"Business - revenue_vertical_buying_channel.revenue\",\"Business - Business - revenue_vertical_buying_channel.revenue\",\"Food - Food -
  revenue_vertical_buying_channel.revenue\",\"Other - Other - revenue_vertical_buying_channel.revenue\",\"Travel - Travel - revenue_vertical_buying_channel.revenue\",\"Personal Finance - Personal Finance - revenue_vertical_buying_channel.revenue\",\"CPG - CPG - revenue_vertical_buying_channel.revenue\",\"Retail - Retail - revenue_vertical_buying_channel.revenue\",\"Health - Health - revenue_vertical_buying_channel.revenue\",\"Entertainment - Entertainment - revenue_vertical_buying_channel.revenue\"],\"hide_legend\":false,\"series_types\":{},\"series_colors\":{},\"series_labels\":{},\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"show_row_numbers\":false,\"transpose\":false,\"truncate_text\":true,\"truncate_header\":false,\"size_to_fit\":true,\"series_cell_visualizations\":{\"revenue_vertical_buying_channel.revenue\":{\"is_active\":true,\"palette\":{\"palette_id\":\"56d0c358-10a0-4fd6-aa0b-b117bef527ab\",\"collection_id\":\"7c56cc21-66e4-41c9-81ce-a60e1c3967b2\"},\"value_display\":false}},\"table_theme\":\"white\",\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"hide_totals\":false,\"hide_row_totals\":false,\"hidden_pivots\":{},\"type\":\"looker_line\",\"value_labels\":\"legend\",\"label_type\":\"labPer\",\"defaults_version\":1,\"hidden_fields\":[\"percent_of_revenue_vertical_buying_channel_revenue_1\"],\"ordering\":\"none\",\"show_null_labels\":false,\"show_totals_labels\":false,\"show_silhouette\":false,\"totals_color\":\"#808080\",\"truncate_column_names\":false,\"groupBars\":true,\"labelSize\":\"10pt\",\"showLegend\":true,\"hidden_points_if_no\":[]
      }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
   }

  dimension: buying_channel {
    type: string
    sql: ${TABLE}.Buying_Channel ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: year {
    type: string
    sql: ${TABLE}.year ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event_month {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_month ;;
  }

  dimension: imp_type {
    type: string
    sql: ${TABLE}.imp_type ;;
  }

  measure: revenue {
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.Revenue ;;
  }

  dimension: buy_type {
    type: string
    sql: case when ${TABLE}.Buying_Channel='Firstparty - Other' OR ${TABLE}.Buying_Channel='Firstparty - Tvdsp'
    then 'First Party'
              when ${TABLE}.Buying_Channel='Omp' then 'OMP'
              when ${TABLE}.Buying_Channel='Pmp' then 'PMP'
              else ${TABLE}.Buying_Channel end ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  # measure: total_revenue {
  #   type: sum
  #   sql: ${revenue} ;;
  # }

  # measure: average_revenue {
  #   type: average
  #   sql: ${revenue} ;;
  # }

  measure: count {
    type: count
    drill_fields: []
  }
}
