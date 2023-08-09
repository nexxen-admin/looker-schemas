view: peerlogix_try {
  derived_table: {
    sql:

with update_table as (
insert into bi.oren_temp
select *
from bi.oren_temp
limit 1)

      select col_1
      from bi.oren_temp

      ;;
  }


  dimension: col_1 {
    type: string
    sql: ${TABLE}."col_1" ;;
  }





  set: detail {
    fields: [col_1]
  }
}
