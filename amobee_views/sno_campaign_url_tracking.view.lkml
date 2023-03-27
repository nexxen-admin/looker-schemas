view: campaign_url_tracking {
  sql_table_name: DIM.CAMPAIGN_URL_TRACKING ;;

  dimension: campaign_url_tracking_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_URL_TRACKING_ID ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: changedon {
    type: string
    hidden: yes
    sql: ${TABLE}.CHANGEDON ;;
  }

  dimension: checksum {
    type: number
    hidden: yes
    sql: ${TABLE}.CHECKSUM ;;
  }

  dimension: createdon {
    type: string
    hidden: yes
    sql: ${TABLE}.CREATEDON ;;
  }

  dimension: is_primary {
    type: yesno
    hidden: yes
    sql: ${TABLE}.IS_PRIMARY ;;
  }

  dimension: secure_tracking_url {
    type: string
    hidden: yes
    sql: ${TABLE}.SECURE_TRACKING_URL ;;
  }

  dimension: ssl_compliant {
    type: yesno
    hidden: yes
    sql: ${TABLE}.SSL_COMPLIANT ;;
  }

  dimension: tracking_type {
    type: string
    label: "Campaign URL Tracking Type"
    view_label: "Campaign"
    sql: ${TABLE}.TRACKING_TYPE ;;
    bypass_suggest_restrictions: yes
  }

  dimension: tracking_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.TRACKING_TYPE_ID ;;
  }

  dimension: tracking_url {
    type: string
    label: "Campaign Tracking URL"
    view_label: "Campaign"
    sql: ${TABLE}.TRACKING_URL ;;
    suggestable: no
  }

#   measure: count {
#     type: count
#     label: "Count Campaign URL Tracking"
#     view_label: "Campaign"
#   }
}
