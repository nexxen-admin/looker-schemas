view: partner {
  sql_table_name: AN_MAIN..partner (NOLOCK) ;;
  label: "Publisher"

  dimension: partner_id {
    primary_key: yes
    type: number
    label: "Publisher ID"
    description: "The internal identifier of the Publisher."
    sql: ${TABLE}.partner_id ;;
    value_format_name: id
  }

  dimension: accounting_subsidiary_id {
    type: number
    hidden: yes
    sql: ${TABLE}.accounting_subsidiary_id ;;
  }

  dimension: active {
    type: yesno
    label: "Publisher Active"
    description: "A yes/no indicator if the publisher is currently active."
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: addr_line1 {
    type: string
    hidden: yes
    sql: ${TABLE}.addr_line1 ;;
  }

  dimension: addr_line2 {
    type: string
    hidden: yes
    sql: ${TABLE}.addr_line2 ;;
  }

  dimension: allow_reject_with_reservation {
    type: yesno
    label: "Publisher Allow Reject with Reservation"
    sql: ${TABLE}.allow_reject_with_reservation = 1 ;;
  }

  dimension: approval_notification_frequency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.approval_notification_frequency_id;;
  }

  dimension: approval_notify_on_flight_date_change {
    type: yesno
    label: "Publisher Approval Notify on Flight Date Change"
    description: "A yes/no indicator whether there is an approval notification update on flight date change."
    sql: ${TABLE}.approval_notify_on_flight_date_change = 1 ;;
  }

  dimension: approval_recipient {
    type: string
    label: "Approval Recipient"
    description: "List of Email Address associated to Publisher"
    sql: ${TABLE}.approval_recipient ;;
  }

  dimension: approval_review_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.Approval_review_type_id ;;
  }

  dimension: ad_approval_on_off_status {
    type: yesno
    label: "Ad Approval Enabled"
    sql: ${approval_review_type_id} != 1 ;;
  }

  dimension: approval_type_id {
    type: string
    label: "Publisher Approval Type"
    sql: CASE WHEN ${TABLE}.approval_type_id = 1 then 'None'
              WHEN ${TABLE}.approval_type_id = 2 then 'Creative'
              WHEN ${TABLE}.approval_type_id = 3 then 'Campaign & Creative'
              ElSE 'Other' END;;
    suggestions: ["None","Creative","Campaign & Creative","Other"]
  }

  dimension: business_region_id {
    type: number
    hidden: yes
    sql: ${TABLE}.business_region_id ;;
  }

  dimension: change_source {
    type: string
    hidden: yes
    sql: ${TABLE}.change_source ;;
  }

  dimension: changedby {
    type: string
    hidden: yes
    sql: ${TABLE}.changedby ;;
  }

  dimension_group: changedon {
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
    label: "Publisher Changed"
    description: "The date/time when publisher was changed."
    sql: ${TABLE}.changedon ;;
  }

  dimension_group: dst_changedon {
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
    label: "[DST] Publisher Local Changed"
    description: "The date/time when publisher was changed in local time (accounting DST - if this option is enabled for the Platform Client)."
    sql: case when ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_value} = 'True' then dateadd(hh, ${mssql_oltp_timezone_offset_partner_changed.utc_offset}, ${TABLE}.changedon)
      else ${TABLE}.changedon end ;;
  }

  dimension: city {
    type: string
    hidden: yes
    sql: ${TABLE}.city ;;
  }

  dimension: comscore_id {
    type: number
    hidden: yes
    sql: ${TABLE}.comscore_id ;;
  }

  dimension: contact_notes {
    type: string
    label: "Description"
    sql: ${TABLE}.contact_notes ;;
  }

  dimension: contracting_party_id {
    type: number
    hidden: yes
    sql: ${TABLE}.contracting_party_id ;;
  }

  dimension: country_id {
    type: number
    hidden: yes
    sql: ${TABLE}.country_id ;;
  }

  dimension: createdby {
    type: string
    hidden: yes
    sql: ${TABLE}.createdby ;;
  }

  dimension_group: createdon {
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
    label: "Publisher Created"
    description: "The date/time when publisher was created."
    sql: ${TABLE}.createdon ;;
  }

  dimension_group: dst_createdon {
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
    label: "[DST] Publisher Local Created"
    description: "The date/time when publisher was created in local time (accounting DST - if this option is enabled for the Platform Client)."
    sql: case when ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_value} = 'True' then dateadd(hh, ${mssql_oltp_timezone_offset_partner_created.utc_offset}, ${TABLE}.createdon)
      else ${TABLE}.createdon end;;
  }

  dimension: creative_format_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.creative_format_type_id ;;
  }

  dimension: default_exchange_fee {
    type: number
    label: "Transaction Fee"
    sql: ${TABLE}.default_exchange_fee ;;
  }

  dimension: default_usersync_uav {
    type: yesno
    hidden: yes
    sql: ${TABLE}.default_usersync_uav = 1 ;;
  }

  dimension: deliver_while_pending_approval {
    type: yesno
    label: "Run While Pending Approval?"
    sql: ${TABLE}.deliver_while_pending_approval = 1 ;;
  }

  dimension: delivery {
    type: string
    label: "Creative Delivery Format"
    sql: CASE WHEN ${approval_review_type_id} in (4, 5) THEN ${TABLE}.delivery
              ElSE NULL END ;;
  }

  dimension: email {
    type: string
    hidden: yes
    sql: ${TABLE}.email ;;
  }

  dimension: fax {
    type: string
    hidden: yes
    sql: ${TABLE}.fax ;;
  }

  dimension: global_msa {
    type: yesno
    label: "Global MSA"
    description: "A yes/no indicator if the publisher is a global MSA."
    sql: ${TABLE}.global_msa = 1 ;;
  }

  dimension: hostname {
    type: string
    hidden: yes
    sql: ${TABLE}.hostname ;;
  }

  dimension: is_videology_stats_billing {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_videology_stats_billing = 1 ;;
  }

  dimension: liability {
    type: yesno
    label: "Liability"
    description: "A yes/no indicator if the company has payment liablity."
    sql: ${TABLE}.liability = 1 ;;
  }

  dimension: office_id {
    type: number
    hidden: yes
    sql: ${TABLE}.office_id ;;
  }

  dimension: operator_id {
    type: number
    hidden: yes
    sql: ${TABLE}.operator_id ;;
  }

  dimension: parent_id {
    type: number
    hidden: yes
    sql: ${TABLE}.parent_id ;;
  }

  dimension: partner_alias {
    type: string
    hidden: yes
    sql: ${TABLE}.partner_alias ;;
  }

  dimension: partner_name {
    type: string
    label: "Publisher"
    description: "The name of the Publisher."
    sql: ${TABLE}.partner_name ;;
    suggest_explore: mssql_oltp_suggest_supply_ref
    suggest_dimension: mssql_oltp_suggest_supply_ref.partner_name
  }

  dimension: partner_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.partner_type_id ;;
  }

  dimension: phone {
    type: string
    hidden: yes
    sql: ${TABLE}.phone ;;
  }

  dimension: platform_client_id {
    type: number
    hidden: yes
    sql: ${TABLE}.platform_client_id ;;
  }

  dimension: postalcode {
    type: string
    hidden: yes
    sql: ${TABLE}.postalcode ;;
  }

  dimension: preferred_currency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.preferred_currency_id ;;
  }

  dimension: publisher_approval_level_id {
    type: number
    hidden: yes
    sql: ${TABLE}.publisher_approval_level_id ;;
  }

  dimension: ad_approval_placements {
    type: string
    label: "Ad Approval Placements"
    sql: CASE WHEN ${TABLE}.publisher_approval_level_id = 1 then 'Internal Exchange Placements'
              WHEN ${TABLE}.publisher_approval_level_id = 2 then 'All Placements'
              ElSE NULL END ;;
    suggestions: ["Internal Exchange Placements","All Placements"]
  }

  dimension: publisher_group_id {
    type: number
    hidden: yes
    sql: ${TABLE}.publisher_group_id ;;
  }

  dimension: publisher_payment_term_id {
    type: number
    hidden: yes
    sql: ${TABLE}.publisher_payment_term_id ;;
  }

  dimension: requires_min_sitelist_publisher {
    type: yesno
    label: "Min Pub Site List Restriction"
    sql: ${TABLE}.requires_min_sitelist_publisher = 1 ;;
  }

  dimension: set_brand_for_deal_creatives {
    type: yesno
    label: "Set Brand for Deal Creatives"
    sql: ${TABLE}.set_brand_for_deal_creatives = 1 ;;
  }

  dimension: ssp_member {
    type: yesno
    hidden: yes
    sql: ${TABLE}.ssp_member = 1 ;;
  }

  dimension: stateprovince {
    type: string
    hidden: yes
    sql: ${TABLE}.stateprovince ;;
  }

  dimension: taxid {
    type: string
    hidden: yes
    sql: ${TABLE}.taxid ;;
  }

  dimension: taxid2 {
    type: string
    hidden: yes
    sql: ${TABLE}.taxid2 ;;
  }

  dimension: taxid3 {
    type: string
    hidden: yes
    sql: ${TABLE}.taxid3 ;;
  }

  dimension: updatedby {
    type: string
    hidden: yes
    sql: ${TABLE}.updatedby ;;
  }

  dimension: w9_received {
    type: yesno
    hidden: yes
    sql: ${TABLE}.w9_received = 1 ;;
  }

  dimension: system_of_record_id {
    type: number
    hidden: yes
    sql: ${TABLE}.system_of_record_id ;;
  }

  dimension: tag_type {
    type: string
    label: "Tag Type"
    sql: CASE WHEN ${TABLE}.is_invtag = 1 then 'INV'
              ElSE 'VMM' END ;;
    suggestions: ["INV","VMM"]
  }

  dimension: legitimate_interest {
    type: yesno
    label: "Transparency Consent Framework Override"
    sql: ${TABLE}.legitimate_interest = 1 ;;
  }

  measure: count {
    type: count_distinct
    label: "Count of Publishers"
    description: "The distinct count of Publishers."
    sql: ${partner_id} ;;
  }
}
