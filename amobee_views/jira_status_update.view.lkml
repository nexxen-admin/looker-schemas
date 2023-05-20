view: status_update {
  derived_table: {
    sql: SELECT
          cg.id,
          cg.issueid,
          cg.created,
          ci.oldvalue,
          ci.oldstring,
          ci.newvalue,
          ci.newstring
        FROM changegroup cg
        INNER JOIN changeitem ci ON ci.groupid = cg.id
        AND ci.FIELDTYPE = 'jira' AND ci.FIELD = 'status' ;;
  }

  dimension: id {
    type: number
    primary_key: yes
    hidden: yes
  }

  dimension: issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}.issueid ;;
  }

  dimension: updated {
    type: date
    sql: ${TABLE}.created ;;
    view_label: "Status Changelog"
    convert_tz: no
  }

  dimension: old_status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.oldvalue ;;
  }

  dimension: old_status {
    type: string
    sql: ${TABLE}.oldstring ;;
    view_label: "Status Changelog"
  }

  dimension: new_status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.newvalue ;;
  }

  dimension: new_status {
    type: string
    sql: ${TABLE}.newstring ;;
    view_label: "Status Changelog"
  }

  filter: release_date_filter {
    type: date
    label: "Release Date Filter"
    view_label: "Release Stages"
  }

  measure: alpha_count {
    type: count_distinct
    label: "Alpha Released Count"
    view_label: "Release Stages"
    sql: CASE WHEN {% condition release_date_filter %} ${updated} {% endcondition %} AND ${new_status} = 'Alpha'
      THEN ${issue_id}
      ELSE NULL
      END ;;
  }

  measure: beta_count {
    type: count_distinct
    label: "Beta Released Count"
    view_label: "Release Stages"
    sql: CASE WHEN {% condition release_date_filter %} ${updated} {% endcondition %} AND ${new_status} = 'Beta'
      THEN ${issue_id}
      ELSE NULL
      END ;;
  }

  measure: ga_count {
    type: count_distinct
    label: "Ga Released Count"
    view_label: "Release Stages"
    sql: CASE WHEN {% condition release_date_filter %} ${updated} {% endcondition %} AND ${new_status} = 'Released'
      THEN ${issue_id}
      ELSE NULL
      END ;;
  }


  measure: alpha_days {
    type: sum_distinct
    label: "Alpha Days"
    view_label: "Release Stages"
    sql: CASE WHEN {% condition release_date_filter %} ${updated} {% endcondition %} AND ${new_status} = 'Alpha'
      THEN ${customfieldvalue_days.days}
      END ;;
  }

  measure: beta_days {
    type: sum_distinct
    label: "Beta Days"
    view_label: "Release Stages"
    sql: CASE WHEN {% condition release_date_filter %} ${updated} {% endcondition %} AND ${new_status} = 'Beta'
      THEN ${customfieldvalue_days.days}
      END ;;
  }

  measure: ga_days {
    type: sum_distinct
    label: "GA Days"
    view_label: "Release Stages"
    sql: CASE WHEN {% condition release_date_filter %} ${updated} {% endcondition %} AND ${new_status} = 'Released'
      THEN ${customfieldvalue_days.days}
      END ;;
  }
}
