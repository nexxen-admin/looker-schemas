view: monthly_ip_stability {
  derived_table: {
    sql:

select Time_period,
       country,
       ip1,
       ip2,
       ip3,
       ip4,
       ip5,
       ip6,
       ip7,
       ip8
from bi_new.monthly_ip_stability



      ;;
  }



  dimension: Time_period {
    type: string
    label: "Time range"
    sql: ${TABLE}.Time_period ;;
  }

  dimension: country {
    type: string
    label: "country"
    sql: ${TABLE}.country ;;
  }

  measure: ip1 {
    type: average
    label: "Devices (1 IP)"
    sql: ${TABLE}.ip1 ;;
  }

  measure: ip2 {
    type: average
    label: "Devices (2 IP)"
    sql: ${TABLE}.ip2 ;;
  }

  measure: ip3 {
    type: average
    label: "Devices (3 IP)"
    sql: ${TABLE}.ip3 ;;
  }



  measure: ip4 {
    label: "Devices (4 IP)"
    type: average
    sql: ${TABLE}.ip4 ;;
  }

  measure: ip5 {
    label: "Devices (5 IP)"
    type: average
    sql: ${TABLE}.ip5 ;;
  }

  measure: ip6 {
    type: average
    label: "Devices (6 IP)"
    sql: ${TABLE}.ip6 ;;
  }

  measure: ip7 {
    label: "Devices (7 IP)"
    type: average
    sql: ${TABLE}.ip7 ;;
  }

  measure: ip8 {
    label: "Devices (8 IP)"
    type: average
    sql: ${TABLE}.ip8 ;;
  }


  set: detail {
    fields: [
      Time_period,
      country,
      ip1,
      ip2,
      ip3,
      ip4,
      ip5,
      ip6,
      ip7,
      ip8
    ]
  }
}
