view: supp_info {
  derived_table: {
    sql:  select distinct
  ji.id,
  rcd.textvalue as root_cause_details,
 rootoption.customvalue as root_cause,
 catoption.customvalue as category,
 acoption.customvalue as application_component,
   areaoption.customvalue as area,
  acp.textvalue as action_plan,
  fcoption.customvalue as fix_category,
  rcoption.customvalue as resolution_reason_code,
  regionoption.customvalue as region,
  rootcauseoption.customvalue as root_cause_application,
  rroption.customvalue as resolution_reason,
  sprintoption."NAME" as sprint

from jiraissue ji
left join customfieldvalue rcd on ji.id = rcd.issue and rcd.customfield = 15788
left join customfieldvalue acp on ji.id = acp.issue and acp.customfield = 15803
left join customfieldvalue rootcause on ji.id = rootcause.issue and rootcause.customfield = 15787
left join customfieldoption rootoption on rootcause.stringvalue = cast(rootoption.id as varchar(32))
left join customfieldvalue category on ji.id = category.issue and category.customfield = 15779
left join customfieldoption catoption on category.stringvalue = cast(catoption.id as varchar(32))
left join customfieldvalue appcomp on ji.id = appcomp.issue and appcomp.customfield = 15802
left join customfieldoption acoption on appcomp.stringvalue = cast(acoption.id as varchar(32))
left join customfieldvalue area on ji.id = area.issue and area.customfield = 15789
left join customfieldoption areaoption on area.stringvalue = cast(areaoption.id as varchar(32))
left join customfieldvalue fixcat on ji.id = fixcat.issue and fixcat.customfield = 15801
left join customfieldoption fcoption on fixcat.stringvalue = cast(fcoption.id as varchar(32))
left join customfieldvalue rescodecat on ji.id = rescodecat.issue and rescodecat.customfield = 16140
left join customfieldoption rcoption on rescodecat.stringvalue = cast(rcoption.id as varchar(32))
left join customfieldvalue regioncat on ji.id = regioncat.issue and regioncat.customfield = 12940
left join customfieldoption regionoption on regioncat.stringvalue = cast(regionoption.id as varchar(32))
left join customfieldvalue rootcausecat on ji.id = rootcausecat.issue and rootcausecat.customfield = 15845
left join customfieldoption rootcauseoption on rootcausecat.stringvalue = cast(rootcauseoption.id as varchar(32))
left join customfieldvalue resrsn on ji.id = resrsn.issue and resrsn.customfield = 15754
left join customfieldoption rroption on resrsn.stringvalue = cast(rroption.id as varchar(32))
left join customfieldvalue sprintcat on ji.id = sprintcat.issue and sprintcat.customfield = 10941
left join "AO_60DB71_SPRINT" sprintoption on sprintcat.stringvalue = cast(sprintoption."ID" as varchar(32));;
  }

  dimension: issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: root_cause_details {
    type: string
    view_label: "Issue"
    label: "Root Cause Details"
    description: "Details on the root cause of the issue as recorded within the JIRA Issue."
    sql: ${TABLE}.root_cause_details ;;
    }

  dimension: root_cause {
    type: string
    view_label: "Issue"
    label: "Root Cause"
    description: "The selected root cause of the issue as recorded within the JIRA Issue."
    sql: ${TABLE}.root_cause ;;
  }

  dimension: category {
    type: string
    view_label: "Issue"
    label: "Issue Category"
    description: "The selected category of the JIRA Issue."
    sql: ${TABLE}.category ;;
  }

  dimension: application_component {
    type: string
    view_label: "Issue"
    label: "Application Component"
    description: "The applciation component as selected in the JIRA Issue."
    sql: ${TABLE}.application_component ;;
  }

  dimension: area {
    type: string
    view_label: "Issue"
    label: "Area"
    description: "The area as selected in the JIRA Issue."
    sql: ${TABLE}.area ;;
  }

  dimension: action_plan {
    type: string
    view_label: "Issue"
    label: "Action Plan"
    description: "Details on the action plan as recorded within the JIRA Issue."
    sql: ${TABLE}.action_plan ;;
  }

  dimension: fix_category {
    type: string
    view_label: "Issue"
    label: "Fix Cateogry"
    description: "The fix as selected in the JIRA Issue."
    sql: ${TABLE}.fix_category ;;
  }

  dimension: resolution_reason_code {
    type: string
    view_label: "Issue"
    label: "Resolution Reason Code"
    description: "The resolution reason code as selected in the JIRA Issue."
    sql: ${TABLE}.resolution_reason_code ;;
  }

  dimension: region {
    type: string
    view_label: "Issue"
    label: "Region"
    description: "The region as selected in the JIRA Issue."
    sql: ${TABLE}.region ;;
  }

  dimension: root_cause_application {
    type: string
    label: "Root Cause Application"
    view_label: "Issue"
    description: "The root cause application of the platform communication."
    sql: ${TABLE}.root_cause_application ;;
  }

  dimension: resolution_reason {
    type: string
    label: "Resolution Reason"
    view_label: "Issue"
    description: "The resolution reason as selected in the JIRA issue"
    sql: ${TABLE}.resolution_reason ;;
  }

  dimension: sprint {
    type: string
    label: "Sprint"
    view_label: "Issue"
    description: "The sprint as selected in the JIRA Issue."
    sql: ${TABLE}.sprint ;;
  }

  }
