
view: creative_package_overlap_dates {
  derived_table: {
    sql: WITH m AS (
          SELECT DISTINCT creative_id_key, package_id
          FROM BI_DSP.fact_nexxen_dsp
      ),
      package_counts AS (
          SELECT creative_id_key, COUNT(package_id) AS package_count
          FROM m
          GROUP BY creative_id_key
      ),
      filtered_creatives AS (
          SELECT creative_id_key, package_id
          FROM m
          WHERE creative_id_key IN (SELECT creative_id_key FROM package_counts WHERE package_count > 1)
      ),
      schedules AS (
          SELECT fc.creative_id_key, fc.package_id,
                 ddpbs.start_date,
                 COALESCE(ddpbs.end_date, CURRENT_DATE + 1) AS end_date
          FROM filtered_creatives fc
          LEFT JOIN BI_DSP.dim_dsp_package_budget_schedule ddpbs
          ON fc.package_id = ddpbs.package_id
      ),
      overlapping_schedules AS (
          SELECT DISTINCT s1.creative_id_key,
                          s1.package_id AS package_id_1, s1.start_date AS start_date_1, s1.end_date AS end_date_1,
                          s2.package_id AS package_id_2, s2.start_date AS start_date_2, s2.end_date AS end_date_2
          FROM schedules s1
          INNER JOIN schedules s2
          ON s1.creative_id_key = s2.creative_id_key
          AND s1.package_id != s2.package_id
          AND GREATEST(s1.start_date, s2.start_date) < LEAST(s1.end_date, s2.end_date)
      ),
      sf_metadata AS (
          SELECT distinct ddc.creative_id_key,
             ddc.creative_id as creative_id,
             fnd.package_id as package_id,
             dso.id as opp_line_item_id,
             dso2.id as opp_line_item_schedule_id,
             ddpbs.packag_budget_schedule_id as budget_schedule_id,
           dsu.firstname||' '||dsu.lastname as account_manager,
           dsu.title as role
      from BI_DSP.fact_nexxen_dsp fnd
      Inner JOIN BI_DSP.dim_dsp_creative ddc on fnd.creative_id_key = ddc.creative_id_key
      Inner JOIN BI_DSP.dim_sfdb_opportunitylineitem dso on fnd.opportunitylineitem_key = dso.opportunitylineitem_key
      Inner JOIN BI_DSP.dim_sfdb_opportunitylineitemschedule dso2 on fnd.opportunitylineitemschedule_key = dso2.opportunitylineitemschedule_key
      Inner JOIN BI_DSP.dim_dsp_package_budget_schedule ddpbs on fnd.package_budget_schedule_key = ddpbs.package_budget_schedule_key
      Inner JOIN BI_DSP.dim_sfdb_user dsu on fnd.user_key_id = dsu.user_key_id
      ),
      final AS (
          SELECT DISTINCT ddc.creative_id,
                          os.package_id_1,
                          os.start_date_1::date AS start_date,
                          os.end_date_1::date AS end_date,
                          ddc.creative_id_key,
                          os.package_id_2,
                          os.start_date_2::date AS overlap_start_date,
                          os.end_date_2::date AS overlap_end_date
          FROM overlapping_schedules os
          LEFT JOIN BI_DSP.dim_dsp_creative ddc
          ON os.creative_id_key = ddc.creative_id_key
          WHERE ddc.creative_id != -1
      )
      SELECT DISTINCT f.creative_id,
                f.package_id_1,
                f.start_date AS start_date_1,
                f.end_date AS end_date_1,
                f.package_id_2,
                f.overlap_start_date AS start_date_2,
                f.overlap_end_date AS end_date_2,
                opp_line_item_id,
                opp_line_item_schedule_id,
                budget_schedule_id,
                account_manager,
                role
FROM final f
JOIN sf_metadata sfm
ON f.creative_id_key = sfm.creative_id_key
AND f.package_id_1 = sfm.package_id
ORDER BY f.creative_id ASC, start_date_1 DESC ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: creative_id {
    type: number
    sql: ${TABLE}.creative_id ;;
  }

  dimension: package_id_1 {
    type: number
    sql: ${TABLE}.package_id_1 ;;
  }

  dimension: start_date_1 {
    type: date
    sql: ${TABLE}.start_date_1 ;;
  }

  dimension: end_date_1 {
    type: date
    sql: ${TABLE}.end_date_1 ;;
  }

  dimension: package_id_2 {
    type: number
    sql: ${TABLE}.package_id_2 ;;
  }

  dimension: start_date_2 {
    type: date
    sql: ${TABLE}.start_date_2 ;;
  }

  dimension: end_date_2 {
    type: date
    sql: ${TABLE}.end_date_2 ;;
  }

  dimension: opp_line_item_id {
    type: string
    sql: ${TABLE}.opp_line_item_id ;;
  }

  dimension: opp_line_item_schedule_id {
    type: string
    sql: ${TABLE}.opp_line_item_schedule_id ;;
  }

  dimension: budget_schedule_id {
    type: string
    sql: ${TABLE}.budget_schedule_id ;;
  }

  dimension: account_manager {
    type: string
    sql: ${TABLE}.account_manager ;;
  }

  dimension: role {
    type: string
    sql: ${TABLE}.role ;;
  }

  set: detail {
    fields: [
        creative_id,
  package_id_1,
  start_date_1,
  end_date_1,
  package_id_2,
  start_date_2,
  end_date_2
    ]
  }
}
