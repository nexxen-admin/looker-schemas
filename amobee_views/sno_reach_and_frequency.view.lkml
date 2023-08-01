view: reach_and_frequency {
  derived_table: {
       sql: SELECT
              A.pk_id,
              A.flight_media_id,
              A.placement_id,
              A.demand_date,
              A.impressions as fm_impressions
              ,CAST(COALESCE(CAST(B.sample_imps AS FLOAT) / CAST(NULLIF(B.count_users, 0) AS FLOAT), 0) AS DECIMAL(18, 7)) as fm_average_freq
              ,A.impressions * CAST(COALESCE(CAST(B.sample_imps AS FLOAT) / CAST(NULLIF(B.count_users, 0) AS FLOAT), 0) AS DECIMAL(18, 7)) AS weighted_fm_imps
            FROM
            (
             SELECT
                DCS.flight_media_id,
                DCS.PLACEMENT_ID,
                DCS.DEMAND_DATE,
                max(DCS.PK_ID) as pk_id,
                sum(DCS.impressions) impressions
            FROM DEMAND_MART.DAILY_CORE_STATS_VIEW DCS
              JOIN DIM.FLIGHT_MEDIA_DETAILS FMD on DCS.flight_media_id = FMD.flight_media_id
            {% if campaign_details_base._in_query %} JOIN DIM.CAMPAIGN_DETAILS_BASE CD on FMD.campaign_id = CD.campaign_id {% endif %}
            {% if advertiser_brand_details._in_query %} JOIN DIM.ADVERTISER_BRAND_DETAILS ABD on CD.advertiser_brand_id = ABD.advertiser_brand_id {% endif %}
            WHERE {% condition daily_core_stats.demand_date %} DCS.DEMAND_DATE {% endcondition %} AND
              {% condition campaign_details_base.campaign_id %} FMD.CAMPAIGN_ID {% endcondition %} AND
              {% condition campaign_details_base.campaign_name %} CD.CAMPAIGN_NAME {% endcondition %} AND
              {% condition campaign_details_base.pl_plan_id %} CD.PL_PLAN_ID {% endcondition %} AND
              {% condition campaign_details_base.plan_name %} CD.PL_PLAN_NAME {% endcondition %} AND
              {% condition advertiser_brand_details.advertiser_name %} ABD.ADVERTISER_NAME {% endcondition %} AND
              {% condition advertiser_brand_details.brand_name %} ABD.BRAND_NAME {% endcondition %}
            GROUP BY
              DCS.FLIGHT_MEDIA_ID,
              DCS.PLACEMENT_ID,
              DCS.DEMAND_DATE
        ) A
        INNER JOIN (
          SELECT
            CUS.flight_media_id,
            CUS.PLACEMENT_ID,
            CUS.DEMAND_DATE,
            (sum(CUS.impressions) * 1.0) sample_imps,
            count(DISTINCT CUS.userid) count_users
        FROM DEMAND_MART.DAILY_CORE_USER_SAMPLE CUS
          JOIN DIM.FLIGHT_MEDIA_DETAILS FMD on CUS.flight_media_id = FMD.flight_media_id
        {% if campaign_details_base._in_query %} JOIN DIM.CAMPAIGN_DETAILS_BASE CD on FMD.campaign_id = CD.campaign_id {% endif %}
        {% if advertiser_brand_details._in_query %} JOIN DIM.ADVERTISER_BRAND_DETAILS ABD on CD.advertiser_brand_id = ABD.advertiser_brand_id {% endif %}
        WHERE {% condition daily_core_stats.demand_date %} CUS.DEMAND_DATE {% endcondition %} AND
          {% condition campaign_details_base.campaign_id %} FMD.CAMPAIGN_ID {% endcondition %} AND
          {% condition campaign_details_base.campaign_name %} CD.CAMPAIGN_NAME {% endcondition %} AND
          {% condition campaign_details_base.pl_plan_id %} CD.PL_PLAN_ID {% endcondition %} AND
          {% condition campaign_details_base.plan_name %} CD.PL_PLAN_NAME {% endcondition %} AND
          {% condition advertiser_brand_details.advertiser_name %} ABD.ADVERTISER_NAME {% endcondition %} AND
          {% condition advertiser_brand_details.brand_name %} ABD.BRAND_NAME {% endcondition %}
        GROUP BY
          CUS.FLIGHT_MEDIA_ID,
          CUS.PLACEMENT_ID,
          CUS.DEMAND_DATE
     ) B
     ON (A.flight_media_id = B.flight_media_id)
        AND (A.placement_id = B.placement_id)
        AND (A.demand_date = B.demand_date)
    ;;

    }


dimension: primary_key {
    type: number
    primary_key: yes
    hidden: yes
  sql: ${TABLE}.PK_ID ;;
}

    dimension: flight_media_id {
      type: number
      hidden: yes
      sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
    }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PLACEMENT_ID ;;
  }

    dimension: demand_date {
      type: date_raw
      hidden: yes
      sql: ${TABLE}.DEMAND_DATE ;;
    }

    dimension: impressions {
      type: number
      hidden: yes
      sql: ${TABLE}.fm_impressions ;;
    }

    measure: sum_impressions {
      type: sum
      label: "Impressions"
      hidden: yes
      sql: ${impressions} ;;
    }

    dimension: fm_avg_freq {
      type: number
      hidden: yes
      sql: ${TABLE}.fm_average_freq ;;
    }

    dimension: fm_weighted_imps {
      type: number
      hidden: yes
      sql: ${TABLE}.weighted_fm_imps ;;
    }

    measure: sum_fm_weighted_imps {
      type: sum
      hidden: yes
      value_format_name: decimal_0
      sql: ${fm_weighted_imps} ;;
    }

  measure: average_frequency {
    type: number
    label: "Average Frequency"
    view_label: "Impression Metrics"
    description: "The average number of times any indvidual user saw a given flight media. Average Frequency can be calculated in conjuction
    with any dimensions in the demand-side hierarchy, the supply-side hierarchy, or the demand-date hierarchy (Demand Date, Week, Month,
    Year)."
    value_format_name: decimal_2
    sql: COALESCE(${sum_fm_weighted_imps} / NULLIF(${sum_impressions},0),1)
      ;;
  }

  measure: reach {
    type: number
    label: "Reach"
    view_label: "Impression Metrics"
    description: "The distinct number of viewers that saw a given flight media across the level that the report is aggregate at.
    For example, if the view is for 3 days for a single campaign, then the reach is the number of distinct viewers that saw an
    impression for that campaign for those 3 days.  This number is not summative at different levels. Reach can be calculated in conjuction
    with any dimensions in the demand-side hierarchy, the supply-side hierarchy, or the demand date hierarchy (Demand Date, Week, Month,
    Year)."
    value_format_name: decimal_0
    sql: COALESCE(${daily_core_stats.sum_impressions} / NULLIF(${average_frequency},0), ${daily_core_stats.sum_impressions})
      ;;
  }


  }
