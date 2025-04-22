view: mssql_oltp_campaign_status {
  sql_table_name: dbo.campaign_status (NOLOCK);;

  dimension: campaign_status_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.campaign_status_id ;;
  }

  dimension: active {
    type: string
    hidden: yes
    sql: ${TABLE}.active ;;
  }

  dimension: description {
    type: string
    label: "Campaign Status"
    view_label: "Campaign"
    sql: ${TABLE}.description ;;
  }

  dimension: is_planning {
    type: string
    hidden: yes
    sql: ${TABLE}.is_planning ;;
  }

  dimension: keep_in_ads_cache {
    type: string
    hidden: yes
    sql: ${TABLE}.keep_in_ads_cache ;;
  }

  dimension: keep_in_opt_weights_file {
    type: string
    hidden: yes
    sql: ${TABLE}.keep_in_opt_weights_file ;;
  }

  dimension: lookup_locale_id {
    type: string
    hidden: yes
    sql: ${TABLE}.lookup_locale_id ;;
  }

  dimension: updatedby {
    type: string
    hidden: yes
    sql: ${TABLE}.updatedby ;;
  }

}
