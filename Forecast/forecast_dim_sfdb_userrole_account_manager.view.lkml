view: forecast_dim_sfdb_userrole_account_manager{
  sql_table_name: BI_DSP.dim_sfdb_userrole ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }
  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
  }
  dimension: developername {
    type: string
    sql: ${TABLE}.developername ;;
  }
  dimension: isdeleted {
    type: number
    sql: ${TABLE}.isdeleted ;;
  }
  dimension: lastmodifiedbyid {
    type: string
    sql: ${TABLE}.lastmodifiedbyid ;;
  }
  dimension_group: lastmodifieddate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.lastmodifieddate ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}."name" ;;
  }
  dimension: parentroleid {
    type: string
    sql: ${TABLE}.parentroleid ;;
  }
  dimension: rollupdescription {
    type: string
    sql: ${TABLE}.rollupdescription ;;
  }
  dimension_group: systemmodstamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.systemmodstamp ;;
  }
  measure: count {
    type: count
    drill_fields: [id, developername, name]
  }
}
