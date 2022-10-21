view: ctv_frequency_by_month {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: WITH frequency_data AS (
      SELECT date_trunc('week', date)::date as date,
             add2.flight_id,
             c.flight_number,
           screen_type_name,
           c.buy_type,
           SUM(impressions)/SUM(placement_reach) AS "Frequency"
      FROM dwh.ad_data_daily add2
      left outer join dwh.screen_type st on add2.screen_type = st.screen_type_code
      Left join dwh.campaign c on add2.flight_id = c.flight_id
        WHERE screen_type_name = 'CTV'
        AND date >= '2022-08-01'
        AND date < CURRENT_DATE()
        AND data_type = 'AD_DATA'
        AND c.buy_type NOTNULL
        AND impressions > 0
      GROUP BY 1,2,3,4,5
      ORDER BY 1 ASC
      ),

      sf_meta_data AS (
      SELECT sf.flight_number,
      so.name,
      so.csm_id,
      su.full_name
      FROM andromeda.sf_opportunity so
      INNER JOIN andromeda.sf_flight sf on so.id = sf.opportunity_id
      INNER JOIN andromeda.sf_user su on so.csm_id = su.id
      )

      SELECT fd.date AS "Date",
      fd.flight_id AS "Flight ID",
      fd.screen_type_name AS "Screen Type",
      fd.buy_type AS "Buy Type",
      smd.full_name AS "CSM",
      fd.frequency
      FROM frequency_data fd
      LEFT JOIN sf_meta_data smd on fd.flight_number = smd.flight_number
      WHERE fd.buy_type = 'Guaranteed_Managed_Service'
      AND smd.flight_number NOTNULL
      ORDER BY 1 ASC
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    label: "Date"
    sql: ${TABLE}."Date" ;;
  }

  dimension: flight_id {
    type: number
    label: "Flight ID"
    sql: ${TABLE}."Flight ID" ;;
  }

  dimension: screen_type {
    type: string
    label: "Screen Type"
    sql: ${TABLE}."Screen Type" ;;
  }

  dimension: buy_type {
    type: string
    label: "Buy Type"
    sql: ${TABLE}."Buy Type" ;;
  }

  dimension: csm {
    type: string
    label: "CSM"
    sql: ${TABLE}.CSM ;;
  }

  dimension: frequency {
    type: number
    label: "Frequency"
    sql: ${TABLE}.frequency ;;
  }

  set: detail {
    fields: [
      date,
      flight_id,
      screen_type,
      buy_type,
      csm,
      frequency
    ]
  }
}
