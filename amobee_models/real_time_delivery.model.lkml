connection: "aurora"
label: "Real Time Delivery"
include: "/**/*.view.lkml"
#include: "*.dashboard.lookml"  # include all dashboards in this project

access_grant: can_see_model {
  user_attribute: external_users
  allowed_values: ["External_Users"]
}


 explore: flight_media_statistics {
  required_access_grants: [can_see_model]
  label: "Real Time Delivery Statistics"
  description: "These are near real time delivery statistics (updated approximately every 15 minutes).  These numbers are for directional purposes only and are not final reporting numbers.
  They are based on a GMT day and are not in local timezones."

join: aur_flight_media_details {
  relationship: many_to_one
  sql_on: ${aur_flight_media_details.flight_media_id}= ${flight_media_statistics.flight_media_id};;
}

  join: aur_flight_details {
    relationship: many_to_one
    sql_on: ${aur_flight_media_details.flight_id}= ${aur_flight_details.flight_id};;
  }

  join: aur_campaign_details {
    relationship: many_to_one
    sql_on: ${aur_flight_details.campaign_id}= ${aur_campaign_details.campaign_id};;
  }

  join: vg_main_campaign_details {
    relationship: many_to_one
    sql_on: ${aur_flight_details.campaign_id}= ${vg_main_campaign_details.campaign_id};;
  }

  join: vg_main_flight_media_details {
    relationship: many_to_one
    sql_on: ${aur_flight_media_details.flight_media_id} = ${vg_main_flight_media_details.flight_media_id} ;;
  }

  join: aur_plan_details {
    relationship: many_to_one
    sql_on: ${aur_campaign_details.pl_plan_id} = ${aur_plan_details.pl_plan_id};;
  }

  join: aur_plan_budget {
    relationship: one_to_one
    sql_on: ${aur_plan_details.pl_plan_id} = ${aur_plan_budget.plan_id};;
  }

  join: aur_placement_details {
    relationship: many_to_one
    sql_on: ${flight_media_statistics.placement_id} = ${aur_placement_details.placement_id} ;;
  }

  join: aur_actions_v2_requests {
    relationship: one_to_many
    sql_on: ${flight_media_statistics.flight_media_id} = ${aur_actions_v2_requests.flight_media_id}
     and ${flight_media_statistics.placement_id} = ${aur_actions_v2_requests.placement_id} ;;
  }

}

explore: flight_media_placement_imp_stats_log  {
  required_access_grants: [can_see_model]
  label: "Short Cycle Logging"
  hidden: yes

  join: aur_flight_media_details {
    relationship: many_to_one
    sql_on: ${aur_flight_media_details.flight_media_id} = ${flight_media_placement_imp_stats_log.flight_media_id} ;;
  }


}
