view: mssql_oltp_demo_composition_vendor {
  sql_table_name: dbo.demo_composition_vendor (NOLOCK) ;;

  dimension: demo_composition_vendor_id {
    type: number
    hidden: yes
    sql: ${TABLE}.demo_composition_vendor_id ;;
  }

  dimension: description {
    type: string
    hidden: yes
    view_label: "Campaign"
    label: "Universe"
    sql: ${TABLE}.description ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    label: "Active"
    sql: ${TABLE}.active ;;
  }

  dimension: demo_universe_localization_map {
    type: string
    hidden: yes
    sql: case when ${demo_composition_vendor_id} = 1 then 'VIDEOLOGY'
    when ${demo_composition_vendor_id} = 2 then 'NIELSEN'
    when ${demo_composition_vendor_id} = 3 then 'COMSCORE'
    when ${demo_composition_vendor_id} = 4 then 'ATT_LINEAR'
    when ${demo_composition_vendor_id} = 5 then 'ATT_ADDRESSABLE'
    when ${demo_composition_vendor_id} = 6 then 'BELL'
    when ${demo_composition_vendor_id} = 7 then 'ROGERS'
    when ${demo_composition_vendor_id} = 10 then 'BELL_SET_TOP_BOX'
    when ${demo_composition_vendor_id} = 11 then 'VIDEO_RESEARCH'
    when ${demo_composition_vendor_id} = 12 then 'SG_TAM'
    when ${demo_composition_vendor_id} = 13 then 'BELL_FIRST_PARTY_DATA_DYNAMIC_AUDIENCE_CREATION'
    when ${demo_composition_vendor_id} = 14 then 'BELL_NUMERIS_FRENCH_CANADA'
    when ${demo_composition_vendor_id} = 15 then 'PRE_BUILT_BELL_FIRST_PARTY_DATA_FRENCH_CANADA'
    when ${demo_composition_vendor_id} = 16 then 'BUILD_YOUR_OWN_BELL_FIRST_PARTY_DATA_FRENCH_CANADA'
    end ;;
  }
}
