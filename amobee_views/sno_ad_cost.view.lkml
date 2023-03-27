view: sno_ad_cost {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql:
       select ad_content_key,ad_cost from viewership.ad_content ac
        join nielsen_tv_data.aed aed
        on ac.brand_level_4 = aed.ultimate_parent_desc
        and ac.brand_level_3 = aed.parent_desc
        and ac.brand_level_2 = aed.brand_desc
        and ac.brand_level_1 = aed.brand_variant_desc
        and ac.creative_name = aed.creative_desc
        and ac.duration_secs = aed.total_ad_duration
        where {% condition filter_ad_content_key %} ad_content_key {% endcondition %}
        and {% condition date_range %} cast(year||'-'||month||'-'||day as date) {% endcondition %};;
  }

  filter: date_range {
    view_label: "Inputs"
    description: " Range you want data for"
    type: date
  }

  filter: filter_ad_content_key {
    view_label: "Inputs"
    description: "Get the keys from Ad Finder Tool. Enter one or multiple to check exposure"
    type: string
  }

  dimension: ad_content_key {
    view_label: "Outputs"
    primary_key: yes
    type: string
    sql: ${TABLE}.AD_CONTENT_KEY ;;
  }

  dimension: ad_cost {
    view_label: "Outputs"
    primary_key: no
    hidden: yes
    type: number
    sql: ${TABLE}.AD_COST ;;
  }

  measure: total_spending {
    view_label: "Outputs"
    hidden: no
    type: sum
    sql: ${ad_cost} ;;
  }
}
