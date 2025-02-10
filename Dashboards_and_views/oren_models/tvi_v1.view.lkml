view: tvi_v1 {
  derived_table: {
    sql: select AA.day_date,
       AA.nexxen_dmp_provider,
       AA.country,
       BB.COUNTRY_NAME as country_name,
       AA.segment_id,
       AA.segmenttype,
       sum(AA.imp_price) as imp_price,
       sum(AA.imp_price_adj) as imp_price_adj,
       sum(AA.impressions) as impressions,
       sum(AA.impressions_adj) as impressions_adj
from bi.tvi_report AA
LEFT JOIN BI.country_iso BB
ON AA.country = BB.COUNTRY_CODE
group by 1,2,3,4,5,6
order by day_date,country desc;;

  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: day_date {
    type: date
    sql: ${TABLE}.day_date ;;
    drill_fields: [segment_id,segmenttype]
    label: "Date"
  }


  dimension: nexxen_dmp_provider {
    type: string
    sql: ${TABLE}.nexxen_dmp_provider ;;
    drill_fields: [segment_id,segmenttype]
    label: "Data Provider Name"
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
    drill_fields: [segment_id,segmenttype]
    label: "Country Two Letters"
  }


  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
    drill_fields: [segment_id,segmenttype]
    label: "Country"
  }



  dimension: segment_id {
    type: string
    sql: ${TABLE}.segment_id ;;
  }


  dimension: segmenttype {
    type: string
    sql: ${TABLE}.segmenttype ;;
  }

# measu

  measure: imp_price {
    type: sum
    sql: ${TABLE}.imp_price ;;
    value_format: "$#,##0"
    label: "Total Billable"
  }

  measure: imp_price_adj {
    type: sum
    sql: ${TABLE}.imp_price_adj ;;
    value_format: "$#,##0"
    label: "Total Billable Adjusted*"
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
    value_format: "#,##0"
    label: "Impressions"
  }

  measure: impressions_adj {
    type: sum
    sql: ${TABLE}.impressions_adj ;;
    value_format: "#,##0"
    label: "Impressions Adjusted*"
  }




  set: detail {
    fields: [
      day_date,
      nexxen_dmp_provider,
      country,
      country_name,
      segment_id,
      segmenttype,

      imp_price,
      imp_price_adj,
      impressions,
      impressions_adj
    ]
  }

}
