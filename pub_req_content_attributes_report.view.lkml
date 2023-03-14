view: pub_req_content_attributes_report {
  derived_table: {
    sql: select *
      from Andromeda.pub_req_content_attributes_report
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: event_time {
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
    sql: ${TABLE}.event_time ;;
  }

  dimension: pubid {
    type: string
    sql: ${TABLE}.pubid ;;
  }

  dimension: cntcontentrating {
    type: string
    sql: ${TABLE}.cntcontentrating ;;
  }

  dimension: contentratingnorm {
    type: string
    sql: ${TABLE}.contentratingnorm ;;
    drill_fields: [cntcontentrating]
  }

  dimension: cntgenre {
    type: string
    sql: ${TABLE}.cntgenre ;;
  }

  dimension: genrenorm {
    type: string
    sql: ${TABLE}.genrenorm ;;
    drill_fields: [cntgenre]
    link: {
      label: "Show as line plot" #or your label of choice
      url: "
      {% assign vis_config = '{
      [\"x_axis_gridlines\":false,\"y_axis_gridlines\":true,\"show_view_names\":false,\"show_y_axis_labels\":true,\"show_y_axis_ticks\":true,\"y_axis_tick_density\":\"default\",\"y_axis_tick_density_custom\":5,\"show_x_axis_label\":true,\"show_x_axis_ticks\":true,\"y_axis_scale_mode\":\"linear\",\"x_axis_reversed\":false,\"y_axis_reversed\":false,\"plot_size_by_field\":false,\"trellis\":\"\",\"stacking\":\"\",\"limit_displayed_rows\":false,\"legend_position\":\"center\",\"point_style\":\"none\",\"show_value_labels\":false,\"label_density\":25,\"x_axis_scale\":\"auto\",\"y_axis_combined\":true,\"ordering\":\"none\",\"show_null_labels\":false,\"show_totals_labels\":false,\"show_silhouette\":false,\"totals_color\":\"#808080\",\"x_axis_zoom\":true,\"y_axis_zoom\":true,\"series_colors\":{\"pub_req_content_attributes_report.count\":\"#4e90bf\"},\"type\":\"looker_column\",\"defaults_version\":1]
      }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }

  }

  dimension: cntlanguage {
    type: string
    sql: ${TABLE}.cntlanguage ;;
  }

  dimension: cntlanguagenorm {
    type: string
    sql: ${TABLE}.cntlanguagenorm ;;
    drill_fields: [cntlanguage]
  }

  measure: count_ {
    type: sum
    sql: ${TABLE}.count ;;
  }

  set: detail {
    fields: [
      pubid,
      cntcontentrating,
      contentratingnorm,
      cntgenre,
      genrenorm,
      cntlanguage,
      cntlanguagenorm,
      count_
    ]
  }
}
