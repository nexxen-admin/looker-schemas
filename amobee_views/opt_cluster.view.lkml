view: cluster {
  sql_table_name: AN_SMART..cluster (NOLOCK) ;;
  label: "Cluster"

  dimension: cluster_id {
    primary_key: yes
    label: "Cluster ID"
    type: number
    sql: ${TABLE}.cluster_id ;;
    value_format_name: id
  }

  dimension: active {
    type: string
    hidden: yes
    sql: ${TABLE}.active ;;
  }

  dimension: change_source {
    type: string
    hidden: yes
    sql: ${TABLE}.change_source ;;
  }

  dimension_group: changedon {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.changedon ;;
  }

  dimension: cluster_name {
    type: string
    label: "Cluster"
    sql: ${TABLE}.cluster_name ;;
  }

  dimension: cluster_set_id {
    type: number
    hidden: yes
    sql: ${TABLE}.cluster_set_id ;;
  }

  dimension: cluster_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.cluster_type_id ;;
  }

  dimension: completed_fraction {
    type: number
    hidden: yes
    sql: ${TABLE}.completed_fraction ;;
  }

  dimension_group: createdon {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.createdon ;;
  }

  dimension: ctr_natural_frac {
    type: number
    hidden: yes
    sql: ${TABLE}.ctr_natural_frac ;;
  }

  dimension: notes {
    type: string
    hidden: yes
    sql: ${TABLE}.notes ;;
  }

  dimension: placement_id {
    type: number
    sql: ${TABLE}.placement_id ;;
    value_format_name: id
  }

  dimension: q_mprime {
    type: number
    hidden: yes
    sql: ${TABLE}.q_mprime ;;
  }

  dimension: q_value {
    type: number
    hidden: yes
    sql: ${TABLE}.q_value ;;
  }

  dimension: ranking {
    type: number
    hidden: yes
    sql: ${TABLE}.ranking ;;
  }

  dimension: target_segment_id {
    type: number
    hidden: yes
    sql: ${TABLE}.target_segment_id ;;
  }


}
