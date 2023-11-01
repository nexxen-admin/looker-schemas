view: v_original_fm_created_by {

#Derived table used to return user who created 1st Flight Media in a campaign.

  derived_table: {
    sql: select
        t.campaign_id as CAMPAIGN_ID,
        up.LASTNAME || ', ' || up.FIRSTNAME AS CREATED_BY
      from
      (
        select
          fmd.campaign_id,
          fmd.createdby,
          row_number() over (partition by fmd.campaign_id order by fmd.createdon) as rn
        from
          dim.flight_media_details_base_view as fmd
        where
          {% condition v_flight_media_details_base.begin_datetm %} fmd.begin_datetm {% endcondition %} and
          {% condition v_flight_media_details_base.end_datetm %} fmd.end_datetm {% endcondition %} and
          fmd.flight_media_active
      ) as t
      join dim.user_profile_view up on up.USERID = t.createdby
      where
        t.rn = 1
            ;;
  }

  dimension: campaign_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: created_by_id {
    hidden: yes
    type: string
    sql: ${TABLE}.CREATED_BY ;;
  }

  measure: max_created_by {
    type: string
    label: "Original FM Created By"
    view_label: "Campaign"
    sql: max(${created_by_id}) ;;
  }

}
