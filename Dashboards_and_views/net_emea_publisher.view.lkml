
view: net_emea_publisher {
  derived_table: {
    sql: select Date_trunc('month', date_key)::date  as Month_Year,
      p.pub_id,
      --(TO_CHAR(DATE_TRUNC('month', Date_Key), 'YYYY-MM')) AS Month_Year,
      sum(sum_of_revenue) as revenue_uk,
      sum(sum_of_cogs) as cogs_uk
      from
          bi_new.Fact_Ad_Daily_Agg agg
          INNER JOIN bi_new.Dim_Country c ON agg.Country_Key = c.Country_Key
          INNER JOIN bi_new.Dim_Publisher_SSP ssp ON agg.PUB_SSP_Key = ssp.PUB_SSP_Key
          INNER JOIN bi_new.Dim_Publisher p ON ssp.PUB_Key = p.PUB_Key
      where date_key>='2024-01-01' and p.pub_id in ('101188','103354','81409','101593','103661','103022','105847','84996','76872','103149','103281','78223') and region ilike 'EMEA'
      group by 1,2 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: month_year {
    type: date
    sql: ${TABLE}.Month_Year ;;
  }

  dimension: pub_id {
    type: string
    sql: ${TABLE}.pub_id ;;
  }

  measure: revenue_uk {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.revenue_uk ;;
  }

  measure: cogs_uk {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.cogs_uk ;;
  }

  measure: net_revenue_uk {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.revenue_uk-${TABLE}.cogs_uk ;;
  }

  set: detail {
    fields: [
        month_year,
  pub_id,
  revenue_uk,
  cogs_uk
    ]
  }
}
