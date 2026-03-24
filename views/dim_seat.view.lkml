view: dim_seat {
  sql_table_name: BI_New.V_Dim_Seat ;;

  dimension_group: db_create {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DB_Create_Date ;;
    hidden: yes
  }

  dimension_group: db_update {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DB_Update_Date ;;
    hidden: yes
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  dimension: seat_id {
    type: string
    description: "The identification of a gateway in which a specific inventory is sent to the DSP"
    sql: ${TABLE}.Seat_ID ;;
  }

  dimension: 1p_demand_type {
    type: string
    label: "1P Demand Type"
    description: "Classification of 1st party Nexxen demand based on the DSP Seat."
    sql:CASE WHEN ${TABLE}.Seat_ID IN ('58', '884', '961', '1008', '1090', '1487', '1547', '1577', '1637', '1792', '2050', '2067', '2099', '2141', '2148', '2164', '2193', '2196', '2240', '2292')  THEN '1P DSP Managed Service'
    WHEN ${TABLE}.Seat_ID IN ('141', '175', '861', '1069', '109', '1204', '1371', '1472', '1477', '1480', '1602', '1608', '1778', '190', '2011', '2045', '2048', '2058', '2069', '2086', '2127', '2139', '2143', '2147', '2158', '2159', '2166', '2169', '2175', '2181', '2183', '2184', '2190', '2197', '2201', '2203', '2207', '2215', '2228', '2229', '2233', '2235', '2239', '2258', '2263', '2266', '2267', '2270', '2272', '2276', '2277', '2278', '2282', '2283', '2285', '2286', '2287', '2290', '2298', '2304') THEN '1P DSP Self Service'
        ELSE 'Unclassified' END;;
  }

  dimension: seat_key {
    type: number
    sql: ${TABLE}.Seat_Key ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
