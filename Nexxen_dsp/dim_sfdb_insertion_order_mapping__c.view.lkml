# The name of this view in Looker is "Dim Sfdb Insertion Order Mapping C"
view: dim_sfdb_insertion_order_mapping__c {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_sfdb_insertion_order_mapping__c ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Atv Composite Key C" in Explore.

  dimension: atv_composite_key__c {
    type: string
    sql: ${TABLE}.atv_composite_key__c ;;
    hidden: yes
  }

  dimension: atv_insertion_order_id__c {
    type: number
    value_format_name: id
    sql: ${TABLE}.atv_insertion_order_id__c ;;
    hidden: yes
  }

  dimension: createdbyid {
    type: string
    sql: ${TABLE}.createdbyid ;;
    hidden: yes
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: createddate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.createddate ;;
    hidden: yes
  }

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

  dimension: dsp_composite_key__c {
    type: string
    sql: ${TABLE}.dsp_composite_key__c ;;
    hidden: yes
  }

  dimension: dsp_insertion_order_id__c {
    type: number
    value_format_name: id
    sql: ${TABLE}.dsp_insertion_order_id__c ;;
    hidden: yes
  }

  dimension_group: end_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    hidden: yes
    sql: ${TABLE}.end_date__c ;;
  }

  dimension: insertion_order_name__c {
    type: string
    sql: ${TABLE}.insertion_order_name__c ;;
  }

  dimension: isdeleted {
    type: number
    sql: ${TABLE}.isdeleted ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  dimension: lastmodifiedbyid {
    type: string
    sql: ${TABLE}.lastmodifiedbyid ;;
    hidden: yes
  }

  dimension_group: lastmodifieddate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.lastmodifieddate ;;
    hidden: yes
  }

  dimension: market__c {
    type: string
    sql: ${TABLE}.market__c ;;
    hidden: yes
  }

  dimension: name {
    type: string
    sql: ${TABLE}."name" ;;
    hidden: yes
  }

  dimension: opportunity__c {
    type: string
    sql: ${TABLE}.opportunity__c ;;
    hidden: yes
  }

  dimension: opportunity_line_item__c {
    type: string
    sql: ${TABLE}.opportunity_line_item__c ;;
    hidden: yes
  }

  dimension: ownerid {
    type: string
    sql: ${TABLE}.ownerid ;;
    hidden: yes
  }

  dimension_group: start_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    hidden: yes
    sql: ${TABLE}.start_date__c ;;
  }

  dimension_group: systemmodstamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    hidden: yes
    sql: ${TABLE}.systemmodstamp ;;
  }
  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
