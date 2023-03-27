view: opt_total_ccp {
  #view: opt_inventory_assignment  {
  label: "Total CCP"

  derived_table: {
    sql:
     SELECT keydate,
       dst_keydate,
       pc.platform_client_id as platform_client_id,
       cs.description AS campaign_status,
       cp.description AS cpu_type,
       ind.industry_segment_id AS industry_segment_id,
       ind.[description] AS industry_segment,
       c.isfiller as isfiller,
       c.is_test_campaign as is_test_campaign,
       pc.[description] as platform_client_description,
       pc.office_id as platform_client_office_id,
       bu.[description] as reporting_business_unit_description,
       Sum(ccp)       AS total_ccp,
       Sum(icp)       AS total_icp
FROM   an_main..flight f (nolock)
       JOIN an_main..campaign c (nolock)
         ON c.campaign_id = f.campaign_id
       LEFT JOIN an_main..customer c2 (nolock)
         ON c.customer_id = c2.customer_id
       JOIN an_main..advertiser_brand ab (nolock)
         ON c.advertiser_brand_id = ab.advertiser_brand_id
       JOIN an_main..advertiser a (nolock)
         ON a.advertiser_id = ab.advertiser_id
      JOIN an_main..industry_segment ind (nolock)
         ON ind.industry_segment_id = ab.industry_segment_id
      JOIN an_main..pl_plan p (nolock)
         ON p.pl_plan_id = c.pl_plan_id
      JOIN an_main..cpu_type cp (nolock)
         ON cp.cpu_type_id = c.cpu_type_id
      JOIN an_main..campaign_status cs (nolock)
         ON cs.campaign_status_id = c.campaign_status_id
      JOIN an_main..platform_client pc (nolock)
         ON pc.platform_client_id = c.platform_client_id
      JOIN (SELECT h.flight_id,
                    CONVERT(DATE, keydate)              AS keydate,
                    CASE WHEN pcp.preference_value = 'True' THEN CONVERT(DATE, DATEADD(hh, ts.utc_offset, keydate)) ELSE CONVERT(DATE, keydate) END  AS dst_keydate,
                    CASE WHEN pcp.preference_value = 'True' THEN ts.utc_offset ELSE t.utc_offset END AS utc_offset,
                    Sum(hourly_ccp_eoc_audit)           AS ccp,
                    Sum(hourly_icp)                     AS icp
             FROM   opt_rpt..hourly_ccp_metrics (nolock) h
             JOIN an_main..flight (nolock) f
                ON h.flight_id = f.flight_id
             JOIN an_main..campaign (nolock) c
                ON f.campaign_id = c.campaign_id
             JOIN an_main..timezone (nolock) t
                ON c.timezone_id = t.timezone_id
             JOIN an_main..timezone_offset (nolock) ts
                ON t.timezone_id = ts.timezone_id
                  AND keydate >= ts.time_range_start_date
                  AND keydate < ts.time_range_end_date
             LEFT JOIN an_main..platform_client_preference (nolock) pcp
                ON c.platform_client_id = pcp.platform_client_id
                  AND pcp.active = 1
                  AND pcp.preference_key = 'UseDaylightSaving'
             WHERE {% if dst_date_filter._in_query %} CASE WHEN pcp.preference_value = 'True' THEN CONVERT(DATE, DATEADD(hh, ts.utc_offset, keydate)) ELSE CONVERT(DATE, DATEADD(hh, t.utc_offset, keydate)) END >= CONVERT(DATE, {% date_start dst_date_filter %})
             AND CASE WHEN pcp.preference_value = 'True' THEN CONVERT(DATE, DATEADD(hh, ts.utc_offset, keydate)) ELSE CONVERT(DATE, keydate) END < DATEADD(MONTH,1, CONVERT(DATE, {% date_start dst_date_filter %})) {% else %} keydate >= CONVERT(DATE, {% date_start date_filter %})
             AND keydate < DATEADD(MONTH,1, CONVERT(DATE, {% date_start date_filter %})) {% endif %}
             GROUP  BY h.flight_id,
                       CONVERT(DATE, keydate),
                       CASE WHEN pcp.preference_value = 'True' THEN CONVERT(DATE, DATEADD(hh, ts.utc_offset, keydate)) ELSE CONVERT(DATE, keydate) END,
                       CASE WHEN pcp.preference_value = 'True' THEN ts.utc_offset ELSE t.utc_offset END) v
         ON v.flight_id = f.flight_id
      LEFT JOIN an_main..reporting_business_unit bu
         ON coalesce(c.reporting_business_unit_id, pc.default_reporting_business_unit_id) = bu.reporting_business_unit_id
WHERE      {% condition platform_client_id %}pc.platform_client_id {% endcondition %}
       AND {% condition country_id %}c2.country_id{% endcondition %}
       AND  c.active = 1
       AND f.active = 1
       AND c.isfiller = 0
       AND CASE
             WHEN f.override_campaign_units = 1 THEN f.units
             ELSE c.units
           END > 0
          AND {% if dst_date_filter._in_query %} DATEADD(hh, v.utc_offset, f.end_datetm) > CONVERT(DATE, {% date_start dst_date_filter %}) {% else %} f.end_datetm > CONVERT(DATE, {% date_start date_filter %}) {% endif %}
          AND {% if dst_date_filter._in_query %} DATEADD(hh, v.utc_offset, f.begin_datetm) < DATEADD(MONTH,1, CONVERT(DATE, {% date_start dst_date_filter %})) {% else %} f.begin_datetm < DATEADD(MONTH,1, CONVERT(DATE, {% date_start date_filter %})) {% endif %}
GROUP  BY keydate,
          dst_keydate,
          pc.platform_client_id,
          cs.description,
          cp.description,
          ind.industry_segment_id,
          ind.[description],
          c.isfiller,
          c.is_test_campaign,
          pc.[description],
          pc.office_id,
          bu.[description]

    ;;
  }

  filter: date_filter {
    label: "Month Filter"
    type: date
  }

  filter: dst_date_filter {
    label: "[DST] Local Month Filter"
    type: date
  }

  filter: country_id {
    type: number
    hidden: yes
  }

  dimension: key_date {
    description: "Key Date"
    type: date
    sql: ${TABLE}.keydate ;;
  }

  dimension: dst_key_date {
    label: "[DST] Key Date"
    type: date
    sql: ${TABLE}.dst_keydate ;;
  }

  dimension: campaign_status {
    description: "Campaign Status"
    type: string
    sql: ${TABLE}.campaign_status ;;
  }

  dimension: industry_segment_id {
    description: "Industry Segment ID"
    type: number
    sql: ${TABLE}.industry_segment_id ;;
    value_format_name: id
  }

  dimension: industry_segment {
    description: "Industry Segment"
    type: string
    sql: ${TABLE}.industry_segment ;;
  }

  dimension: platform_client_id {
    description: "Platform Client ID"
    type: number
    sql: ${TABLE}.PLATFORM_CLIENT_ID ;;
    value_format_name: id
  }

  dimension: cpu_type {
    description: "CPU Type"
    type: string
    sql: ${TABLE}.cpu_type ;;
  }

  dimension: total_ccp {
    description: "Total CCP"
    type: number
    hidden:  yes
    value_format_name: decimal_0
    sql: ${TABLE}.total_ccp ;;
  }

  dimension: platform_client_description {
    type: string
    label: "Platform Client"
    description: "The name of the Platform Client"
    sql: ${TABLE}.PLATFORM_CLIENT_DESCRIPTION ;;
  }

  dimension: platform_client_office_id {
    type: number
    hidden: yes
    sql: ${TABLE}.platform_client_office_id ;;
  }

  dimension: reporting_business_unit_description {
    type: string
    label: "Reporting Business Unit"
    description: "A grouping of platform clients derived for and used in reporting."
    sql: ${TABLE}.REPORTING_BUSINESS_UNIT_DESCRIPTION ;;
  }

  dimension: isfiller {
    type: yesno
    label: "House"
    description: "A yes/no indicator if the campaign is a house/filler campaign."
    sql: ${TABLE}.ISFILLER = 1 ;;
  }

  dimension: is_test_campaign {
    type: yesno
    label: "Test Campaign"
    description: "A yes/no indicator if the campaign is a test campaign."
    sql: ${TABLE}.IS_TEST_CAMPAIGN = 1 ;;
  }

  measure: sum_total_ccp {
    type: sum
    label: "Total CCP"
    description: "The number of units to deliver to ensure complete delivery by the end of the campaign. Takes into account campaign volume higher than 0, flights aren't ended within 24 hours, dCPM campaigns don't count."
    value_format_name: decimal_0
    sql: ${total_ccp} ;;
  }

  dimension: total_icp {
    description: "Total ICP"
    type: number
    value_format_name: decimal_0
    sql: ${TABLE}.total_icp ;;
  }

 }
