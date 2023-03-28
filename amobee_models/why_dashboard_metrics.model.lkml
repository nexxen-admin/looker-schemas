connection: "why_dashboard_metrics"
label: "Reference"

include: "/**/*.view.lkml"

explore: why_reviews {
  label: "Why Dashboard Reviews"

  join: why_users {
    relationship: many_to_many
    sql_on: ${why_reviews.user_name} = ${why_users.name} ;;
  }

  join: why_teams {
    relationship: many_to_one
    sql_on: ${why_users.team_id} = ${why_teams.id} ;;
  }
}
