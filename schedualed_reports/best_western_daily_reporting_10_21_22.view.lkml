view: best_western_daily_reporting_10_21_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql:SELECT date::date as date,
       flight_number,
       CASE WHEN flight_number IN ('F-301654', 'F-301655')  THEN 345900188
          WHEN flight_number IN ('F-301657', 'F-301658') THEN 345900182
          WHEN flight_number IN ('F-301660', 'F-301661') THEN 345900185
          WHEN flight_number IN ('F-301663', 'F-301664') THEN 346174516
          WHEN flight_number IN ('F-301666', 'F-301667') THEN 346174513
               ELSE 346174510 END AS "DCM Placement ID",
      CASE WHEN flight_number = 'F-301654' THEN 'CTV Branded Frame + QR Code + BT Targeting - US TARGETING'
           WHEN flight_number = 'F-301657' THEN 'OLV (D/M/T) Custom Decision Tree Unit + BT Targeting - US TARGETING'
           WHEN flight_number = 'F-301660' THEN 'OLV (D/M/T) Overlay & End Card (Plus) + BT Targeting - US TARGETING'
           WHEN flight_number = 'F-301663' THEN 'CTV Branded Frame + QR Code + BT Targeting - CANADA TARGETING'
           WHEN flight_number = 'F-301666' THEN 'OLV (D/M/T) Overlay & End Card (Plus) + BT Targeting - CANADA TARGETING'
           WHEN flight_number = 'F-301669' THEN 'OLV (D/M/T) Custom Decision Tree Unit + BT Targeting - CANADA TARGETING'
           WHEN flight_number = 'F-301655' THEN 'CTV Branded Frame + QR Code + BT Targeting - US TARGETING'
           WHEN flight_number = 'F-301658' THEN 'OLV (D/M/T) Custom Decision Tree Unit + BT Targeting - US TARGETING'
           WHEN flight_number = 'F-301661' THEN 'OLV (D/M/T) Overlay & End Card (Plus) + BT Targeting - US TARGETING'
           WHEN flight_number = 'F-301664' THEN 'CTV Branded Frame + QR Code + BT Targeting - CANADA TARGETING'
           WHEN flight_number = 'F-301667' THEN 'OLV (D/M/T) Overlay & End Card (Plus) + BT Targeting - CANADA TARGETING'
               ELSE 'OLV (D/M/T) Custom Decision Tree Unit + BT Targeting - CANADA TARGETING' END AS "Placement Name",
      CASE WHEN flight_number = 'F-301654' THEN (SUM(impressions)/1000)*26
           WHEN flight_number = 'F-301657' THEN (SUM(impressions)/1000)*19
           WHEN flight_number = 'F-301660' THEN (SUM(impressions)/1000)*18
           WHEN flight_number = 'F-301663' THEN (SUM(impressions)/1000)*26
           WHEN flight_number = 'F-301666' THEN (SUM(impressions)/1000)*18
           WHEN flight_number = 'F-301669' THEN (SUM(impressions)/1000)*19
           WHEN flight_number = 'F-301655' THEN (SUM(impressions)/1000)*26
           WHEN flight_number = 'F-301658' THEN (SUM(impressions)/1000)*19
           WHEN flight_number = 'F-301661' THEN (SUM(impressions)/1000)*18
           WHEN flight_number = 'F-301664' THEN (SUM(impressions)/1000)*26
           WHEN flight_number = 'F-301667' THEN (SUM(impressions)/1000)*18
               ELSE (SUM(impressions)/1000)*19 END AS "Spend"
FROM dwh.ad_data_daily add2
  LEFT JOIN dwh.campaign c on add2.flight_id = c.flight_id
WHERE date >= '2022-10-03'
  AND date < CURRENT_DATE()
  AND data_type = 'AD_DATA'
  AND buy_type NOT IN ('Direct', 'Programmatic_Guaranteed')
  AND impressions > 0
  AND flight_number IN('F-301654','F-301657','F-301660','F-301663', 'F-301666', 'F-301669',
             'F-301655', 'F-301658','F-301661', 'F-301664', 'F-301667' )
GROUP BY 1,2,3,4
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
    sql: ${TABLE}."date" ;;
  }

  dimension: flight_number {
    type: string
    label: "Flight Number"
    sql: ${TABLE}.flight_number ;;
  }

  dimension: dcm_placement_id {
    type: number
    label: "DCM Placement ID"
    sql: ${TABLE}."DCM Placement ID" ;;
  }

  dimension: placement_name {
    type: string
    label: "Placement Name"
    sql: ${TABLE}."Placement Name" ;;
  }

  dimension: spend {
    type: number
    label: "Spend"
    value_format: "#,##0.00"
    sql: ${TABLE}.Spend ;;
  }

  set: detail {
    fields: [date, flight_number, dcm_placement_id, placement_name, spend]
  }
}
