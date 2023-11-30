# The name of this view in Looker is "Dim Dsp Advertiser"
view: dim_dsp_advertiser {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_dsp_advertiser ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Advertiser ID" in Explore.

  dimension: advertiser_id {
    type: number
    label: "Advertiser ID"
    sql: ${TABLE}.advertiser_id ;;
  }

  dimension: advertiser_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.advertiser_id_key ;;
    hidden: yes
  }

  dimension: advertiser_name {
    type: string
    label: "Advertiser Name"
    sql: ${TABLE}.advertiser_name ;;
  }

  dimension: category_id {
    type: number
    label: "Category ID"
    sql: ${TABLE}.category_id ;;
  }

  dimension: client_status_id {
    type: number
    label: "Client Status ID"
    sql: ${TABLE}.client_status_id ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension: created_date {
    type: date
    sql: ${TABLE}.created_date ;;
  }

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

  dimension: entity_id {
    type: number
    label: "Entity ID"
    sql: ${TABLE}.entity_id ;;

  }

  dimension: first_impressions {
    type: date
    label: "First Impression Date"
    sql: ${TABLE}.first_impressions_date ;;
  }

  dimension: is_deleted {
    type: number
    label: "Is Deleted"
    sql: ${TABLE}.is_deleted ;;
  }

  dimension_group: last_modified {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_modified_date ;;
    hidden: yes
  }

  dimension: primary_url {
    type: string
    label: "Primary URL"
    sql: ${TABLE}.primary_url ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }

  dimension: salesforce_account_id {
    type: string
    label: "Salseforce Account ID"
    sql: ${TABLE}.salesforce_account_id ;;
  }

  dimension: tpa_advertiser_name {
    type: string
    label: "3rd Party Advertiser Name"
    sql: ${TABLE}.tpa_advertiser_name ;;
  }

  dimension: workflow_status_id {
    type: number
    label: "Workflow Status ID"
    sql: ${TABLE}.workflow_status_id ;;
  }
  measure: count {
    type: count
    drill_fields: [advertiser_name, tpa_advertiser_name]
    hidden: yes
  }
}
