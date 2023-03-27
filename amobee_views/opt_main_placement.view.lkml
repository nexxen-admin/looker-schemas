view: opt_main_placement {
  label: "Placement Details"

  derived_table: {
    sql:
      SELECT a.*, p.description as platform_client,
      d.description as device_type, f.description as format_type,
      b.description as buy_type,
      pa.partner_name,
      pa.platform_client_id ,
      co.description as country
      from an_main..placement a
      left join an_main..device_type d
      on d.device_type_id = a.device_type_id
      left join an_main..format_type f
      on f.format_type_id = a.format_type_id
      left join an_main..partner pa
      on pa.partner_id =a.partner_id
      left join an_main..platform_client p
      on p.platform_client_id = pa.platform_client_id
      left join an_main..buy_type b
      on b.buy_type_id = a.buy_type_id
left join an_main..country co
on co.country_id = a.country_id
    ;;
  }

  dimension: placement_id {
       description: "placement_id"
    value_format_name: id
       type: number
       sql: ${TABLE}.placement_id ;;
     }
  dimension: placement_name {
    description: "placement_name"
    type: string
    sql: ${TABLE}.placement_name ;;
  }
  dimension: partner_name {
    description: "partner_name"
    type: string
    sql: ${TABLE}.partner_name ;;
  }
  dimension: partner_id {
    type: number
    hidden: yes
    sql: ${TABLE}.partner_id ;;
  }
  dimension: country_id {
    description: "country_id"
    type: number
    value_format_name: id
    sql: ${TABLE}.country_id ;;
  }
  dimension: device_type_id {
    description: "device_type_id"
    type: number
    value_format_name: id
    sql: ${TABLE}.device_type_id ;;
  }
  dimension: format_type_id {
    description: "format_type_id"
    type: number
    value_format_name: id
    sql: ${TABLE}.format_type_id ;;
  }
  dimension: buy_type_id {
    description: "buy_type_id"
    type: number
    value_format_name: id
    sql: ${TABLE}.buy_type_id ;;
  }
  dimension: platform_client_id {
    description: "platform_client_id"
    type: number
    value_format_name: id
    sql: ${TABLE}.platform_client_id ;;
  }
  dimension: buy_type {
    description: "buy_type"
    label: "Buy Type"
    type: string
    sql: ${TABLE}.buy_type;;
  }

  dimension: platform_client {
    description: "platform_client"
    label: "Platform Client"
    type: string
    sql: ${TABLE}.platform_client;;
  }
  dimension: device_type {
    description: "device_type"
    label: "Device Type"
    type: string
    sql: ${TABLE}.device_type;;
  }
  dimension: format_type {
    description: "format_type"
    label: "Format Type"
    type: string
    sql: ${TABLE}.format_type;;
  }
  dimension: country {
    description: "country"
    label: "Country"
    type: string
    sql: ${TABLE}.country;;
  }
}
