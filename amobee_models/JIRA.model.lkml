connection: "jira"

include: "jira_*.view.lkml"         # include all views in this project
include: "JIRA_data_tests.lkml"
#include: "*.dashboard.lookml"  # include all dashboards in this project


explore: jiraissue {
  label: "JIRA Issues"
  persist_for: "10 minutes"

  join: project {
    relationship: many_to_one
    sql_on: ${jiraissue.project} = ${project.id} ;;
  }

  join: issueassignee {
    relationship: many_to_one
    sql_on: ${jiraissue.assignee} = ${issueassignee.user_key} ;;
  }

  join: issuecreator {
    relationship: many_to_one
    sql_on: ${jiraissue.creator} = ${issuecreator.user_key} ;;
  }

  join: issuereporter {
    relationship: many_to_one
    sql_on: ${jiraissue.reporter} = ${issuereporter.user_key} ;;
  }

  join: resolution {
    relationship: many_to_one
    sql_on: ${jiraissue.resolution} = ${resolution.id} ;;
  }

  join: issuetype {
    relationship: many_to_one
    sql_on: ${jiraissue.issuetype} = ${issuetype.id} ;;
  }

  join: issuestatus {
    relationship: many_to_one
    sql_on: ${jiraissue.issuestatus} = ${issuestatus.id} ;;
  }

  join: last_status_update {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${last_status_update.issue_id} ;;
  }

  join: priority {
    relationship: many_to_one
    sql_on: ${jiraissue.priority} = ${priority.id} ;;
  }

  join: epic {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${epic.issue_id}  ;;
  }

  join: linked_issue_epic {
    relationship: one_to_many
    sql_on: ${linked_issue.linked_issue_id} = ${linked_issue_epic.linked_issue_id}  ;;
  }

  join: issue_completion {
    relationship: one_to_many
    type: left_outer
    sql_on: ${jiraissue.id} = ${issue_completion.id} ;;
  }

  join: linked_issue {
    relationship: many_to_one
    sql_on: ${jiraissue.id} = ${linked_issue.issue_id} ;;
  }

  join: jiraissue_root_cause {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${jiraissue_root_cause.issue_id} ;;
  }

  join: customfieldvalue_child_issues {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_child_issues.issue_id};;
  }

  join: supp_info {
    relationship: many_to_one
    type: left_outer
    sql_on: ${jiraissue.id} = ${supp_info.issue_id}  ;;
  }

  join: fix_version {
    relationship: many_to_one
    type: left_outer
    sql_on: ${jiraissue.id} = ${fix_version.issue_id};;
  }

  join: comments {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${comments.issue_id} ;;
  }

  join: external_comments {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${external_comments.issue_id} ;;
  }

  join: median_response {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${median_response.issue_id} ;;
  }

  join: label {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${label.issue};;
  }

  join: workflow_history {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${workflow_history.issue_id} ;;
  }

  join: tag {
    relationship: one_to_many
    sql_on: ${tag.id} = ${jiraissue.id} ;;
  }

  join: li_tag {
    relationship: one_to_many
    sql_on: ${linked_issue.linked_issue_id} = ${li_tag.id} ;;
  }

  join: roadmap_pfs {
    relationship: one_to_many
    sql_on: ${roadmap_pfs.issue_id} = ${jiraissue.id} ;;
  }

  join: customfieldvalue_organization {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_organization.issue} and ${customfieldvalue_organization.customfield} = 15943 ;;
  }

  join: organization {
    relationship: many_to_one
    sql_on: ${customfieldvalue_organization.customvalue_id} = ${organization.id} ;;
  }

  join: customfieldvalue_tier_1_resolution_reason_code {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_tier_1_resolution_reason_code.issue} and ${customfieldvalue_tier_1_resolution_reason_code.customfield} = 16449 ;;
  }

  join: tier_1_resolution_reason_code {
    relationship: many_to_one
    sql_on: ${customfieldvalue_tier_1_resolution_reason_code.customvalue_id} = ${tier_1_resolution_reason_code.id}::text ;;
  }

  join: customfieldvalue_category {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_category.issue} and ${customfieldvalue_category.customfield} = 12957 ;;
  }

  join: category {
    relationship: many_to_one
    sql_on: ${customfieldvalue_category.customvalue_id} = ${category.id}::text ;;
  }

  join: customfieldvalue_satisfaction {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_satisfaction.issue} and ${customfieldvalue_satisfaction.customfield} = 15944 ;;
  }

  join: customfieldvalue_ticket_acknowledgement_sla {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_ticket_acknowledgement_sla.issue} and ${customfieldvalue_ticket_acknowledgement_sla.customfield} = 16450 ;;
  }

  join: customfieldvalue_itv_time_to_acknowledge_sla {
    from: jira_customfield
    view_label: "ITV Time to Acknowledge SLA (TTS)"
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_itv_time_to_acknowledge_sla.issue_id} AND ${customfieldvalue_itv_time_to_acknowledge_sla.sla_id} =15 ;;
  }

  join: jira_priority_history {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${jira_priority_history.issue_id} ;;
  }

  join: customfieldvalue_customer_request_type {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_customer_request_type.issue} and ${customfieldvalue_customer_request_type.customfield} = 13040 ;;
  }

  join: viewportform {
    relationship: many_to_many
    sql_on: ${viewportform.key} = substring(${customfieldvalue_customer_request_type.customvalue_id}, position('/' in ${customfieldvalue_customer_request_type.customvalue_id}) + 1) ;;
  }

  join: customfieldvalue_pdi_team {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_pdi_team.issue} and ${customfieldvalue_pdi_team.customfield} = 16251 ;;
  }

  join: pdi_team {
    relationship: many_to_one
    sql_on: ${customfieldvalue_pdi_team.customvalue_id} = ${pdi_team.id}::text ;;
  }

  join: portfolio_person {
    relationship: many_to_one
    sql_on: ${issueassignee.assignee_email} = ${portfolio_person.jira_user_id};;
  }

  join: portfolio_resource {
    relationship: many_to_one
    sql_on: ${portfolio_resource.person_id} = ${portfolio_person.id};;
  }

  join: portfolio_team {
    relationship: many_to_one
    sql_on: ${portfolio_resource.team_id} = ${portfolio_team.id};;
  }

  join: portfolio_plan_team {
    relationship: one_to_many
    sql_on: ${portfolio_team.id} = ${portfolio_plan_team.team_id} ;;
  }

  join: portfolio_plan_by_team {
    relationship: one_to_many
    sql_on: ${portfolio_plan_team.plan_id} = ${portfolio_plan_by_team.id} ;;
  }

  join: portfolio_program_by_team {
    relationship: one_to_many
    sql_on: ${portfolio_plan_by_team.program_id} = ${portfolio_program_by_team.id} ;;
  }

  join: portfolio_project_child_issues  {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${portfolio_project_child_issues.issue_id} ;;
  }

  join: portfolio_project {
    relationship: one_to_many
    sql_on: ${portfolio_project_child_issues.portfolio_project_id} = ${portfolio_project.id} ;;
  }

  join: portfolio_project_status {
    relationship: many_to_one
    sql_on: ${portfolio_project.issuestatus} = ${portfolio_project_status.id} ;;
  }

  join: customfieldvalue_pod {
    relationship: one_to_many
    sql_on: ${customfieldvalue_pod.issue_id} = ${jiraissue.id} ;;
  }

  join: portfolio_plan {
    relationship: one_to_many
    sql_on: ${customfieldvalue_pod.pod_id}::int = ${portfolio_plan.id} ;;
  }

  join: portfolio_program {
    relationship: one_to_many
    sql_on: ${portfolio_plan.program_id} = ${portfolio_program.id} ;;
  }

  join: customfieldvalue_project_alpha_date {
    relationship: one_to_many
    sql_on: ${portfolio_project_child_issues.portfolio_project_id} = ${customfieldvalue_project_alpha_date.issue} and ${customfieldvalue_project_alpha_date.customfield} = 16187 ;;
  }

  join: customfieldvalue_project_eta_start {
    relationship: one_to_many
    sql_on: ${portfolio_project_child_issues.portfolio_project_id} = ${customfieldvalue_project_eta_start.issue} and ${customfieldvalue_project_eta_start.customfield} = 20640 ;;
  }

  join: customfieldvalue_project_eta_end {
    relationship: one_to_many
    sql_on: ${portfolio_project_child_issues.portfolio_project_id} = ${customfieldvalue_project_eta_end.issue} and ${customfieldvalue_project_eta_end.customfield} = 15822 ;;
  }

  join: portfolio_project_entity_property {
    relationship: one_to_many
    sql_on: ${portfolio_project.id} = ${portfolio_project_entity_property.entity_id} and ${portfolio_project_entity_property.property_key}  = 'jpo-issue-properties' ;;
  }

  join: portfolio_pods_by_issue {
    relationship: one_to_many
    sql_on: ${portfolio_project.id} = ${portfolio_pods_by_issue.issue_id} ;;
  }

  join: portfolio_pods_by_person {
    relationship: one_to_many
    sql_on: ${portfolio_person.id} = ${portfolio_pods_by_person.person_id} ;;
  }

  join: customfieldvalue_eta_start {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_eta_start.issue} and ${customfieldvalue_eta_start.customfield} = 20640 ;;
  }

  join: customfieldvalue_eta_end {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_eta_end.issue} and ${customfieldvalue_eta_end.customfield} = 15822 ;;
  }

  join: customfieldvalue_loe {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_loe.issue} and ${customfieldvalue_loe.customfield} = 15745 ;;
  }

  join: customfieldvalue_resolution_team {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_resolution_team.issue} and ${customfieldvalue_resolution_team.customfield} = 19956 ;;
  }

  join: resolution_team {
    relationship: many_to_one
    sql_on: ${customfieldvalue_resolution_team.customvalue_id} = ${resolution_team.id}::text ;;
  }

  join: customfieldvalue_resolution_group {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_resolution_group.issue} and ${customfieldvalue_resolution_group.customfield} = 20041 ;;
  }

  join: resolution_group {
    relationship: many_to_one
    sql_on: ${customfieldvalue_resolution_group.customvalue_id} = ${resolution_group.id}::text ;;
  }

  join: customfieldvalue_tier_2_assignee {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_tier_2_assignee.issue} and ${customfieldvalue_tier_2_assignee.customfield} = 19657 ;;
  }

  join: tier_2_assignee {
    relationship: many_to_one
    sql_on: ${customfieldvalue_tier_2_assignee.customvalue_id} = ${tier_2_assignee.user_key} ;;
  }

  join: nodeassociation_issuecomponent {
    from: nodeassociation
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${nodeassociation_issuecomponent.source_node_id} and ${nodeassociation_issuecomponent.association_type} = 'IssueComponent' ;;
  }

  join: component {
    relationship: many_to_one
    sql_on: ${nodeassociation_issuecomponent.sink_node_id} = ${component.id} ;;
  }

  join: components {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${components.issue_id} ;;
  }

  join: customfieldvalue_t_shirt_size {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_t_shirt_size.issue} and ${customfieldvalue_t_shirt_size.customfield} = 15740 ;;
  }

  join: t_shirt_size {
    relationship: many_to_one
    sql_on: ${customfieldvalue_t_shirt_size.customvalue_id} = ${t_shirt_size.id}::text ;;
  }

  join: customfieldvalue_high_visibility {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_high_visibility.issue} and ${customfieldvalue_high_visibility.customfield} = 23040 ;;
  }

  join: high_visibility {
    relationship: many_to_one
    sql_on: ${customfieldvalue_high_visibility.customvalue_id} = ${high_visibility.id}::text ;;
  }

  join: customfieldvalue_itv_resolution_v1_benchmark {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_itv_resolution_v1_benchmark.issue} and ${customfieldvalue_itv_resolution_v1_benchmark.customfield} = 18041 ;;
  }

  join: customfieldvalue_itv_resolution_v2_benchmark {
    from: jira_customfield
    view_label: "ITV Resolution SLA - V2 Benchmark (TTS)"
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_itv_resolution_v2_benchmark.issue_id} AND ${customfieldvalue_itv_resolution_v2_benchmark.sla_id} = 14 ;;
  }

  join: customfieldvalue_customer_priority {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_customer_priority.issue} and ${customfieldvalue_customer_priority.customfield} = 20242 ;;
  }

  join: customer_priority {
    relationship: many_to_one
    sql_on: ${customfieldvalue_customer_priority.customvalue_id} = ${customer_priority.id}::text ;;
  }

  join: customfieldvalue_minutes_spent {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_minutes_spent.issue} and ${customfieldvalue_minutes_spent.customfield} = 18351 ;;
  }

  join: total_minutes_spent {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${total_minutes_spent.issue_id} ;;
  }

  join: customfieldvalue_automated_time_spent {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_automated_time_spent.issue} and ${customfieldvalue_automated_time_spent.customfield} = 22941 ;;
  }

  join: customfieldvalue_days {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_days.issue} and ${customfieldvalue_days.customfield} = 16191 ;;
  }

  join: customfieldvalue_remaining {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_remaining.issue} and ${customfieldvalue_remaining.customfield} = 10044 ;;
  }

  join: quarter {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${quarter.issue} and ${quarter.customfield} = 20341 ;;
  }

  join: jira_customfieldvalue_apssd_bell_acknowledge_sla {
    from: jira_customfield
    view_label: "Bell Acknowledge SLA (TTS)"
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${jira_customfieldvalue_apssd_bell_acknowledge_sla.issue_id} AND ${jira_customfieldvalue_apssd_bell_acknowledge_sla.sla_id} = 3 ;;
  }

  join: jira_customfieldvalue_apssd_bell_resolution_sla {
    from: jira_customfield
    view_label: "Bell Resolution SLA (TTS)"
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${jira_customfieldvalue_apssd_bell_resolution_sla.issue_id} AND ${jira_customfieldvalue_apssd_bell_resolution_sla.sla_id} = 4 ;;
  }

  join: jira_customfieldvalue_apssd_default_acknowledge_sla {
    from: jira_customfield
    view_label: "Default Acknowledge SLA (TTS)"
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${jira_customfieldvalue_apssd_default_acknowledge_sla.issue_id} AND ${jira_customfieldvalue_apssd_default_acknowledge_sla.sla_id} = 64 ;;
  }

  join: jira_customfieldvalue_apssd_default_resolution_sla {
    from: jira_customfield
    view_label: "Default Resolution SLA (TTS)"
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${jira_customfieldvalue_apssd_default_resolution_sla.issue_id} AND ${jira_customfieldvalue_apssd_default_resolution_sla.sla_id} = 65 ;;
  }

  join: jira_customfieldvalue_apssd_disney_acknowledge_sla {
    from: jira_customfield
    view_label: "Disney Acknowledge SLA (TTS)"
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${jira_customfieldvalue_apssd_disney_acknowledge_sla.issue_id} AND ${jira_customfieldvalue_apssd_disney_acknowledge_sla.sla_id} = 66 ;;
  }

  join: jira_customfieldvalue_apssd_disney_resolution_sla {
    from: jira_customfield
    view_label: "Disney Resolution SLA (TTS)"
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${jira_customfieldvalue_apssd_disney_resolution_sla.issue_id} AND ${jira_customfieldvalue_apssd_disney_resolution_sla.sla_id} = 67 ;;
  }

  join: jira_customfieldvalue_apssd_mediacorp_acknowledge_sla {
    from: jira_customfield
    view_label: "Mediacorp Acknowledge SLA (TTS)"
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${jira_customfieldvalue_apssd_mediacorp_acknowledge_sla.issue_id} AND ${jira_customfieldvalue_apssd_mediacorp_acknowledge_sla.sla_id} = 68 ;;
  }

  join: jira_customfieldvalue_apssd_mediacorp_resolution_sla {
    from: jira_customfield
    view_label: "Mediacorp Resolution SLA (TTS)"
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${jira_customfieldvalue_apssd_mediacorp_resolution_sla.issue_id} AND ${jira_customfieldvalue_apssd_mediacorp_resolution_sla.sla_id} = 69 ;;
  }

  join: jira_customfieldvalue_apssd_yahoo_resolution_sla {
    from: jira_customfield
    view_label: "Yahoo Resolution SLA (TTS)"
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${jira_customfieldvalue_apssd_yahoo_resolution_sla.issue_id} AND ${jira_customfieldvalue_apssd_yahoo_resolution_sla.sla_id} = 70 ;;
  }

  join: jira_tts_itv_resolution_sla {
    from: jira_customfield
    view_label: "ITV Resolution SLA (TTS)"
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${jira_tts_itv_resolution_sla.issue_id} AND ${jira_tts_itv_resolution_sla.sla_id} = 71 ;;
  }

  join:jira_tts_time_to_sla {
    from: jira_customfield
    view_label: "Time to SLA (All)"
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${jira_tts_time_to_sla.issue_id} ;;
  }

  join: customfieldvalue_sub_type {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_sub_type.issue} and ${customfieldvalue_sub_type.customfield} = 18353 ;;
  }

  join: sub_type {
    relationship: many_to_one
    view_label: "Custom Fields"
    sql_on: ${customfieldvalue_sub_type.customvalue_id} = ${sub_type.id}::text ;;
  }

  join: platform_market {
    view_label: "Custom Fields"
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${platform_market.issue} ;;
  }

  join: customfieldvalue_tech_support_ticket {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_tech_support_ticket.issue} and ${customfieldvalue_tech_support_ticket.customfield} = 23441 ;;
  }

  join: tech_support_ticket {
    relationship: many_to_one
    view_label: "Custom Fields"
    sql_on: ${customfieldvalue_tech_support_ticket.customvalue_id} = ${tech_support_ticket.id}::text ;;
  }

  join: customfieldvalue_is_good_bad_escalation {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_is_good_bad_escalation.issue} and ${customfieldvalue_is_good_bad_escalation.customfield} = 23443 ;;
  }

  join: is_good_bad_escalation {
    relationship: many_to_one
    view_label: "Custom Fields"
    sql_on: ${customfieldvalue_is_good_bad_escalation.customvalue_id} = ${is_good_bad_escalation.id}::text ;;
  }

  join: customfieldvalue_resolution_steps {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${customfieldvalue_resolution_steps.issue} and ${customfieldvalue_resolution_steps.customfield} = 22942 ;;
  }

  join: customfieldvalue_incident_start_date {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${customfieldvalue_incident_start_date.issue} and ${customfieldvalue_incident_start_date.customfield} = 23442 ;;
  }

  join: customfieldvalue_product_area {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_product_area.issue} and ${customfieldvalue_product_area.customfield} = 19348 ;;
  }

  join: product_area {
    relationship: many_to_one
    view_label: "Custom Fields"
    sql_on: ${customfieldvalue_product_area.customvalue_id} = ${product_area.id}::text ;;
  }

  join: customfieldvalue_which_platform {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_which_platform.issue} and ${customfieldvalue_which_platform.customfield} = 18173 ;;
  }

  join: which_platform {
    relationship: many_to_one
    view_label: "Custom Fields"
    sql_on: ${customfieldvalue_which_platform.customvalue_id} = ${which_platform.id}::text ;;
  }

  join: insight_object_email {
    relationship: many_to_one
    sql_on: upper(${insight_object_email.email}) = upper(${issueassignee.assignee_email}) ;;
  }

  join: insight_object {
    relationship: many_to_one
    sql_on: ${insight_object.id} = ${insight_object_email.object_id} ;;
  }

  join: insight_object_team {
    relationship: many_to_one
    sql_on: ${insight_object_team.object_id} = ${insight_object_email.object_id} ;;
  }

  join: insight_object_vendor {
    relationship: many_to_one
    sql_on: ${insight_object_vendor.object_id} = ${insight_object_email.object_id} ;;
  }

  join: insight_object_status {
    relationship: many_to_one
    sql_on:${insight_object_status.object_id} = ${insight_object_email.object_id} ;;
  }
}

