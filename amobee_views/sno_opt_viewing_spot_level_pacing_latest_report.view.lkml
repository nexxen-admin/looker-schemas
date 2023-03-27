view: sno_opt_viewing_spot_level_pacing_latest_report {
  sql_table_name: (
    SELECT pacing.campaign_id, MAX(pacing.run_date) AS latest_run_date
    FROM "OPT"."VIEWING_SPOT_LEVEL_PACING" pacing
    {% if sno_opt_viewing_spot_level_pacing.show_only_latest_report._parameter_value == 'latest_approved' %}
    JOIN "OPT"."PACING_REPORT_APPROVAL" approval ON pacing.report_id = approval.report_id
    WHERE approval.approval_state = 'approved'
    {% endif %}
    GROUP BY pacing.campaign_id
    ) ;;

  dimension: campaign_id {
    hidden: yes
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: latest_run_date {
    hidden: yes
    type: date_raw
    sql: ${TABLE}.latest_run_date ;;
  }
}
