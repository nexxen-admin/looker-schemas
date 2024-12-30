# The name of this view in Looker is "Dim Dsp Advertiser"
view: dim_dsp_format {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_dsp_format ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Advertiser ID" in Explore.

  dimension: format_id {
    type: number
    sql: ${TABLE}.format_key ;;
    hidden: yes
  }

  dimension: format {
    type: string
    sql: ${TABLE}.format ;;
  }
  }
