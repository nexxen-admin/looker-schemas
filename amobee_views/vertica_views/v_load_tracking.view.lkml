view: v_load_tracking {
  derived_table:{
    sql: select
                        START_TIMEZONE,END_TIMEZONE,SCHEMA_NAME,TABLE_NAME ,max(LOAD_THROUGH_DATE) as LOAD_THROUGH_DATE
                from   RAWDB.LOAD_TRACKING
                where
                          SCHEMA_NAME = 'RAWDB' AND
                         TABLE_NAME = 'HOURLY_ANALYTICS'
          group by START_TIMEZONE,END_TIMEZONE,SCHEMA_NAME,TABLE_NAME
      ;;}

  dimension: end_timezone {
    type: number
    hidden: yes
    sql: ${TABLE}.END_TIMEZONE ;;
  }

  dimension: load_through_date {
    type: date_raw
    hidden: yes
    sql: ${TABLE}.LOAD_THROUGH_DATE ;;
  }

  dimension: schema_name {
    type: string
    hidden: yes
    sql: ${TABLE}.SCHEMA_NAME ;;
  }

  dimension: start_timezone {
    type: number
    hidden: yes
    sql: ${TABLE}.START_TIMEZONE ;;
  }

  dimension: table_name {
    type: string
    hidden: yes
    sql: ${TABLE}.TABLE_NAME ;;
  }
}
