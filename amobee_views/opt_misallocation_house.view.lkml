view: misallocation_house {
  sql_table_name:
    (SELECT keydate,
       partner_name,
       Sum(house)                          AS house,
       Sum(house_forecast)                 AS house_forecast,
       Sum(house * payout) / 1000          AS house_cost,
       Sum(house_forecast * payout) / 1000 AS house_forecast_cost
FROM   (SELECT keydate,
               partner_name,
               Sum(house)               AS house,
               Sum(m) - Sum(allocation) AS house_forecast,
               payout
        FROM   (SELECT keydate,
                       p.placement_id,
                       p.placement_name,
                       pa.partner_name,
                       Max(m_forecast)      AS m,
                       Sum(mean_allocation) AS allocation,
                       Sum(CASE
                             WHEN ca.isfiller = 1 THEN impressions
                             ELSE 0
                           END)             AS house,
                       Max(payout)          AS payout
                FROM   an_research..opt_misdelivery (nolock) a
                       JOIN an_main..placement p (nolock)
                         ON p.placement_id = a.placement_id
                            AND p.passback_allowed = 0
                       JOIN an_main..partner (nolock) pa
                         ON pa.partner_id = p.partner_id
                            AND {% condition publisher_id) %} pa.partner_id {% endcondition %}
                       JOIN an_main..campaign ca (nolock)
                         ON ca.campaign_id = a.campaign_id
                       JOIN (SELECT placement_id,
                                    Max(cpu) AS payout
                             FROM   an_main..placement_payout_schedule (nolock)
                             WHERE  end_datetm > Getdate()
                             GROUP  BY placement_id) pp
                         ON pp.placement_id = p.placement_id
                GROUP  BY keydate,
                          p.placement_name,
                          p.placement_id,
                          partner_name) pid_house
        GROUP  BY keydate,
                  partner_name,
                  payout) a
GROUP  BY keydate,
          partner_name )
 ;;


  filter: publisher_id {
    type: number
    description: "Some common IDs: GM - STV (365), GM - Five TV (384), GM - ITV (388), GM - Channel 4 (475) "
  }

  dimension: keydate {
    type: date
    primary_key: yes
    sql: ${TABLE}.keydate ;;
    hidden: yes
  }

  dimension: partner_name {
    type: string
    label: "Publisher"
    primary_key: no
    sql: ${TABLE}.partner_name ;;
  }

  measure: house {
    type: sum
    value_format_name: decimal_0
    label: "House Impressions"
    description: "Number of house impressions"
    sql: ${TABLE}.house ;;
  }

  measure: house_forecast {
    type: sum
    value_format_name: decimal_0
    label: "House Impressions Forecasted"
    description: "Number of house impressions forecasted"
    sql: ${TABLE}.house_forecast ;;
  }

  measure: house_cost {
    type: sum
    label: "House Cost"
    description: "Cost of the served house impressions"
    value_format_name: gbp
    sql: ${TABLE}.house_cost ;;
  }

  measure: house_forecast_cost {
    type: sum
    label: "House Forecast Cost"
    description: "Cost of house forecasted"
    value_format_name: gbp
    sql: ${TABLE}.house_forecast_cost ;;
  }

  dimension_group: utc_date {
    type: time
    label: "House Metric"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: yes
    description: "Date to be used for pulling house metric data"
    sql: ${TABLE}.keydate ;;
  }
}