explore: pf_resource_sheet {}

explore: portfolio_plan {
  label: "JIRA POD"
  persist_for: "10 minutes"

  join: portfolio_program {
    relationship: many_to_one
    sql_on: ${portfolio_plan.program_id} = ${portfolio_program.id} ;;
  }

  join: portfolio_plan_team {
    relationship: one_to_many
    sql_on: ${portfolio_plan.id} = ${portfolio_plan_team.plan_id} ;;
  }

  join: portfolio_team {
    relationship: one_to_many
    sql_on: ${portfolio_plan_team.team_id} = ${portfolio_team.id} ;;
  }

  join: portfolio_resource {
    relationship: many_to_one
    sql_on: ${portfolio_team.id} = ${portfolio_resource.team_id};;
  }

  join: portfolio_person {
    relationship: many_to_one
    sql_on: ${portfolio_resource.person_id} = ${portfolio_person.id};;
  }

  join: team_members {
    relationship: one_to_many
    sql_on: ${portfolio_person.jira_user_id} = ${team_members.user_key};;
  }

  join: customfieldvalue_pod {
    relationship: one_to_one
    sql_on: ${portfolio_plan.id} = ${customfieldvalue_pod.pod_id}::int ;;
  }

  join: portfolio_resource_by_assignee  {
    relationship: many_to_one
    sql_on: ${portfolio_resource_by_assignee.team_id} = ${portfolio_team.id} ;;
  }

  join: portfolio_person_by_assignee  {
    relationship: many_to_one
    sql_on: ${portfolio_resource_by_assignee.person_id} = ${portfolio_person_by_assignee.id} ;;
  }

  join: jiraissue {
    relationship: many_to_one
    sql_on: ${customfieldvalue_pod.issue_id} = ${jiraissue.id} ;;
  }

  join: portfolio_assignee {
    relationship: many_to_one
    sql_on: ${portfolio_assignee.user_key} = ${jiraissue.assignee} OR ${portfolio_assignee.user_key} = ${portfolio_person.jira_user_id} ;;
  }

  join: issueassignee {
    relationship: one_to_one
    sql_on: ${jiraissue.assignee} = ${issueassignee.user_key} ;;
  }

  join: issuestatus {
    relationship: many_to_one
    sql_on: ${jiraissue.issuestatus} = ${issuestatus.id} ;;
  }

  join: last_status_update {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${last_status_update.issue_id} ;;
  }

  join: project {
    relationship: many_to_one
    sql_on: ${jiraissue.project} = ${project.id} ;;
  }

  join: supp_info {
    relationship: many_to_one
    type: left_outer
    sql_on: ${jiraissue.id} = ${supp_info.issue_id}  ;;
  }

  join: linked_issue {
    relationship: many_to_one
    sql_on: ${jiraissue.id} = ${linked_issue.issue_id} ;;
  }

  join: jiraissue_root_cause {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${jiraissue_root_cause.issue_id} ;;
  }

  join: issuetype {
    relationship: many_to_one
    sql_on: ${jiraissue.issuetype} = ${issuetype.id} ;;
  }

  join: customfieldvalue_alpha_date {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${customfieldvalue_alpha_date.issue} and ${customfieldvalue_alpha_date.customfield} = 16187 ;;
  }

  join: customfieldvalue_beta_date {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${customfieldvalue_beta_date.issue} and ${customfieldvalue_beta_date.customfield} = 16188 ;;
  }

  join: customfieldvalue_ga_date {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${customfieldvalue_ga_date.issue} and ${customfieldvalue_ga_date.customfield} = 16189 ;;
  }

  join: status_update {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${status_update.issue_id} ;;
  }

  join: customfieldvalue_days {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${customfieldvalue_days.issue} and ${customfieldvalue_days.customfield} = 16191 ;;
  }

  join: customfieldvalue_rag_status {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${customfieldvalue_rag_status.issue} and ${customfieldvalue_rag_status.customfield} = 20244 ;;
  }

  join: customfieldvalue_status_summary {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${customfieldvalue_status_summary.issue} and ${customfieldvalue_status_summary.customfield} = 17747 ;;
  }

  join: customfieldvalue_technical_program_manager {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${customfieldvalue_technical_program_manager.issue} and ${customfieldvalue_technical_program_manager.customfield} = 17740 ;;
  }

  join: technical_program_manager {
    relationship: one_to_one
    sql_on: ${customfieldvalue_technical_program_manager.manager_email} = ${technical_program_manager.user_email} ;;
  }

  join: customfieldvalue_child_issues {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_child_issues.issue_id};;
  }

  join: customfieldvalue_t_shirt_size {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_t_shirt_size.issue} and ${customfieldvalue_t_shirt_size.customfield} = 15740 ;;
  }

  join: t_shirt_size {
    relationship: many_to_one
    sql_on: ${customfieldvalue_t_shirt_size.customvalue_id} = ${t_shirt_size.id}::text ;;
  }

  join: customfieldvalue_high_visibility {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_high_visibility.issue} and ${customfieldvalue_high_visibility.customfield} = 23040 ;;
  }

  join: high_visibility {
    relationship: many_to_one
    sql_on: ${customfieldvalue_high_visibility.customvalue_id} = ${high_visibility.id}::text ;;
  }

  join: insight_object_email {
    relationship: many_to_one
    sql_on: upper(${insight_object_email.email}) = upper(${portfolio_assignee.assignee_email}) ;;
  }

  join: insight_object {
    relationship: one_to_many
    type: full_outer
    sql_on: ${insight_object.id} = ${insight_object_email.object_id} ;;
  }

  join: insight_object_team {
    relationship: many_to_one
    sql_on: ${insight_object_team.object_id} = ${insight_object_email.object_id} ;;
  }

  join: insight_object_vendor {
    relationship: many_to_one
    sql_on: ${insight_object_vendor.object_id} = ${insight_object_email.object_id} ;;
  }

  join: insight_object_status {
    relationship: many_to_one
    sql_on: ${insight_object_status.object_id} = ${insight_object_email.object_id} ;;
  }
}

