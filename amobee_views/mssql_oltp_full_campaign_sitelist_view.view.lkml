view: mssql_oltp_full_campaign_sitelist_view {
  sql_table_name: (
    {% if mssql_oltp_campaign_placement_constraint_history.spreader_date._in_query %}
    (
      SELECT
          partitioned.campaign_id
        , partitioned.placement_id
      FROM (
        SELECT
            campaign_id
          , placement_id
          , active
          , is_targeted
          , __$operation
          , ROW_NUMBER() OVER (PARTITION BY campaign_id, placement_id ORDER BY tran_time DESC) as _rn
        FROM (
          SELECT
              cs.campaign_id
            , cs.placement_id
            , cs.active
            , cs.is_targeted
            , cs.__$operation
            , cs.tran_time
          FROM AN_HIST.AN_MAIN.dbo_campaign_sitelist_CT cs (NOLOCK)
          JOIN AN_MAIN..campaign c (NOLOCK) ON cs.campaign_id = c.campaign_id
          JOIN AN_MAIN..campaign_summary_view csv (NOLOCK)
            ON cs.campaign_id = csv.campaign_id
            AND {% parameter mssql_oltp_campaign_placement_constraint_history.spreader_date%} BETWEEN CAST(csv.begin_datetm AS DATE) AND CAST(DATEADD(DAY,1, csv.end_datetm) AS DATE)
          WHERE {% parameter mssql_oltp_campaign_placement_constraint_history.spreader_date%} > tran_time
            AND cs.__$operation in (1,2,4)
            AND {% condition mssql_oltp_full_campaign_sitelist_view.campaign_id %} cs.campaign_id {% endcondition %}
            AND {% condition placement.placement_id %} cs.placement_id {% endcondition %}
            AND c.active = 1
          ) a
      ) AS partitioned
      WHERE partitioned._rn = 1
        AND partitioned.active = 1
        AND partitioned.is_targeted = 1
        AND partitioned.__$operation in (2,4)
    )
    {% else %}
      SELECT
          fcsv.campaign_id
        , fcsv.placement_id
        , fcsv.campaign_type_id
        , fcsv.active
        , fcsv.is_targeted
      FROM AN_MAIN..full_campaign_sitelist_view fcsv (NOLOCK)
      JOIN AN_MAIN..campaign c (NOLOCK) ON fcsv.campaign_id = c.campaign_id
      WHERE c.campaign_status_id = 1 -- Running
    {% endif %}
  ) ;;
  view_label: "Spreader Control"

  dimension: campaign_id {
    type: number
    label: "Campaign ID"
    sql: ${TABLE}.campaign_id ;;
    value_format_name: id
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_id ;;
  }

  dimension: campaign_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_type_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: is_targeted {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_targeted = 1 ;;
  }
}
