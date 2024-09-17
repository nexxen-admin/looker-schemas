# The name of this view in Looker is "Dim Deal Partner"
view: dim_deal_partner {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.dim_deal_partner ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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

  dimension_group: deal_partner_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.deal_partner_created_at ;;
    hidden: yes
  }

  dimension_group: deal_partner_deleted {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.deal_partner_deleted_at ;;
    hidden: yes
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Deal Partner Display Name" in Explore.

  dimension: deal_partner_display_name {
    type: string
    sql: ${TABLE}.deal_partner_display_name ;;
  }

  dimension: deal_partner_id {
    type: number
    label: "Deal Partner ID"
    sql: ${TABLE}.deal_partner_id ;;
  }

  dimension: deal_partner_name {
    type: string
    sql: ${TABLE}.deal_partner_name ;;
  }

  dimension: deal_partner_status {
    type: string
    sql: ${TABLE}.deal_partner_status ;;
  }

  dimension_group: deal_partner_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.deal_partner_updated_at ;;
    hidden: yes
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [deal_partner_display_name, deal_partner_name]
  }
}
