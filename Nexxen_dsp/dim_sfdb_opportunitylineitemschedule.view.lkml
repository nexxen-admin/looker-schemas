# The name of this view in Looker is "Dim Sfdb Opportunitylineitemschedule"
view: dim_sfdb_opportunitylineitemschedule {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_sfdb_opportunitylineitemschedule ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    hidden: yes
  }


  dimension: is_mismatch{
    type: string
    sql: case when ${id} = 'Unknown' then 'Mismatch' else 'Valid' end ;;
    hidden: yes

  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Actualized C" in Explore.

  dimension: actualized__c {
    type: number
    sql: ${TABLE}.actualized__c ;;
    hidden: yes
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }


  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
    hidden: yes
  }

  dimension_group: end_date__c {
    type: time
    label: "SF Line Item End"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.end_date__c ;;
    hidden: yes
  }

  dimension: is_deleted {
    type: number
    sql: ${TABLE}.is_deleted ;;
    hidden: yes
  }

  dimension: is_free__c {
    type: number
    sql: ${TABLE}.is_free__c ;;
    hidden: yes
  }

  dimension_group: lastmodifieddate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.lastmodifieddate ;;
    hidden: yes
  }

  dimension: opportunitylineitemid {
    type: string
    label: "Salesforce Line Item ID"
    sql: ${TABLE}.opportunitylineitemid ;;

  }

  dimension: opportunitylineitemschedule_key {
    type: number
    sql: ${TABLE}.opportunitylineitemschedule_key ;;
    hidden: yes
  }

  dimension: revenue {
    type: number
    label: "Spend"
    sql: ${TABLE}.revenue ;;
    #hidden: yes
  }


  dimension_group: scheduledate {
    type: time
    label: "SF Line Item Start"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.scheduledate ;;
    hidden: yes
  }

  dimension_group: systemmodstamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.systemmodstamp ;;
    hidden: yes
  }

  dimension: useredits__c {
    type: number
    sql: ${TABLE}.useredits__c ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [id]
    hidden: yes
  }

}
