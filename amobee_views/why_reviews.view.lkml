view: why_reviews {
  derived_table: {
    sql:
      select
        r.id,
        r.date,
        r.user_name,
        r.comment_count,
        r.defect_count,
        r.changed_lines,
        r.needs_resolution_count,
        r.jira_items_id,
        r.jira_items_type,
        row_number() over (partition by r.user_name order by r.date desc) as reverse_review_number
      from
        dbo.reviews r (NOLOCK)
      where
        {% condition date_time %} r.date {% endcondition %} and
        {% condition date_date %} r.date {% endcondition %} and
        {% condition date_week %} r.date {% endcondition %} and
        {% condition date_month %} r.date {% endcondition %} and
        {% condition date_quarter %} r.date {% endcondition %} and
        {% condition date_year %} r.date {% endcondition %} ;;
  }

  dimension: id {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "Review"
    sql: ${TABLE}.date ;;
  }

  dimension: review_date {
    type: date
    label: "Review Date"
    sql: ${TABLE}.date ;;
    drill_fields: [date_time]
    link: {
      label: "View In Crucible"
      url: "https://crucible.gio.videologygroup.com/cru/{{ id }}"
    }
    link: {
      label: "View In Jira"
      url: "https://jira-tech.amobee.com/browse/{{ jira_items_id }}"
    }
  }

  dimension: user_name {
    type: string
    label: "User Name"
    sql: ${TABLE}.user_name ;;
    link: {
      label: "Why Dashboard (Individual)"
      url: "/dashboards/172?User Name={{ value }}"
    }
  }

  measure: review_count {
    type: count
    label: "Total Reviews"
  }

  measure: comment_count {
    type: sum
    label: "Total Comments"
    sql: ${TABLE}.comment_count ;;
  }

  measure: avg_comment_count {
    type: average
    label: "Average Comments"
    value_format_name: decimal_2
    sql: cast(${TABLE}.comment_count as float) ;;
  }

  measure: defect_count {
    type: sum
    label: "Total Defects"
    sql: ${TABLE}.defect_count ;;
  }

  measure: avg_defect_count {
    type: average
    label: "Average Defects"
    value_format_name: decimal_2
    sql: cast(${TABLE}.defect_count as float) ;;
  }

  measure: changed_lines {
    type: sum
    label: "Total Changed Lines"
    sql: ${TABLE}.changed_lines ;;
  }

  measure: avg_changed_lines {
    type: average
    label: "Average Changed Lines"
    value_format_name: decimal_2
    sql: cast(${TABLE}.changed_lines as float) ;;
  }

  measure: needs_resolution_count {
    type: sum
    label: "Total Needs Resolution"
    sql: ${TABLE}.needs_resolution_count ;;
  }

  measure: avg_needs_resolution_count {
    type: average
    label: "Average Needs Resolution"
    sql: cast(${TABLE}.needs_resolution_count as float) ;;
  }

  dimension: jira_items_id {
    type: string
    label: "Jira Issue"
    sql: ${TABLE}.jira_items_id ;;
  }

  dimension: jira_items_type {
    type: string
    label: "Jira Issue Type"
    sql: ${TABLE}.jira_items_type ;;
  }

  dimension: reverse_review_number {
    type: number
    label: "Reverse Review Number"
    sql: ${TABLE}.reverse_review_number ;;
    link: {
      label: "View In Crucible"
      url: "https://crucible.gio.videologygroup.com/cru/{{ id }}"
    }
    link: {
      label: "View In Jira"
      url: "https://jira-tech.amobee.com/browse/{{ jira_items_id }}"
    }
  }
}
