view: mssql_oltp_activity_log {
  label: "Activity Log"
  derived_table: {
    sql: SELECT
          cal.campaign_id
          ,al.activity_type_id
          ,al.occurred_date
          ,al.createdby userid
         FROM activity_log al (NOLOCK) JOIN campaign_activity_log cal (NOLOCK) ON cal.activity_log_id = al.activity_log_id
         WHERE al.activity_type_id in (1,7,12,16,18,51,62,2)
           AND {% condition occurred_date_time %} al.occurred_date {% endcondition %}
           AND {% condition occurred_date_date %} al.occurred_date {% endcondition %}
           AND {% condition occurred_date_week %} al.occurred_date {% endcondition %}
           AND {% condition occurred_date_month %} al.occurred_date {% endcondition %}
           AND {% condition occurred_date_quarter %} al.occurred_date {% endcondition %}
           AND {% condition occurred_date_year %} al.occurred_date {% endcondition %}
         UNION ALL
         SELECT
          d.seller_campaign_id
          ,al.activity_type_id
          ,al.occurred_date
          ,al.createdby userid
         FROM activity_log al (NOLOCK) JOIN campaign_activity_log cal (NOLOCK) ON cal.activity_log_id = al.activity_log_id
         JOIN deal d (NOLOCK) ON cal.campaign_id = d.buyer_campaign_id
         WHERE al.activity_type_id in (1,7,12,16,18,51,62,2)
           AND {% condition occurred_date_time %} al.occurred_date {% endcondition %}
           AND {% condition occurred_date_date %} al.occurred_date {% endcondition %}
           AND {% condition occurred_date_week %} al.occurred_date {% endcondition %}
           AND {% condition occurred_date_month %} al.occurred_date {% endcondition %}
           AND {% condition occurred_date_quarter %} al.occurred_date {% endcondition %}
           AND {% condition occurred_date_year %} al.occurred_date {% endcondition %}
         UNION ALL
         SELECT
          d.seller_campaign_id
          ,0
          ,dmp.createdon
          ,dmp.createdby
         FROM deal d (NOLOCK) JOIN deal_media_plan dmp (NOLOCK) ON d.id = dmp.deal_id
         WHERE {% condition occurred_date_time %} dmp.createdon {% endcondition %}
           AND {% condition occurred_date_date %} dmp.createdon {% endcondition %}
           AND {% condition occurred_date_week %} dmp.createdon {% endcondition %}
           AND {% condition occurred_date_month %} dmp.createdon {% endcondition %}
           AND {% condition occurred_date_quarter %} dmp.createdon {% endcondition %}
           AND {% condition occurred_date_year %} dmp.createdon {% endcondition %}
         UNION ALL
         SELECT
          d.seller_campaign_id
          ,-2
          ,ar.createdon
          ,ar.createdby
         FROM deal d (NOLOCK) JOIN attribution_report ar (NOLOCK) ON d.id = ar.entity_id AND ar.entity_type_id = 7 -- deal
         WHERE {% condition occurred_date_time %} ar.createdon {% endcondition %}
           AND {% condition occurred_date_date %} ar.createdon {% endcondition %}
           AND {% condition occurred_date_week %} ar.createdon {% endcondition %}
           AND {% condition occurred_date_month %} ar.createdon {% endcondition %}
           AND {% condition occurred_date_quarter %} ar.createdon {% endcondition %}
           AND {% condition occurred_date_year %} ar.createdon {% endcondition %}
         UNION ALL
         SELECT
          c.campaign_id
          ,-1
          ,ab.createdon
          ,ab.createdby
         FROM campaign c (NOLOCK) JOIN advertiser_brand ab (NOLOCK) ON c.advertiser_brand_id = ab.advertiser_brand_id
         WHERE {% condition occurred_date_time %} ab.createdon {% endcondition %}
           AND {% condition occurred_date_date %} ab.createdon {% endcondition %}
           AND {% condition occurred_date_week %} ab.createdon {% endcondition %}
           AND {% condition occurred_date_month %} ab.createdon {% endcondition %}
           AND {% condition occurred_date_quarter %} ab.createdon {% endcondition %}
           AND {% condition occurred_date_year %} ab.createdon {% endcondition %}
         UNION ALL
         SELECT
          c.campaign_id
          ,-3
          ,c.createdon
          ,c.createdby
         FROM campaign c (NOLOCK)
         WHERE {% condition occurred_date_time %} c.createdon {% endcondition %}
           AND {% condition occurred_date_date %} c.createdon {% endcondition %}
           AND {% condition occurred_date_week %} c.createdon {% endcondition %}
           AND {% condition occurred_date_month %} c.createdon {% endcondition %}
           AND {% condition occurred_date_quarter %} c.createdon {% endcondition %}
           AND {% condition occurred_date_year %} c.createdon {% endcondition %} ;;
}

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  #####################################################################
  # id #          db activity         #        tpm-148 activity       #
  #####################################################################
  # 51 # PlanSent                     # Plan Creation                 #
  # 1  # DealSent                     # Deal Sent                     #
  # 7  # MediaPlanSent                # Proposal Shared With Buyer    #
  # 12 # CommentSent                  # Campaign Activity Log Comment #
  # 16 # MediaPlanGenerationRequested # Proposal Generation           #
  # 18 # MediaPlanGenerationSucceeded # Proposal Available            #
  # 2  # DealLaunched                 # Proposal Approval             #
  # -1 #                              # PCAB Creation                 #
  # -2 #                              # Attribution Report Generated  #
  # -3 #                              # Campaign Creation             #
  #####################################################################

  dimension: activity_name {
    type: string
    label: "Activity"
  sql: CASE ${TABLE}.activity_type_id
        WHEN 51 THEN 'Plan Creation'
        WHEN 1  THEN 'Deal Sent'
        WHEN 16 THEN 'Proposal Generation'
        WHEN 18 THEN 'Proposal Available'
        WHEN 2  THEN 'Proposal Approval'
        WHEN 7  THEN 'Proposal Shared With Buyer'
        WHEN 12 THEN 'Campaign Activity Log Comment'
        WHEN 0  THEN 'Request Proposal'
        WHEN -2 THEN 'Attribution Report Generated'
        WHEN -1 THEN 'PCAB Creation'
        WHEN -3 THEN 'Campaign Creation'
       END ;;
  }

  dimension_group: occurred_date {
    type: time
    label: "Action"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.occurred_date ;;
  }

  dimension_group: occurred_date_demand {
    type: time
    label: "Action Demand"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: dateadd(HH, ${mssql_oltp_timezone.utc_offset}, ${TABLE}.occurred_date) ;;
  }


  dimension: user_id {
    type: string
    hidden: yes
    sql: ${TABLE}.userid ;;
  }

}
