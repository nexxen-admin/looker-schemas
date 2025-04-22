view: mssql_oltp_campaign_placement_constraint_history {
  sql_table_name: (
    SELECT
        campaign_placement_constraint_id
      , allow_shortfall
      , min_value
    FROM (
      SELECT
          campaign_placement_constraint_id
        , allow_shortfall
        , min_value
        , ROW_NUMBER() OVER (PARTITION BY campaign_placement_constraint_id ORDER BY changedon DESC) as _rn
      FROM AN_MAIN..campaign_placement_constraint_history (NOLOCK)
      WHERE {% parameter spreader_date%} > changedon
    ) AS partitioned
    WHERE _rn = 1
  ) ;;
  view_label: "Spreader Control"

  parameter: spreader_date {
    type: date
    description: "For reliable results be sure to filter on Placement ID and/or Campaign ID when filtering by date."
  }

  dimension: campaign_placement_constraint_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_placement_constraint_id ;;
  }

  dimension: constraint_type {
    type: string
    label: "Constraint Type History"
    hidden: yes
    sql: CASE WHEN ${TABLE}.allow_shortfall = 0 THEN 'Hard' ELSE 'Soft' END ;;
    suggestions: ["Soft", "Hard"]
  }

  dimension: min_value {
    type: number
    label: "Spreader History"
    hidden: yes
    sql: COALESCE(${TABLE}.min_value, ${mssql_oltp_an_hist_platform_client_preference_ct_spreader.spreader}, CAST(${mssql_oltp_global_settings.setting_value} AS FLOAT)/100) ;;
    value_format_name: percent_2
  }
}
