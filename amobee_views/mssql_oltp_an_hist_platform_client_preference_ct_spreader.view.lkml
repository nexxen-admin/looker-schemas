view: mssql_oltp_an_hist_platform_client_preference_ct_spreader {
  sql_table_name: (
    SELECT
        platform_client_id
      , preference_value
    FROM (
      SELECT
          platform_client_id
        , preference_value
        , active
        , ROW_NUMBER() OVER (PARTITION BY platform_client_preference_id ORDER BY changedon DESC) as _rn
      FROM AN_HIST.AN_MAIN.dbo_platform_client_preference_CT (NOLOCK)
      WHERE {% parameter mssql_oltp_campaign_placement_constraint_history.spreader_date%} > changedon
        AND __$operation in (2, 4)
        AND preference_key = 'DefaultSpreader'
    ) AS partitioned
    WHERE _rn = 1
      AND active = 1
  ) ;;

  dimension: platform_client_id {
    type: number
    hidden: yes
    sql: ${TABLE}.platform_client_id ;;
  }

  dimension: spreader {
    type: number
    hidden: yes
    sql: CAST(${TABLE}.preference_value AS FLOAT)/100 ;;
  }
}
