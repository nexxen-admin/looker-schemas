view: daily_core_stats_yesterday {

  derived_table: {
    sql:
    SELECT dcs.flight_media_id
      {% if placement_details_base._in_query %} ,dcs.placement_id {% endif %}
      ,sum(dcs.autoplay) as autoplay
      ,coalesce(sum((case when cd.cpu_type_id in (4,5) then dcs.demand_revenue else dcs.billable_units end) ), 0) as billable_units
      ,sum(dcs.clicks) as clicks
      ,sum(dcs.click_impressions) as click_impressions
      ,sum(dcs.demand_payout) as demand_payout
      ,sum(dcs.demand_revenue) as demand_revenue
      ,sum(dcs.effective_impressions) as effective_impressions
      ,sum(dcs.effective_units) as effective_units
      ,sum(dcs.impressions) as impressions
      ,sum(dcs.billable_impressions) as billable_impressions
      ,sum(dcs.media_price) as media_price
      ,sum(dcs.payout) as payout
      ,sum(dcs.completed_100) as completed_100
      ,sum(dcs.completed_75) as completed_75
      ,sum(dcs.completed_50) as completed_50
      ,sum(dcs.completed_25) as completed_25
      ,sum(dcs.completed_pct_impressions) as completed_pct_impressions
      ,sum(dcs.completion_pct_impressions) as completion_pct_impressions
      ,sum(dcs.units) as units
    FROM DEMAND_MART.DAILY_CORE_STATS_EXTENDED dcs
    JOIN dim.flight_media_details_base fmd on fmd.flight_media_id = dcs.flight_media_id
    JOIN dim.campaign_details_base cd on fmd.campaign_id = cd.campaign_id
    JOIN dim.advertiser_brand_details abd on cd.advertiser_brand_id = abd.advertiser_brand_id
    {% if placement_details_base._in_query %} JOIN dim.placement_details_base pd on dcs.placement_id = pd.placement_id {% endif %}
    JOIN dim.customer_details cud on cd.customer_id = cud.customer_id
    JOIN (
  SELECT dd.date_value
    ,sub.start_timezone
  FROM dim.day_dimension dd
  JOIN (
    SELECT max(load_through_date) AS yesterday
      ,start_timezone
    FROM demand_mart.load_tracking
    WHERE schema_name = 'demand_mart'
      AND table_name = 'daily_core_stats'
    GROUP BY start_timezone
    ) sub ON sub.yesterday = dd.date_value
  ) sub2 ON dcs.demand_date = sub2.date_value
  AND fmd.starttimezone_id = sub2.start_timezone
WHERE 1=1

  {% if flight_media_details_base.flight_media_id._in_query
or flight_details.flight_id._in_query
or campaign_details_base.campaign_id._in_query
or campaign_details_base.pl_plan_id._in_query
or advertiser_brand_details.advertiser_name._in_query
or advertiser_brand_details.brand_name._in_query
or customer_details.customer_name._in_query
or campaign_details_base.platform_client_description._in_query %} AND
  {% endif %}

    {% if flight_media_details_base.flight_media_id._in_query %}
        {% condition flight_media_details_base.flight_media_id %} fmd.flight_media_id {% endcondition %}
    {% endif %}

  {% if flight_media_details_base.flight_media_id._in_query and
(flight_details.flight_id._in_query
or campaign_details_base.campaign_id._in_query
or campaign_details_base.pl_plan_id._in_query
or advertiser_brand_details.advertiser_name._in_query
or advertiser_brand_details.brand_name._in_query
or customer_details.customer_name._in_query
or campaign_details_base.platform_client_description._in_query) %} AND
  {% endif %}

    {% if flight_details.flight_id._in_query %}
        {% condition flight_details.flight_id %} fmd.flight_id {% endcondition %}
    {% endif %}

  {% if flight_details.flight_id._in_query and
(campaign_details_base.campaign_id._in_query
or campaign_details_base.pl_plan_id._in_query
or advertiser_brand_details.advertiser_name._in_query
or advertiser_brand_details.brand_name._in_query
or customer_details.customer_name._in_query
or campaign_details_base.platform_client_description._in_query) %} AND
  {% endif %}

    {% if campaign_details_base.campaign_id._in_query %}
        {% condition campaign_details_base.campaign_id %} fmd.campaign_id {% endcondition %}
    {% endif %}

  {% if campaign_details_base.campaign_id._in_query and
(campaign_details_base.pl_plan_id._in_query
or advertiser_brand_details.advertiser_name._in_query
or advertiser_brand_details.brand_name._in_query
or customer_details.customer_name._in_query
or campaign_details_base.platform_client_description._in_query) %} AND
  {% endif %}

    {% if campaign_details_base.pl_plan_id._in_query %}
        {% condition campaign_details_base.pl_plan_id %} cd.pl_plan_id {% endcondition %}
    {% endif %}

  {% if campaign_details_base.pl_plan_id._in_query and
(advertiser_brand_details.advertiser_name._in_query
or advertiser_brand_details.brand_name._in_query
or customer_details.customer_name._in_query
or campaign_details_base.platform_client_description._in_query) %} AND
  {% endif %}

    {% if advertiser_brand_details.advertiser_name._in_query %}
        {% condition advertiser_brand_details.advertiser_name %} abd.advertiser_name {% endcondition %}
    {% endif %}

  {% if advertiser_brand_details.advertiser_name._in_query and
(advertiser_brand_details.brand_name._in_query
or customer_details.customer_name._in_query
or campaign_details_base.platform_client_description._in_query) %} AND
  {% endif %}

    {% if advertiser_brand_details.brand_name._in_query %}
        {% condition advertiser_brand_details.brand_name %} abd.brand_name {% endcondition %}
    {% endif %}

  {% if advertiser_brand_details.brand_name._in_query and
(customer_details.customer_name._in_query
or campaign_details_base.platform_client_description._in_query) %} AND
  {% endif %}

    {% if customer_details.customer_name._in_query %}
        {% condition customer_details.customer_name %} cud.customer_name {% endcondition %}
    {% endif %}

  {% if customer_details.customer_name._in_query and
(campaign_details_base.platform_client_description._in_query) %} AND
  {% endif %}

    {% if campaign_details_base.platform_client_description._in_query %}
      {% condition campaign_details_base.platform_client_description %} cd.platform_client_description {% endcondition %}
    {% endif %}

GROUP BY
    dcs.flight_media_id
    {% if placement_details_base._in_query %} ,dcs.placement_id {% endif %} ;;
  }

  dimension: flight_media_id {
    type: string
    label: "Flight Media ID - Yesterday Table"
    hidden: yes
    sql: ${TABLE}.flight_media_id ;;
  }

  dimension: placement_id {
    type: string
    label: "Placement ID"
    hidden: yes
    sql: ${TABLE}.placement_id ;;
  }

  dimension: primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${flight_media_id} {% if placement_details_base._in_query %} || ${placement_id} {% endif %} ;;
  }

  dimension: autoplay_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.autoplay ;;
  }

  measure: sum_autoplay_yesterday {
    type: sum
    label: "Autoplay - Yesterday"
    description: "Autoplay impressions from the prior Demand Date"
    view_label: "Yesterday Impression Metrics"
    value_format_name: decimal_2
    sql: ${autoplay_yesterday} ;;
  }

  dimension: billable_units_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.billable_units ;;
  }

  measure: sum_billable_units_yesterday {
    type: sum
    label: "Billable Units - Yesterday"
    value_format_name: decimal_0
    description: "Total Billable Units from the prior Demand Date."
    view_label: "Yesterday Impression Metrics"
    sql: ${billable_units_yesterday} ;;
  }

  dimension: billable_impressions_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.billable_impressions ;;
  }

  measure: sum_billable_impressions_yesterday {
    type: sum
    label: "Billable Impressions - Yesterday"
    description: "Billable Impressions from the prior Demand Date"
    view_label: "Yesterday Impression Metrics"
    value_format_name: decimal_0
    sql: ${billable_impressions_yesterday} ;;
  }

  dimension: click_impressions_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.click_impressions ;;
  }

  measure: sum_click_impressions_yesterday {
    type: sum
    label: "Click Impressions - Yesterday"
    description: "Click Impressions from the prior Demand Date."
    view_label: "Yesterday Impression Metrics"
    value_format_name: decimal_0
    sql: ${click_impressions_yesterday} ;;
  }

  dimension: clicks_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.clicks ;;
  }

  measure: sum_clicks_yesterday {
    type: sum
    label: "Clicks - Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "Clicks from the prior Demand Date."
    value_format_name: decimal_0
    sql: ${clicks_yesterday} ;;
  }

  dimension: demand_payout_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.demand_payout ;;
  }

  measure: sum_demand_payout_yesterday {
    type: sum
    label: "Media Cost - Demand - Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "Total Media Cost in Demand Currency from the prior Demand Date."
    value_format_name: decimal_2
    sql: ${demand_payout_yesterday} ;;
  }

  dimension: demand_revenue_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.demand_revenue ;;
  }

  measure: sum_demand_revenue_yesterday {
    type: sum
    label: "Net Spend - Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "Net Spend in Demand currency from the prior Demand Date."
    value_format_name: decimal_2
    sql: ${demand_revenue_yesterday} ;;
  }

  measure: gross_spend_yesterday {
    type:  sum
    label: "Gross Spend - Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "Total Gross Spend converted to Demand Currency from the prior Demand Date."
    value_format_name: decimal_2
    sql: ${demand_revenue_yesterday} * (1+(${flight_media_details_base.agency_fee}));;
  }

  dimension: effective_impressions_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.effective_impressions ;;
  }

  measure: sum_effective_impressions_yesterday {
    type: sum
    label: "Effective Impression - Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "The total of all impression which were in target from the prior Demand Date."
    value_format_name: decimal_0
    sql: ${effective_impressions_yesterday} ;;
  }

  dimension: effective_units_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.effective_units ;;
  }

  measure: sum_effective_units_yesterday {
    type: sum
    label: "Effective Units - Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "The total of all units which were in target from the prior Demand Date."
    value_format_name: decimal_0
    sql: ${effective_units_yesterday} ;;
  }

  dimension: impressions_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.impressions ;;
  }

  measure: sum_impressions_yesterday {
    type: sum
    label: "Impressions - Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "The total impressions from the prior Demand Date."
    value_format_name: decimal_0
    sql: ${impressions_yesterday} ;;
  }

  dimension: media_price_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.media_price ;;
  }

  measure: sum_media_price_yesterday {
    type: sum
    label: "Media Price - Yesterday"
    view_label: "Yesterday Impression Metrics"
    value_format_name: decimal_2
    description: "The total price of media from the prior Demand Date."
    sql: ${media_price_yesterday} ;;
  }

  dimension: payout_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.payout ;;
  }

  measure: sum_payout_yesterday {
    type: sum
    label: "Gross Payout - Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "The total amount due to the Publisher for the media in the Publisher's (supply) currency from the prior Demand Date."
    value_format_name: decimal_2
    sql: ${payout_yesterday} ;;
  }

  dimension: units_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.units ;;
  }

  measure: sum_units_yesterday {
    type: sum
    label: "Units - Yesterday"
    view_label: "Yesterday Impression Metrics"
    value_format_name: decimal_0
    description: "The number of units served from the prior Demand Date. This is based on the revenue type of the campaign to determine units."
    sql: ${units_yesterday} ;;
  }

  dimension: completed_100_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.completed_100 ;;
  }

  measure: sum_completed_100_yesterday {
    type: sum
    label: "Completed 100 - Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "The total of all impression which were 100% completed from the prior Demand Date."
    value_format_name: decimal_0
    sql: ${completed_100_yesterday} ;;
  }

  dimension: completed_75_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.completed_75 ;;
  }

  measure: sum_completed_75_yesterday {
    type: sum
    label: "Completed 75 - Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "The total of all impression which were 75% completed from the prior Demand Date."
    value_format_name: decimal_0
    sql: ${completed_75_yesterday} + ${completed_100_yesterday} ;;
  }

  measure: abs_completed_75_yesterday {
    type: sum
    description: "The sum of completed 75 used in calculating VCR."
    hidden: yes
    value_format_name: decimal_0
    sql: ${completed_75_yesterday} ;;
  }

  dimension: completed_50_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.completed_50 ;;
  }

  measure: sum_completed_50_yesterday {
    type: sum
    label: "Completed 50 - Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "The total of all impression which were 50% completed from the prior Demand Date."
    value_format_name: decimal_0
    sql: ${completed_50_yesterday} + ${completed_75_yesterday} + ${completed_100_yesterday};;
  }

  measure: abs_completed_50_yesterday {
    type: sum
    description: "The sum of completed 50 used in calculating VCR."
    hidden: yes
    value_format_name: decimal_0
    sql: ${completed_50_yesterday} ;;
  }

  dimension: completed_25_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.completed_25 ;;
  }

  measure: sum_completed_25_yesterday {
    type: sum
    label: "Completed 25 - Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "The total of all impression which were 25% completed from the prior Demand Date."
    value_format_name: decimal_0
    sql: ${completed_25_yesterday} + ${completed_50_yesterday} + ${completed_75_yesterday} + ${completed_100_yesterday};;
  }

  measure: abs_completed_25_yesterday {
    type: sum
    description: "The sum of completed 25 used in calculating VCR."
    hidden: yes
    value_format_name: decimal_0
    sql: ${completed_25_yesterday} ;;
  }

  dimension: completed_pct_impressions_yesterday {
    type: number
    label: "Completed Percent Impressions - Yesterday"
    hidden: yes
    sql: ${TABLE}.completed_pct_impressions ;;
  }

  measure: sum_completed_pct_impressions_yesterday {
    type: sum
    label: "Completed Percent Impressions - Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "The total number of impression where completed (completed 100) is measured from the prior Demand Date."
    value_format_name: decimal_0
    sql: ${completed_pct_impressions_yesterday} ;;
  }

  dimension: completion_pct_impressions_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.completion_pct_impressions ;;
  }

  measure: sum_completion_pct_impressions_yesterday {
    type: sum
    label: "Completion Percent Impressions - Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "The total of impressions where completion percentage is measured from the prior Demand Date. This is used in calculating the various completion percentages, and VCR"
    value_format_name: decimal_0
    sql: ${completion_pct_impressions_yesterday} ;;
  }

  measure: VTR_yesterday {
    type: number
    label: "VTR - Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "Video Through Rate from the prior Demand Date - the percentage of all impression which were 100% completed."
    value_format_name: percent_2
    sql: COALESCE(1.0 * ${sum_completed_100_yesterday} / nullif(${sum_completed_pct_impressions_yesterday},0),0) ;;
  }

  measure: VCR_yesterday {
    type: number
    label: "VCR - Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "Video Completed Rate - The avarage completion rate of the impression."
    value_format_name: percent_2
    sql: COALESCE(((${abs_completed_25_yesterday}*.25) + (${abs_completed_50_yesterday} *.50) + (${abs_completed_75_yesterday} *.75)
      + (${sum_completed_100_yesterday} *1.0)) / nullif(${sum_completion_pct_impressions_yesterday},0),0) ;;
  }


  measure: ctr_yesterday {
    type: number
    label: "CTR Yesterday"
    view_label: "Yesterday Impression Metrics"
    description: "Click Thru Rate - The number of clicks / the number of click impressions"
    value_format_name: percent_2
    sql: COALESCE(1.0 * ${sum_clicks_yesterday}/NULLIF(${sum_click_impressions_yesterday},0),0);;
  }

  measure: inventory_contribution_yesterday {
    type:  number
    label: "I/C Yesterday"
    description: "Difference between revenue and media cost"
    view_label: "Yesterday Impression Metrics"
    value_format_name: decimal_0
    sql: ${gross_spend_yesterday}-${sum_payout_yesterday} ;;
  }

  measure: margin_yesterday {
    type: number
    label: "Margin Yesterday"
    description: "Percentage diffence between spend and payout for yesterday."
    view_label: "Yesterday Impression Metrics"
    value_format_name: percent_2
    sql: COALESCE(1 - (${sum_payout_yesterday}*1.0 / nullif(${gross_spend_yesterday},0)), 0) ;;
  }

  measure: dod_impressions {
    type: number
    label: "D/D Impressions"
    description: "Difference between Total Impressions from yesterday and two days ago."
    view_label: "Yesterday Impression Metrics"
    value_format_name: decimal_0
    sql: COALESCE(1.0 * ${sum_impressions_yesterday}-${daily_core_stats.sum_impressions_2_days_ago},0) ;;
  }

  measure: client_spend_yesterday {
    type: sum
    label: "Client Spend - Yesterday"
    view_label: "Yesterday Impression Metrics"
    value_format_name: decimal_2
    description: "Total Client spend converted to Gross Spend Currency from the prior Demand Date."
    sql:${demand_revenue_yesterday} * (1 + ${flight_media_details_base.agency_fee}) * (1- ${campaign_details_base.spend_discount});;
  }
}