explore: insight_object {
  label: "JIRA Employee DB"
  persist_for: "10 minutes"

  join: insight_object_email {
    relationship: many_to_one
    sql_on: ${insight_object.id} = ${insight_object_email.object_id} ;;
  }

  join: insight_object_team {
    relationship: many_to_one
    sql_on: ${insight_object_team.object_id} = ${insight_object.id} ;;
  }

  join: insight_object_type {
    relationship: many_to_one
    sql_on: ${insight_object_type.object_id} = ${insight_object.id} ;;
  }

  join: insight_object_vendor {
    relationship: many_to_one
    sql_on: ${insight_object_vendor.object_id} = ${insight_object.id} ;;
  }

  join: insight_object_status {
    relationship: many_to_one
    sql_on:${insight_object_status.object_id} = ${insight_object.id} ;;
  }

  join: insight_object_start_date {
    relationship: many_to_one
    sql_on:${insight_object_start_date.object_id} = ${insight_object.id} ;;
  }

  join: insight_object_termination_date {
    relationship: many_to_one
    sql_on:${insight_object_termination_date.object_id} = ${insight_object.id} ;;
  }

  join: customfieldvalue_pod {
    relationship: one_to_one
    sql_on: ${customfieldvalue_pod.issue_id} = ${jiraissue.id} ;;
  }

  join: issue_pod {
    relationship: many_to_one
    sql_on: ${customfieldvalue_pod.pod_id}::int = ${issue_pod.id} ;;
  }

  join: portfolio_person {
    relationship: one_to_one
    sql_on: ${portfolio_assignee.user_key} = ${portfolio_person.jira_user_id};;
  }

  join: portfolio_resource {
    relationship: many_to_one
    sql_on: ${portfolio_resource.person_id} = ${portfolio_person.id};;
  }

  join: portfolio_team {
    relationship: one_to_many
    sql_on: ${portfolio_team.id} = ${portfolio_resource.team_id} ;;
  }

  join: portfolio_plan_team {
    relationship: one_to_one
    sql_on: ${portfolio_plan_team.team_id} = ${portfolio_team.id} ;;
  }

  join: portfolio_plan {
    relationship: many_to_one
    sql_on: ${portfolio_plan.id} = ${portfolio_plan_team.plan_id} ;;
  }

  join: employee_pod {
    relationship: many_to_one
    sql_on: ${employee_pod.id} = ${issue_pod.id} OR ${employee_pod.id} = ${portfolio_plan.id} ;;
  }

  join: portfolio_program {
    relationship: many_to_one
    sql_on: ${portfolio_program.id} = ${portfolio_plan.program_id} ;;
  }

  join: portfolio_pods_by_person {
    relationship: many_to_one
    sql_on: ${portfolio_pods_by_person.person_id} = ${portfolio_person.id}  ;;
  }

  join: jiraissue {
    relationship: many_to_one
    sql_on: ${jiraissue.assignee} = ${portfolio_assignee.user_key} ;;
  }

  join: issueassignee {
    relationship: many_to_one
    sql_on: ${jiraissue.assignee} = ${issueassignee.user_key} ;;
  }

  join: project {
    relationship: many_to_one
    sql_on: ${jiraissue.project} = ${project.id} ;;
  }

  join: issuestatus {
    relationship: many_to_one
    sql_on: ${jiraissue.issuestatus} = ${issuestatus.id} ;;
  }

  join: status_update {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${status_update.issue_id} ;;
  }

  join: customfieldvalue_days {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${customfieldvalue_days.issue} and ${customfieldvalue_days.customfield} = 16191 ;;
  }

  join: customfieldvalue_project_alpha_date {
    relationship: one_to_many
    sql_on: ${portfolio_project_child_issues.portfolio_project_id} = ${customfieldvalue_project_alpha_date.issue} and ${customfieldvalue_project_alpha_date.customfield} = 16187 ;;
  }

  join: portfolio_project_child_issues  {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${portfolio_project_child_issues.issue_id} ;;
  }

  join: last_status_update {
    relationship: one_to_one
    sql_on: ${jiraissue.id} = ${last_status_update.issue_id} ;;
  }

  join: portfolio_project {
    relationship: one_to_many
    sql_on: ${portfolio_project_child_issues.portfolio_project_id} = ${portfolio_project.id} ;;
  }

  join: portfolio_project_status {
    relationship: many_to_one
    sql_on: ${portfolio_project.issuestatus} = ${portfolio_project_status.id} ;;
  }

  join: portfolio_project_entity_property {
    relationship: one_to_many
    sql_on: ${portfolio_project.id} = ${portfolio_project_entity_property.entity_id} and ${portfolio_project_entity_property.property_key}  = 'jpo-issue-properties' ;;
  }

  join: portfolio_assignee {
    relationship: one_to_one
    sql_on: ${insight_object_email.email} = ${portfolio_assignee.assignee_email} ;;
  }

  join: portfolio_resource_by_assignee  {
    relationship: many_to_one
    sql_on: ${portfolio_resource_by_assignee.team_id} = ${portfolio_team.id} ;;
  }

  join: portfolio_person_by_assignee  {
    relationship: many_to_one
    sql_on: ${portfolio_resource_by_assignee.person_id} = ${portfolio_person_by_assignee.id} ;;
  }

  join: team_members {
    relationship: one_to_many
    sql_on: ${portfolio_person.jira_user_id} = ${team_members.user_key};;
  }

  join: resolution {
    relationship: many_to_one
    sql_on: ${jiraissue.resolution} = ${resolution.id} ;;
  }

  join: workflow_history {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${workflow_history.issue_id} ;;
  }

  join: portfolio_pods_by_issue {
    relationship: one_to_many
    sql_on: ${portfolio_project.id} = ${portfolio_pods_by_issue.issue_id} ;;
  }

  join: supp_info {
    relationship: many_to_one
    type: left_outer
    sql_on: ${jiraissue.id} = ${supp_info.issue_id}  ;;
  }

  join: linked_issue {
    relationship: many_to_one
    sql_on: ${jiraissue.id} = ${linked_issue.issue_id} ;;
  }

  join: customfieldvalue_child_issues {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_child_issues.issue_id};;
  }

  join: t_shirt_size {
    relationship: many_to_one
    sql_on: ${customfieldvalue_t_shirt_size.customvalue_id} = ${t_shirt_size.id}::text ;;
  }

  join: customfieldvalue_t_shirt_size {
    from: customfieldvalue_stringvalue
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_t_shirt_size.issue} and ${customfieldvalue_t_shirt_size.customfield} = 15740 ;;
  }

  join: customfieldvalue_automated_time_spent {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${customfieldvalue_automated_time_spent.issue} and ${customfieldvalue_automated_time_spent.customfield} = 22941 ;;
  }

  join: jiraissue_root_cause {
    relationship: one_to_many
    sql_on: ${jiraissue.id} = ${jiraissue_root_cause.issue_id} ;;
  }

  join: issuecreator {
    relationship: many_to_one
    sql_on: ${jiraissue.creator} = ${issuecreator.user_key} ;;
  }
}
