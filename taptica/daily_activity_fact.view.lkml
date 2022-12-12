# The name of this view in Looker is "Daily Activity Fact"
view: daily_activity_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: bi.Daily_Activity_Fact ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Adv Discount" in Explore.

  dimension: adv_discount {
    type: number
    sql: ${TABLE}.Adv_Discount ;;
    hidden: yes
  }

  dimension: adv_id {
    type: number
    sql: ${TABLE}.AdvId ;;
  }

  dimension: agent_platform {
    type: string
    sql: ${TABLE}.AgentPlatform ;;
    hidden: yes
  }

  measure: blocked {
    type: sum
    sql: ${TABLE}.Blocked ;;
  }

  dimension: blocked_revenue {
    type: number
    sql: ${TABLE}.Blocked_Revenue ;;
    hidden: yes
  }


  measure: clicks {
    type: sum
    sql: ${TABLE}.Clicks ;;
  }

  measure: conversions {
    type: sum
    sql: ${TABLE}.Conversions ;;
  }

  measure: cost {
    type: sum
    sql: ${TABLE}.Cost ;;
  }

  dimension: count_sub_id {
    type: number
    sql: ${TABLE}.CountSubID ;;
    hidden: yes
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.CountryCode ;;
  }

  dimension: cpeevents {
    type: number
    sql: ${TABLE}.CPEEvents ;;
  }

  dimension: cpi {
    type: number
    sql: ${TABLE}.CPI ;;
  }

  measure: delayed_conversions {
    type: sum
    sql: ${TABLE}.DelayedConversions ;;
  }

  measure: early_conversions {
    type: sum
    sql: ${TABLE}.EarlyConversions ;;
  }

  dimension: extract {
    type: number
    sql: ${TABLE}."Extract" ;;
    hidden: yes
  }

  measure: geo_mismatch {
    type: sum
    sql: ${TABLE}.GeoMismatch ;;
  }

  measure: goal1 {
    type: sum
    sql: ${TABLE}.Goal1 ;;
  }

  measure: goal2 {
    type: sum
    sql: ${TABLE}.Goal2 ;;
  }

  measure: goal3 {
    type: sum
    sql: ${TABLE}.Goal3 ;;
  }

  measure: goal4 {
    type: sum
    sql: ${TABLE}.Goal4 ;;
  }

  measure: goal5 {
    type: sum
    sql: ${TABLE}.Goal5 ;;
  }

  measure: goal6 {
    type: sum
    sql: ${TABLE}.Goal6 ;;
  }

  dimension: legit_conversions {
    type: number
    sql: ${TABLE}.LegitConversions ;;
  }

  dimension: legit_cpeevents {
    type: number
    sql: ${TABLE}.LegitCPEEvents ;;
  }

  dimension: mtti_conversions {
    type: number
    sql: ${TABLE}.MTTI_Conversions ;;
  }

  dimension: offer_id {
    type: number
    sql: ${TABLE}.OfferID ;;
  }

  dimension: over_budget_conversions {
    type: number
    sql: ${TABLE}.OverBudgetConversions ;;
  }

  dimension: payout_type {
    type: string
    sql: ${TABLE}.PayoutType ;;
    hidden: yes
  }

  dimension: publisher_id {
    type: number
    sql: ${TABLE}.PublisherID ;;
  }

  measure: rejected {
    type: sum
    sql: ${TABLE}."Rejected" ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.Revenue ;;
  }

  dimension: sub_id {
    type: string
    sql: ${TABLE}.SubId ;;
    #hidden: yes
  }

  dimension: sub_idpaused {
    type: number
    sql: ${TABLE}.SubIDPaused ;;
    hidden: yes
  }

  dimension: suspicious {
    type: number
    sql: ${TABLE}.Suspicious ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: tr {
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
    label: "Date"
    sql: ${TABLE}.TrDate ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
