view: campaign_first_delivery {
  derived_table: {
    sql_trigger_value: select hour(dateadd(m, 5, current_time())) ;;
    sql: SELECT campaign_id,first_delivery_date,last_delivery_date FROM(
     SELECT
        cd.campaign_id,
        min(ri.keydate) AS first_delivery_date,
        max(ri.keydate) AS last_delivery_date
      FROM dim.campaign_details_base_view AS cd
      JOIN rawdb.raw_impression AS ri ON cd.campaign_id = ri.campaign_id
      GROUP BY cd.campaign_id ) AS cfd;;
  }

  dimension: first_delivery_date {
    type: date_time
    sql:  ${TABLE}.first_delivery_date ;;
  }

  dimension: campaign_id {
      type: number
      hidden: yes
      sql: ${TABLE}.campaign_id ;;
  }

  dimension: last_delivery_date {
    type: date_time
    hidden: yes
    sql:  ${TABLE}.last_delivery_date ;;
  }
}
