view: discount_code {
  sql_table_name: dbo.discount_code (NOLOCK) ;;
  label: "Payment Order"

  dimension: discount_code_id {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.discount_code_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: availability {
    type: number
    hidden: yes
    sql: ${TABLE}.availability ;;
  }

  dimension: change_source {
    type: string
    hidden: yes
    sql: ${TABLE}.change_source ;;
  }

  dimension: changedby {
    type: string
    hidden: yes
    sql: ${TABLE}.changedby ;;
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

  dimension: createdby {
    type: string
    hidden: yes
    sql: ${TABLE}.createdby ;;
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

  dimension: discount_code {
    type: string
    label: "Discount Code"
    sql: ${TABLE}.discount_code ;;
  }

  dimension: is_percentage {
    type: string
    label: "Discount Code Is Percentage"
    sql: case when ${TABLE}.is_percentage = 1 then 'p' else 'v' end ;;
  }

  dimension: request_id {
    type: string
    hidden: yes
    sql: ${TABLE}.request_id ;;
  }

  dimension_group: validity_end {
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
    sql: ${TABLE}.validity_end ;;
  }

  dimension_group: validity_start {
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
    sql: ${TABLE}.validity_start ;;
  }

  dimension: value {
    type: number
    label: "Discount Code Value"
    value_format_name: decimal_2
    sql: ${TABLE}.value ;;
  }
}
