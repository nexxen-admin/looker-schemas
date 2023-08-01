view: sno_domain_spreader {
  label: "Domain Spreader"
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql:
      select  coalesce(dt.campaign_id, ct.campaign_id) as CAMPAIGN_ID
  ,dt.DOMAIN_URL as DOMAIN_URL
  ,max(dt.DOMAIN_IMPRESSIONS) as DOMAIN_IMPRESSIONS
  ,max(ct.CAMPAIGN_IMPRESSIONS) as CAMPAIGN_IMPRESSIONS
  ,COALESCE((max(dt.DOMAIN_IMPRESSIONS) / (CASE WHEN max(ct.CAMPAIGN_IMPRESSIONS)= 0 THEN NULL ELSE max(ct.CAMPAIGN_IMPRESSIONS) END)), 0) as DOMAIN_IMPRESSION_RATE
from  (SELECT dds.DOMAIN_URL DOMAIN_URL
  ,fmd.campaign_id campaign_id
  ,sum(dds.IMPRESSIONS) as  DOMAIN_IMPRESSIONS
FROM demand_mart.DAILY_DOMAIN_STATS dds
JOIN dim.FLIGHT_MEDIA_DETAILS fmd ON (dds.FLIGHT_MEDIA_ID = fmd.FLIGHT_MEDIA_ID)
JOIN dim.CAMPAIGN_DETAILS cd ON (fmd.campaign_id = cd.campaign_id)
JOIN dim.INSERTION_ORDER_DETAILS io ON (cd.insertion_order_id = io.insertion_order_id)
WHERE (
  1=1
  AND {% condition campaign_details_base.campaign_id %} fmd.CAMPAIGN_ID  {% endcondition %}
  AND {% condition campaign_details_base.platform_client_id %} cd.PLATFORM_CLIENT_ID  {% endcondition %}
  AND {% condition campaign_details_base.platform_client_description %} cd.PLATFORM_CLIENT_DESCRIPTION  {% endcondition %}
  AND {% condition campaign_details_base.is_test_campaign %} cd.IS_TEST_CAMPAIGN  {% endcondition %}
  AND {% condition campaign_details_base.isfiller %} cd.ISFILLER  {% endcondition %}
  AND {% condition campaign_details_base.campaign_status_description %} cd.CAMPAIGN_STATUS_DESCRIPTION  {% endcondition %}
  AND {% condition campaign_details_base.business_region_description %} cd.BUSINESS_REGION_DESCRIPTION  {% endcondition %}

    )
GROUP BY dds.DOMAIN_URL
  ,fmd.campaign_id
  ) dt
  full outer join
  (SELECT fmd.campaign_id
  ,sum(dcs.IMPRESSIONS) as CAMPAIGN_IMPRESSIONS
FROM demand_mart.DAILY_CORE_STATS_VIEW dcs
JOIN dim.FLIGHT_MEDIA_DETAILS fmd ON (dcs.FLIGHT_MEDIA_ID = fmd.FLIGHT_MEDIA_ID)
JOIN dim.CAMPAIGN_DETAILS cd ON (fmd.campaign_id = cd.campaign_id)
JOIN dim.INSERTION_ORDER_DETAILS io ON (cd.insertion_order_id = io.insertion_order_id)
WHERE (
  1=1
  AND {% condition campaign_details_base.campaign_id %} fmd.CAMPAIGN_ID  {% endcondition %}
  AND {% condition campaign_details_base.platform_client_id %} cd.PLATFORM_CLIENT_ID  {% endcondition %}
  AND {% condition campaign_details_base.platform_client_description %} cd.PLATFORM_CLIENT_DESCRIPTION  {% endcondition %}
  AND {% condition campaign_details_base.is_test_campaign %} cd.IS_TEST_CAMPAIGN  {% endcondition %}
  AND {% condition campaign_details_base.isfiller %} cd.ISFILLER  {% endcondition %}
  AND {% condition campaign_details_base.campaign_status_description %} cd.CAMPAIGN_STATUS_DESCRIPTION  {% endcondition %}
  AND {% condition campaign_details_base.business_region_description %} cd.BUSINESS_REGION_DESCRIPTION  {% endcondition %}
    )
GROUP BY fmd.campaign_id
  ) ct on (dt.campaign_id = ct.campaign_id)
group by
  coalesce(dt.campaign_id, ct.campaign_id)
  ,dt.DOMAIN_URL

      ;;
  }

  dimension: campaign_id {
    label: "Campaign ID"
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: domain_url {
    label: "Domain URL"
    type: string
    sql: ${TABLE}.DOMAIN_URL ;;
  }

  dimension: domain_impressions {
    label: "Domain Impressions"
    type: number
    sql: ${TABLE}.DOMAIN_IMPRESSIONS ;;
  }

  dimension: campaign_impressions {
    label: "Campaign Impressions"
    type: number
    sql: ${TABLE}.CAMPAIGN_IMPRESSIONS ;;
  }

  dimension: domain_impression_rate {
    label: "Domain Impression Rate"
    type: number
    value_format_name: percent_0
    sql: ${TABLE}.DOMAIN_IMPRESSION_RATE ;;
  }

  measure: sum_campaign_impressions {
    type: sum
    label: "Total Campaign Impressions"
    sql: ${campaign_impressions} ;;
  }

  measure: sum_domain_impressions {
    type: sum
    label: "Total Domain Impressions"
    sql: ${domain_impressions} ;;
  }

  measure: impression_rate {
    type: number
    label: "Total Impression Rate"
    value_format_name: percent_0
    sql: COALESCE(${sum_domain_impressions} / NULLIF(${sum_campaign_impressions},0),0);;
  }

}
