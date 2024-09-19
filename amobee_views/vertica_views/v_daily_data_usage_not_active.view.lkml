view: v_daily_data_usage_not_active {
  derived_table: {
    sql: WITH active AS (
SELECT
    v_retargeting_attribute.PROVIDER_NAME  AS "provider_name",
    v_retargeting_attribute.DESCRIPTION  AS "retargeting_attribute",
    (CASE WHEN v_retargeting_attribute.RETARGETING_ATTRIBUTE_ACTIVE  THEN 'Yes' ELSE 'No' END) AS "is_active",
    (DATE(max(v_daily_data_usage.GMT_DATE) )) AS "max_gmt_date",
      COALESCE(SUM(v_daily_data_usage.IMPRESSIONS ), 0) AS "usage"
FROM RAWDB.DAILY_DATA_USAGE  AS v_daily_data_usage
LEFT JOIN DIM.FLIGHT_MEDIA_DETAILS_BASE_VIEW  AS v_flight_media_details_base ON v_flight_media_details_base.FLIGHT_MEDIA_ID = v_daily_data_usage.FLIGHT_MEDIA_ID
LEFT JOIN DIM.FLIGHT_DETAILS_VIEW  AS v_flight_details ON v_flight_media_details_base.FLIGHT_ID = v_flight_details.FLIGHT_ID
LEFT JOIN DIM.CAMPAIGN_DETAILS_BASE_VIEW AS v_campaign_details_base ON v_flight_details.CAMPAIGN_ID = v_campaign_details_base.CAMPAIGN_ID
LEFT JOIN DIM.ADVERTISER_BRAND_DETAILS_VIEW  AS v_advertiser_brand_details ON v_campaign_details_base.ADVERTISER_BRAND_ID = v_advertiser_brand_details.ADVERTISER_BRAND_ID
LEFT JOIN DIM.RETARGETING_ATTRIBUTE_DETAILS_VIEW  AS v_retargeting_attribute ON v_daily_data_usage.COST_ATTRIBUTE_ID = v_retargeting_attribute.RETARGETING_ATTRIBUTE_ID
WHERE ((( v_daily_data_usage.DEMAND_DATE  ) >= (((DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC') + (-({% parameter number_of_days %}-1) || ' day')::INTERVAL))) AND ( v_daily_data_usage.DEMAND_DATE  ) < ((((DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC') + (-({% parameter number_of_days %}-1) || ' day')::INTERVAL) + ({% parameter number_of_days %} || ' day')::INTERVAL))))) AND ((COALESCE(v_daily_data_usage.DEMAND_DATE, '9999-12-31') >= (SELECT MIN(DEMAND_DATE) FROM RAWDB.daily_data_usage)))
GROUP BY 1, 2, 3
),
all_at AS (
SELECT
    v_retargeting_attribute.PROVIDER_NAME  AS "provider_name",
    v_retargeting_attribute.DESCRIPTION  AS "retargeting_attribute",
    (CASE WHEN v_retargeting_attribute.RETARGETING_ATTRIBUTE_ACTIVE  THEN 'Yes' ELSE 'No' END) AS "is_active",
        (DATE(max(v_daily_data_usage.GMT_DATE) )) AS "max_gmt_date"
FROM RAWDB.DAILY_DATA_USAGE  AS v_daily_data_usage
LEFT JOIN DIM.FLIGHT_MEDIA_DETAILS_BASE_VIEW  AS v_flight_media_details_base ON v_flight_media_details_base.FLIGHT_MEDIA_ID = v_daily_data_usage.FLIGHT_MEDIA_ID
LEFT JOIN DIM.FLIGHT_DETAILS_VIEW  AS v_flight_details ON v_flight_media_details_base.FLIGHT_ID = v_flight_details.FLIGHT_ID
LEFT JOIN DIM.CAMPAIGN_DETAILS_BASE_VIEW AS v_campaign_details_base ON v_flight_details.CAMPAIGN_ID = v_campaign_details_base.CAMPAIGN_ID
LEFT JOIN DIM.ADVERTISER_BRAND_DETAILS_VIEW  AS v_advertiser_brand_details ON v_campaign_details_base.ADVERTISER_BRAND_ID = v_advertiser_brand_details.ADVERTISER_BRAND_ID
LEFT JOIN DIM.PLACEMENT_DETAILS_BASE_VIEW  AS v_placement_details_base ON v_placement_details_base.PLACEMENT_ID = v_daily_data_usage.PLACEMENT_ID
LEFT JOIN DIM.RETARGETING_ATTRIBUTE_DETAILS_VIEW  AS v_retargeting_attribute ON v_daily_data_usage.COST_ATTRIBUTE_ID = v_retargeting_attribute.RETARGETING_ATTRIBUTE_ID
LEFT JOIN DIM.PLATFORM_CLIENT_VIEW  AS v_platform_client ON v_platform_client.PLATFORM_CLIENT_ID = v_campaign_details_base.PLATFORM_CLIENT_ID
LEFT JOIN DIM.PLATFORM_CLIENT_VIEW  AS v_supply_platform_client ON v_placement_details_base.PLATFORM_CLIENT_ID = v_supply_platform_client.PLATFORM_CLIENT_ID
GROUP BY 1, 2, 3
)
SELECT all_at.provider_name, all_at.retargeting_attribute, all_at.is_active, all_at.max_gmt_date, COALESCE(active.usage, 0) as "usage"
FROM all_at LEFT JOIN active ON ISNULL(all_at.provider_name, 'NA')=ISNULL(active.provider_name, 'NA') AND all_at.retargeting_attribute=active.retargeting_attribute
WHERE active.provider_name IS NULL AND active.retargeting_attribute IS NULL
UNION
SELECT *
FROM active ;;
  }
label: "Vertica Data Usage - Not Active Attributes"

  parameter: number_of_days{
    type: number
    label: "Number of Days since last usage"
  }

dimension: provider_name  {
  type: string
  sql: ${TABLE}.provider_name ;;
}

dimension: retargeting_attribute {
  type: string
  sql: ${TABLE}.retargeting_attribute ;;
}

dimension: last_date {
  type: date
  label: "Last Active Day"
  sql: ${TABLE}.max_gmt_date ;;
}

dimension: is_active {
  type: string
  label: "Is Attribute Active"
  sql: ${TABLE}.is_active ;;
}

measure: usage  {
  type: sum
  sql: ${TABLE}.usage ;;
}
}
