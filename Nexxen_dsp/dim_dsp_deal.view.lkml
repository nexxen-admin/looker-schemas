view: dim_dsp_deal {
  sql_table_name: BI_DSP.dim_dsp_deal ;;

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }
  dimension: deal_id {
    type: string
    sql: ${TABLE}.deal_id ;;
  }

  dimension: deal_name {
    type: string
    label: "Deal Name"
    sql: ${TABLE}.deal_name ;;
  }

  dimension: deal_type_name {
    type: string
    label: "Deal Type Name"
    sql: ${TABLE}.deal_type_name ;;
  }

  # dimension: deal_vs_pmp {
  #   type: string
  #   label: "Deal vs. PMP"
  #   sql: CASE WHEN ${deal_type_name} = '' THEN 'Open Auction' ELSE 'PMP' END ;;
  # }

  dimension: deal_vs_pmp {
    type: string
    label: "Deal vs. PMP"
    sql: CASE
            WHEN ${deal_type_name} IN ('PrivateAuction', 'UnreservedFixed') THEN 'PMP'
            WHEN ${deal_type_name} IS NOT NULL AND ${deal_type_name} != 'Unknown' AND ${deal_type_name} != '' THEN 'Deal - Other'
            ELSE 'OMP'
         END ;;
  }

  dimension: deal_key {
    type: number
    sql: ${TABLE}.deal_key ;;
    hidden: yes
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden:  yes
  }
  measure: count {
    type: count
    hidden: yes
  }
}
