view: platform_market {
  derived_table: {
    sql: select
            issue,
            string_agg(customvalue, ' - ' order by parentkey) as platform_market
         from (
            select
              cfv.issue,
              cfo.customvalue,
              coalesce(cfo.parentoptionid, 0) as parentkey
            from customfieldvalue cfv
            join customfieldoption cfo
              on cast(cfv.stringvalue AS integer) = cfo.id
            where cfv.customfield = 19645
         ) f
         group by issue
        ;;
  }

  dimension: issue {
    primary_key: yes
    type: number
    hidden:  yes
    sql: ${TABLE}.issue ;;
  }

  dimension: platform_market{
    label: "Platform Market"
    type: string
    sql: ${TABLE}.platform_market ;;
  }
}
