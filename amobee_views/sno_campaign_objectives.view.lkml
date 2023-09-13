view: campaign_objectives {
  derived_table:
  {
    sql: SELECT campaign_id
  ,max(primary_objective) AS primaryobjective
  ,max(primary_goal) AS primarygoal
  ,max(primary_objective_vendor) as primaryvendor
  ,max(secondary_objective) AS secondaryobjective
  ,max(secondary_goal) AS secondarygoal
  ,max(secondary_objective_vendor) AS secondaryvendor
FROM (
  SELECT campaign_id
    ,CASE
      WHEN is_primary = 1
        THEN advertiser_objective_description
      ELSE NULL
      END AS primary_objective
    ,CASE
      WHEN is_primary = 1
        THEN coalesce(min_goal_value, 0)
      ELSE NULL
      END AS primary_goal
   ,CASE
      WHEN is_primary = 1
        THEN pricing_vendor_id
      ELSE NULL
      END AS primary_objective_vendor
    ,CASE
      WHEN is_primary = 0
        THEN advertiser_objective_description
      ELSE NULL
      END AS secondary_objective
    ,CASE
      WHEN is_primary = 0
        THEN coalesce(min_goal_value, 0)
      ELSE NULL
      END AS secondary_goal
   ,CASE
      WHEN is_primary = 0
        THEN pricing_vendor_id
      ELSE NULL
      END AS secondary_objective_vendor
  FROM dim.campaign_objective_view
  )cobj  GROUP BY campaign_id;;
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: primary_objective {
    type: string
    label: "Primary Campaign Objective"
    view_label: "Campaign"
    sql: ${TABLE}.primaryobjective ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.primary_objective
  }

  dimension: primary_goal {
    type: number
    label: "Primary Objective Goal"
    value_format_name: percent_0
    view_label: "Campaign"
    sql: ${TABLE}.primarygoal ;;
  }

  dimension: secondary_objective {
    type: string
    label: "Secondary Campaign Objective"
    view_label: "Campaign"
    sql: ${TABLE}.secondaryobjective ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.secondary_objective
  }

  dimension: secondary_goal {
    type: number
    label: "Secondary Objective Goal"
    view_label: "Campaign"
    value_format_name: percent_0
    sql: ${TABLE}.secondarygoal ;;
  }

  dimension: primary_vendor_description {
    type: string
    label: "Primary Objective Vendor"
    view_label: "Campaign"
    description: "The Vendor that measures the primary objective."
    sql: CASE WHEN ${TABLE}.primaryvendor = 101 THEN 'Videology'
              WHEN ${TABLE}.primaryvendor = 102 THEN 'MOAT'
              WHEN ${TABLE}.primaryvendor = 103 THEN 'DoubleVerify'
              WHEN ${TABLE}.primaryvendor = 104 THEN 'Integral Ad Science'
              ELSE 'None' END ;;
    suggestions: ["Videology", "MOAT", "DoubleVerify", "Integral Ad Science", "None"]
  }

  dimension: secondary_vendor_description {
    type: string
    label: "Secondary Objective Vendor"
    view_label: "Campaign"
    description: "The Vendor that measures the primary objective."
    sql: CASE WHEN ${TABLE}.secondaryvendor = 101 THEN 'Videology'
              WHEN ${TABLE}.secondaryvendor = 102 THEN 'MOAT'
              WHEN ${TABLE}.secondaryvendor = 103 THEN 'DoubleVerify'
              WHEN ${TABLE}.secondaryvendor = 104 THEN 'Integral Ad Science'
              ELSE 'None' END ;;
    suggestions: ["Videology", "MOAT", "DoubleVerify", "Integral Ad Science", "None"]
  }

}
