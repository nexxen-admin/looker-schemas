view: v_campaign_target_description {
  sql_table_name: DIM.CAMPAIGN_TARGET_DESCRIPTION_VIEW ;;

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: campaignaddons {
    type: string
    hidden: yes
    sql: ${TABLE}.CAMPAIGNADDONS ;;
  }

  dimension: campaigndemos {
    type: string
    label: "Demo Targets"
    view_label: "Campaign"
    sql: ${TABLE}.CAMPAIGNDEMOS ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.campaigndemos
  }

  dimension: campaignobjectives {
    type: string
    hidden: yes
    sql: ${TABLE}.CAMPAIGNOBJECTIVES ;;
  }

  dimension: contextualtargets {
    type: string
    hidden: yes
    sql: ${TABLE}.CONTEXTUALTARGETS ;;
  }

  dimension: dayparttargets {
    type: string
    label: "Daypart Targets"
    view_label: "Campaign"
    sql: ${TABLE}.DAYPARTTARGETS ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.dayparttargets
  }

  dimension: devicetargets {
    type: string
    hidden: yes
    sql: ${TABLE}.DEVICETARGETS ;;
  }

  dimension: domainexttargets {
    type: string
    hidden: yes
    sql: ${TABLE}.DOMAINEXTTARGETS ;;
  }

  dimension: domaintargets {
    type: string
    hidden: yes
    sql: ${TABLE}.DOMAINTARGETS ;;
  }

  dimension: geotargets {
    type: string
    label: "Geo Targets"
    view_label: "Campaign"
    sql: ${TABLE}.GEOTARGETS ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.geotargets
  }

  dimension: isptargets {
    type: string
    hidden: yes
    sql: ${TABLE}.ISPTARGETS ;;
  }

  dimension: languagetargets {
    type: string
    hidden: yes
    sql: ${TABLE}.LANGUAGETARGETS ;;
  }

  dimension: negcontextualtargets {
    type: string
    hidden: yes
    sql: ${TABLE}.NEGCONTEXTUALTARGETS ;;
  }

  dimension: negdayparttargets {
    type: string
    hidden: yes
    sql: ${TABLE}.NEGDAYPARTTARGETS ;;
  }

  dimension: negdevicetargets {
    type: string
    hidden: yes
    sql: ${TABLE}.NEGDEVICETARGETS ;;
  }

  dimension: negdomainexttargets {
    type: string
    hidden: yes
    sql: ${TABLE}.NEGDOMAINEXTTARGETS ;;
  }

  dimension: negdomaintargets {
    type: string
    hidden: yes
    sql: ${TABLE}.NEGDOMAINTARGETS ;;
  }

  dimension: neggeotargets {
    type: string
    hidden: yes
    sql: ${TABLE}.NEGGEOTARGETS ;;
  }

  dimension: negisptargets {
    type: string
    hidden: yes
    sql: ${TABLE}.NEGISPTARGETS ;;
  }

  dimension: neglanguagetargets {
    type: string
    hidden: yes
    sql: ${TABLE}.NEGLANGUAGETARGETS ;;
  }

  dimension: negpcvtargets {
    type: string
    hidden: yes
    sql: ${TABLE}.NEGPCVTARGETS ;;
  }

  dimension: negretargtargets {
    type: string
    hidden: yes
    sql: ${TABLE}.NEGRETARGTARGETS ;;
  }

  dimension: negsgtargets {
    type: string
    hidden: yes
    sql: ${TABLE}.NEGSGTARGETS ;;
  }

  dimension: pcvtargets {
    type: string
    hidden: yes
    sql: ${TABLE}.PCVTARGETS ;;
  }

  dimension: sgtargets {
    type: string
    hidden: yes
    sql: ${TABLE}.SGTARGETS ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
