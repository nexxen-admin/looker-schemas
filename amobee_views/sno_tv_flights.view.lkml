view: tv_flights {
  derived_table: {
    sql: SELECT
  flight_details.FLIGHT_ID  AS "FLIGHT_ID"
  ,placement_details_base.placement_id AS "PLACEMENT_ID"
  ,flight_details.CONTRACTED_BUDGET  AS "CONTRACTED_BUDGET"
  ,TO_CHAR(DATE_TRUNC('month', day_dimension.DATE_VALUE ), 'YYYY-MM') AS "DATE_VALUE"
  ,YEAR || '-' || MONTH_NUMBER_OF_YEAR as "YEAR_MONTH"
  ,broadcast_year || '-' || broadcast_month as "BROADCAST_DATE"
  ,min_month.MIN_MONTH as "MIN_MONTH"
  ,PAY_SCHEDULE_ID AS "PAY_SCHEDULE_ID"
  ,MAX((datediff('day',(TO_CHAR(TO_DATE(flight_details.BEGIN_DATETIME_LOCAL ), 'YYYY-MM-DD')),(TO_CHAR(TO_DATE(flight_details.END_DATETIME_LOCAL ), 'YYYY-MM-DD')))) ) AS "FLIGHT_TOTAL_DAYS"
  ,(COALESCE(SUM(flight_details.CONTRACTED_BUDGET ), 0)) / NULLIF((COALESCE(SUM((datediff('day',(TO_CHAR(TO_DATE(flight_details.BEGIN_DATETIME_LOCAL ), 'YYYY-MM-DD')),flight_details.END_DATETIME_LOCAL)) ), 0)),0)  AS "DAILY_BUDGET"
  ,COUNT((TO_CHAR(TO_DATE(day_dimension.DATE_VALUE ), 'YYYY-MM-DD'))) AS "live_days"
  ,((COALESCE(SUM(flight_details.CONTRACTED_BUDGET ), 0)) / NULLIF((COALESCE(SUM((datediff('day',(TO_CHAR(TO_DATE(flight_details.BEGIN_DATETIME_LOCAL ), 'YYYY-MM-DD')),flight_details.END_DATETIME_LOCAL)) ), 0)),0)) * (count((TO_CHAR(TO_DATE(day_dimension.DATE_VALUE ), 'YYYY-MM-DD'))))  AS "THROUGHPUT"
  ,SUM(DISTINCT(CAST(COALESCE((request_volume.M_VALUE_ADJUSTED/1000) * placement_details_base.DEFAULT_MIN_CPM ,0) AS DECIMAL(18,7)))) AS "PAYOUT"
  ,CASE
    WHEN TV_ECONOMICS.PAY_SCHEDULE_ID = 1
      THEN CASE
          WHEN broadcast_year || '-' || broadcast_month = min_month.MIN_MONTH
                    AND broadcast_year || '-' || broadcast_month = YEAR || '-' || MONTH_NUMBER_OF_YEAR
                        THEN SUM(DISTINCT (CAST(COALESCE(flight_demand_units_budget.UNITS, 0) AS DECIMAL(18, 7)))) * (
                MAX((
                    CASE
                      WHEN TV_ECONOMICS.ECONOMIC_TYPE_ID = 1
                        THEN TV_ECONOMICS.VALUE
                      ELSE 0
                      END
                    ))
                ) / 1000
          ELSE 0
          END
    WHEN TV_ECONOMICS.PAY_SCHEDULE_ID = 2
      THEN SUM(DISTINCT (CAST(COALESCE(flight_demand_units_budget.UNITS, 0) AS DECIMAL(18, 7)))) * (
          MAX((
              CASE
                WHEN TV_ECONOMICS.ECONOMIC_TYPE_ID = 1
                  THEN TV_ECONOMICS.VALUE
                ELSE 0
                END
              ))
          ) / 1000
    ELSE 0
    END AS "DATA_FEE"
  ,CASE
    WHEN TV_ECONOMICS.PAY_SCHEDULE_ID = 1
      THEN CASE
          WHEN broadcast_year || '-' || broadcast_month = min_month.MIN_MONTH
          AND broadcast_year || '-' || broadcast_month = YEAR || '-' || MONTH_NUMBER_OF_YEAR
            THEN SUM(DISTINCT (CAST(COALESCE(flight_details.CONTRACTED_BUDGET, 0) AS DECIMAL(18, 7)))) * (
                MAX((
                    CASE
                      WHEN TV_ECONOMICS.ECONOMIC_TYPE_ID = 2
                        THEN TV_ECONOMICS.VALUE
                      ELSE 0
                      END
                    ))
                )
          ELSE 0
          END
    WHEN TV_ECONOMICS.PAY_SCHEDULE_ID = 2
      THEN ((COALESCE(SUM(flight_details.CONTRACTED_BUDGET), 0)) / NULLIF((COALESCE(SUM((datediff('day', (TO_CHAR(TO_DATE(flight_details.BEGIN_DATETIME_LOCAL), 'YYYY-MM-DD')), flight_details.END_DATETIME_LOCAL))), 0)), 0)) * (count((TO_CHAR(TO_DATE(day_dimension.DATE_VALUE), 'YYYY-MM-DD')))) * (
          MAX((
              CASE
                WHEN TV_ECONOMICS.ECONOMIC_TYPE_ID = 2
                  THEN tv_economics.VALUE
                ELSE 0
                END
              ))
          )
    ELSE 0
    END AS "TECH_FEE"
  ,CASE WHEN broadcast_year || '-' || broadcast_month = min_month.MIN_MONTH THEN MAX((CASE WHEN tv_economics.ECONOMIC_TYPE_ID = 3 then tv_economics.VALUE ELSE 0 END)) ELSE 0 END AS "LICENSE_FEE"
  ,SUM(DISTINCT(CAST(COALESCE(request_volume.M_VALUE_ADJUSTED ,0) AS DECIMAL(18,7)))) AS "REQUEST_VOLUME"
FROM DIM.FLIGHT_DETAILS  AS flight_details

INNER JOIN DIM.CAMPAIGN_DETAILS AS campaign_details_base ON campaign_details_base.CAMPAIGN_ID = flight_details.CAMPAIGN_ID
AND campaign_active = true
{% if flight_details.flight_id._in_query or campaign_details_base.campaign_id._in_query or campaign_details_base.pl_plan_id._in_query or campaign_details_base.platform_client_description._in_query or campaign_details_base.platform_client_id._in_query or campaign_details_base.campaign_status_description._in_query %} AND {% endif %}
{% if flight_details.flight_id._in_query %} {% condition flight_details.flight_id %} flight_details.flight_id {% endcondition %}{% endif %}
{% if flight_details.flight_id._in_query and (campaign_details_base.campaign_id._in_query or campaign_details_base.pl_plan_id._in_query or campaign_details_base.platform_client_description._in_query or campaign_details_base.platform_client_id._in_query or campaign_details_base.campaign_status_description._in_query) %} AND {% endif %}
{% if campaign_details_base.campaign_id._in_query %}{% condition campaign_details_base.campaign_id %} campaign_details_base.campaign_id {% endcondition %}{% endif %}
{% if campaign_details_base.campaign_id._in_query and (campaign_details_base.pl_plan_id._in_query or campaign_details_base.platform_client_description._in_query or campaign_details_base.platform_client_id._in_query or campaign_details_base.campaign_status_description._in_query) %} AND {% endif %}
{% if campaign_details_base.pl_plan_id._in_query %} {% condition campaign_details_base.pl_plan_id %} campaign_details_base.pl_plan_id {% endcondition %}{% endif %}
{% if campaign_details_base.pl_plan_id._in_query and (campaign_details_base.platform_client_description._in_query or campaign_details_base.platform_client_id._in_query or campaign_details_base.campaign_status_description._in_query) %} AND {% endif %}
{% if campaign_details_base.platform_client_description._in_query %}{% condition campaign_details_base.platform_client_description %} campaign_details_base.platform_client_description {% endcondition %}{% endif %}
{% if campaign_details_base.platform_client_description._in_query and (campaign_details_base.platform_client_id._in_query or campaign_details_base.campaign_status_description._in_query ) %} AND {% endif %}
{% if campaign_details_base.platform_client_id._in_query %}{% condition campaign_details_base.platform_client_id %} campaign_details_base.platform_client_id {% endcondition %}{% endif %}
{% if campaign_details_base.platform_client_id._in_query and campaign_details_base.campaign_status_description._in_query %} AND {% endif %}
{% if campaign_details_base.campaign_status_description._in_query %}{% condition campaign_details_base.campaign_status_description %} campaign_details_base.campaign_status_description {% endcondition %}{% endif %}

INNER JOIN DIM.ADVERTISER_BRAND_DETAILS abd on campaign_details_base.advertiser_brand_id = abd.advertiser_brand_id
AND 1=1
{% if advertiser_brand_details.brand_name._in_query or advertiser_brand_details.advertiser_name._in_query %} AND  {% endif %}
{% if advertiser_brand_details.advertiser_name._in_query %}{% condition advertiser_brand_details.advertiser_name %} abd.advertiser_name {% endcondition %}{% endif %}
{% if advertiser_brand_details.advertiser_name._in_query and advertiser_brand_details.brand_name._in_query %} AND {% endif %}
{% if advertiser_brand_details.brand_name._in_query %}{% condition advertiser_brand_details.brand_name %} abd.brand_name {% endcondition %}{% endif %}

LEFT JOIN PUBLIC.TV_ECONOMICS  AS tv_economics ON campaign_details_base.PLATFORM_CLIENT_ID = tv_economics.PLATFORM_CLIENT_ID
LEFT JOIN DIM.DEMAND_UNITS_BUDGET  AS flight_demand_units_budget ON flight_demand_units_budget.FLIGHT_ID = flight_details.FLIGHT_ID
      and flight_demand_units_budget.FLIGHT_MEDIA_ID IS NULL
LEFT JOIN DIM.DAY_DIMENSION  AS day_dimension ON (TO_CHAR(TO_DATE(day_dimension.DATE_VALUE ), 'YYYY-MM-DD')) >= (TO_CHAR(TO_DATE(flight_details.BEGIN_DATETIME_LOCAL ), 'YYYY-MM-DD')) and (TO_CHAR(TO_DATE(day_dimension.DATE_VALUE ), 'YYYY-MM-DD')) <= (TO_CHAR(TO_DATE(date_trunc('day',dateadd('m',-1,flight_details.END_DATETIME_LOCAL)) ), 'YYYY-MM-DD'))
LEFT JOIN DIM.CAMPAIGN_SITELIST  AS campaign_sitelist ON campaign_details_base.CAMPAIGN_ID = campaign_sitelist.CAMPAIGN_ID
LEFT JOIN DIM.PLACEMENT_DETAILS_BASE  AS placement_details_base ON placement_details_base.PLACEMENT_ID = campaign_sitelist.PLACEMENT_ID
LEFT JOIN (
  SELECT flight_id
    ,broadcast_year || '-' || broadcast_month AS "MIN_MONTH"
  FROM DIM.FLIGHT_DETAILS AS flight_details
  LEFT JOIN DIM.DAY_DIMENSION AS day_dimension ON (TO_CHAR(TO_DATE(day_dimension.DATE_VALUE), 'YYYY-MM-DD')) = (TO_CHAR(TO_DATE(flight_details.BEGIN_DATETIME_LOCAL), 'YYYY-MM-DD'))
  ) AS min_month on min_month.flight_id = flight_details.flight_id
LEFT JOIN DIM.M_OVERRIDE  AS request_volume ON campaign_sitelist.PLACEMENT_ID = request_volume.PLACEMENT_ID
        and request_volume.START_DATETM =
          CASE WHEN request_volume.START_DATETM between '2018-03-12 00:00:00' and '2018-11-04 02:00:00'  then DATEADD(HH,4,flight_details.BEGIN_DATETIME_LOCAL)
          ELSE DATEADD(HH,5,flight_details.BEGIN_DATETIME_LOCAL) END
        and request_volume.END_DATETM =
          CASE WHEN request_volume.END_DATETM between '2018-03-12 00:00:00' and '2018-11-04 02:00:00' then DATEADD(HH,4,flight_details.END_DATETIME_LOCAL)
          ELSE DATEADD(HH,5,flight_details.END_DATETIME_LOCAL) END
GROUP BY 1,2,3,4,5,6,7,8;;

    }

    dimension: flight_id {
      type: number
      hidden: yes
      primary_key: yes
      sql: ${TABLE}.FLIGHT_ID ;;
    }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PLACEMENT_ID ;;
  }

    dimension: CONTRACTED_BUDGET {
      type: number
      hidden: yes
      sql: ${TABLE}.CONTRACTED_BUDGET ;;
    }

     dimension: DATE_VALUE {
      type: string
      label: "Calendar Month"
      view_label: "TV Facets and Metrics"
      sql: ${TABLE}.DATE_VALUE ;;
    }

     dimension: BROADCAST_DATE {
      type: string
      label: "Broadcast Month"
      view_label: "TV Facets and Metrics"
      sql: ${TABLE}.BROADCAST_DATE ;;
    }

    dimension: FLIGHT_TOTAL_DAYS {
      type: number
      hidden: yes
      sql: ${TABLE}.FLIGHT_TOTAL_DAYS ;;
    }

   dimension: DAILY_BUDGET {
      type: number
      hidden: yes
      sql: ${TABLE}.DAILY_BUDGET ;;
  }

    dimension: THROUGHPUT {
      type: number
      hidden: yes
      sql: ${TABLE}.THROUGHPUT ;;
  }

  dimension: REQUEST_VOLUME {
    type: number
    hidden: yes
    sql: ${TABLE}.REQUEST_VOLUME ;;
  }

  dimension: PAYOUT {
    type: number
    hidden: yes
    sql: ${TABLE}.PAYOUT ;;
  }

  dimension: DATA_FEE {
    type: number
     hidden: yes
    sql: ${TABLE}.DATA_FEE ;;
  }

  dimension: TECH_FEE {
    type: number
    hidden: yes
    sql: ${TABLE}.TECH_FEE ;;
  }

  dimension: LICENSE_FEE {
    type: number
    hidden: yes
    sql: ${TABLE}.LICENSE_FEE ;;
  }

  measure: sum_throughput {
    type: sum
    hidden: no
    label: "Throughput"
    view_label: "TV Facets and Metrics"
    value_format_name: decimal_2
    sql:CASE WHEN ${tv_economics.rev_flag} != 1 THEN ${THROUGHPUT} ELSE 0 END ;;
  }

  measure: sum_net_spend{
    type: sum
    hidden: no
    label: "Net Spend"
    view_label: "TV Facets and Metrics"
    value_format_name: decimal_2
    sql: CASE WHEN ${tv_economics.rev_flag} = 1 THEN ${THROUGHPUT} ELSE 0 END;;
  }

  measure: sum_payout {
    type: sum
    label: "Payout"
    view_label: "TV Facets and Metrics"
    value_format_name: decimal_2
    sql: ${PAYOUT} ;;
  }

  measure: sum_request_volume {
    type: sum
    label: "Supply Volume"
    view_label: "TV Facets and Metrics"
    value_format_name: decimal_0
    sql: ${REQUEST_VOLUME} ;;
  }

  measure: sum_data_fee {
    type: sum
    hidden: no
    label: "Data Fee"
    view_label: "TV Facets and Metrics"
    value_format_name: decimal_2
    sql: ${DATA_FEE} ;;
  }

  measure: sum_tech_fee {
    type: sum
    hidden: no
    label: "Tech Fee"
    view_label: "TV Facets and Metrics"
    value_format_name: decimal_2
    sql: ${TECH_FEE} ;;
  }

  measure: sum_license_fee {
    type: sum
    hidden: no
    label: "License Fee"
    view_label: "TV Facets and Metrics"
    value_format_name: decimal_2
    sql: ${LICENSE_FEE} ;;
  }

}
