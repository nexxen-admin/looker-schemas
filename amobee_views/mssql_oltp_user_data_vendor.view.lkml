view: mssql_oltp_user_data_vendor {
  sql_table_name: dbo.user_data_vendor (NOLOCK) ;;

  dimension: user_data_vendor_id {
    type: number
    primary_key: yes
    view_label: "Campaign"
    label: "Data Provider ID"
    sql: ${TABLE}.user_data_vendor_id ;;
    value_format_name: id
  }

  dimension: description {
    type: string
    view_label: "Campaign"
    label: "Data Provider Name"
    description: "{% if _explore._name == 'campaign_reference' %}Data Provider whose data is selected for targeting in the campaign, for advanced targeting.{% else %}Data Provider whose data is selected for targeting in the campaign.{% endif %}"
    sql:  COALESCE(${TABLE}.description, '') ;;
  }

  dimension: user_data_vendor_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.user_data_vendor_type_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }
}
