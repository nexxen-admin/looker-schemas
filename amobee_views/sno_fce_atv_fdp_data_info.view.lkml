view: fce_atv_fdp_data_info {
  label: "Pool Info"
  derived_table: {
    sql:
      select
        t.*
      from
      (
        select
          i.kind,
          i.name,
          i.version,
          i.createdon,
          i.group_complete,
          i.active_start,
          i.active_end,
          CURRENT_TIMESTAMP >= COALESCE(i.active_start, '1900-01-01') and CURRENT_TIMESTAMP < i.active_end as is_active,
          i.data_start,
          i.data_end,
          i.category,
          i.iid,
          i.gid,
          row_number() over (order by i.iid desc) as rn
        from
          fce_atv_fdp_data.info i
        where
          {% condition kind %} i.kind {% endcondition %} and
          {% condition name %} i.name {% endcondition %} and
          {% condition version %} i.version {% endcondition %} and
          {% condition createdon_time %} i.createdon {% endcondition %} and
          {% condition createdon_date %} i.createdon {% endcondition %} and
          {% condition group_complete_time %} i.group_complete {% endcondition %} and
          {% condition group_complete_date %} i.group_complete {% endcondition %} and
          {% condition active_start_time %} i.active_start {% endcondition %} and
          {% condition active_start_date %} i.active_start {% endcondition %} and
          {% condition active_end_time %} i.active_end {% endcondition %} and
          {% condition active_end_date %} i.active_end {% endcondition %} and
          {% condition active %} CURRENT_TIMESTAMP >= COALESCE(i.active_start, '1900-01-01') and CURRENT_TIMESTAMP < i.active_end {% endcondition %} and
          {% condition data_start_time %} i.data_start {% endcondition %} and
          {% condition data_start_date %} i.data_start {% endcondition %} and
          {% condition data_end_time %} i.data_end {% endcondition %} and
          {% condition data_end_date %} i.data_end {% endcondition %} and
          {% condition category %} i.category {% endcondition %} and
          {% condition iid %} i.iid {% endcondition %} and
          {% condition gid %} i.gid {% endcondition %}
      ) as t
      where
        t.rn = 1 ;;
  }

  dimension: kind {
    type: string
    label: "Kind"
    sql: ${TABLE}.kind ;;
  }

  dimension: name {
    type: string
    label: "Name"
    sql: ${TABLE}.name ;;
  }

  dimension: version {
    type: string
    label: "Version"
    sql: ${TABLE}.version ;;
  }

  dimension_group: createdon {
    type: time
    label: "Created On"
    timeframes: [raw, time, date]
    sql: ${TABLE}.createdon ;;
  }

  dimension_group: group_complete {
    type: time
    label: "Group Complete"
    timeframes: [raw, time, date]
    sql: ${TABLE}.group_complete ;;
  }

  dimension_group: active_start {
    type: time
    label: "Active Start"
    timeframes: [raw, time, date]
    sql: ${TABLE}.active_start ;;
  }

  dimension_group: active_end {
    type: time
    label: "Active End"
    timeframes: [raw, time, date]
    sql: ${TABLE}.active_end ;;
  }

  dimension: active {
    type: yesno
    label: "Active"
    sql: ${TABLE}.is_active ;;
  }

  dimension_group: data_start {
    type: time
    label: "Data Start"
    timeframes: [raw, time, date]
    sql: ${TABLE}.data_start ;;
  }

  dimension_group: data_end {
    type: time
    label: "Data End"
    timeframes: [raw, time, date]
    sql: ${TABLE}.data_end ;;
  }

  dimension: category {
    type: string
    label: "Category"
    sql: ${TABLE}.category ;;
  }

  dimension: iid {
    type: number
    label: "IID"
    value_format_name: id
    sql: ${TABLE}.iid ;;
  }

  dimension: gid {
    type: number
    label: "GID"
    value_format_name: id
    sql: ${TABLE}.gid ;;
  }
}
