view: opt_inventory_assignment  {
  label: "Placement Details"

  derived_table: {
    sql:
 SELECT pcc.placement_id AS "PLACEMENT_ID"
    ,pcc.placement_name AS "PLACEMENT_NAME"
    ,pcc.CAMPAIGN_COUNT AS "CAMPAIGN_COUNT"
    ,SUM(hourly_ccp_eoc) AS "CCP"
  FROM (SELECT p.placement_id AS placement_id
    ,p.placement_name as placement_name
    ,st.campaign_id
    ,count(DISTINCT st.campaign_id) AS "CAMPAIGN_COUNT"
  FROM AN_MAIN..placement(NOLOCK) p
  JOIN AN_MAIN..campaign_sitelist(NOLOCK) st ON p.placement_id = st.placement_id
    AND st.active = 1
    AND p.active = 1
    AND {% condition placement_name %} p.placement_name {% endcondition %}
    AND {% condition placement_id %} p.placement_id {% endcondition %}

  GROUP BY p.placement_id
    ,p.placement_name
    ,st.campaign_id) pcc
  INNER JOIN OPT_RPT..hourly_ccp_metrics(NOLOCK) ccp ON ccp.campaign_id = pcc.campaign_id
    AND ccp.keydate >= cast(getdate() AS DATE)
    AND ccp.keydate <= dateadd(dd, 366, getdate())
  GROUP BY pcc.placement_id
    ,pcc.placement_name
    ,pcc.CAMPAIGN_COUNT;;
  }

  dimension: placement_id {
    description: "Placement ID"
    value_format_name: id
    type: number
    sql: ${TABLE}.placement_id ;;
  }

  dimension: placement_name {
    description: "Placement Name"
    type: string
    sql: ${TABLE}.placement_name ;;
  }

  dimension: campaign_count {
    description: "Campaign Count"
    type: number
    value_format_name: decimal_0
    sql: ${TABLE}.CAMPAIGN_COUNT ;;
  }

  dimension: ccp {
    description: "CCP"
    type: number
    value_format_name: decimal_0
    sql: ${TABLE}.CCP ;;
  }

}
